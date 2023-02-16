include("mapping.jl")
include("invariants.jl")
include("helper.jl")

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics, StatsBase

"""
    Implement PhyloDiamond algorithm (input cf table)
    input:
        cf: concordance factor table (first 4 columns should be taxon names, last 3 columns should be cf values)
        m: the number of optimal phylogenetic networks returned
        output_filename: a file name for the output file (or "phylo_diamond.txt" by default)
    output:
        top m optimal phylogenetic networks
"""
function phylo_diamond(cf::DataFrame, m::Int64, output_filename::String="phylo_diamond.txt")
    cf = rename!(cf,[:tx1,:tx2, :tx3, :tx4, :expCF12,:expCF13,:expCF14])
    t = cf_to_t(cf) #get all taxon names

    if size(cf, 1) != binomial(length(t), 4) || size(cf, 2) != 7 #check the dimension of cf table
        error("Please provide a complete cf table")
    end

    cf, value_map = taxon_dict(cf) #rename taxon to numbers

    if length(t) <= 5
        error("PhyloDiamond only accept more than 5 taxon")
    elseif length(t) <= 8
        phylo_diamond_no_more_than_8_helper(cf, m, output_filename, value_map)
    else
        phylo_diamond_more_than_8_helper(cf, m, output_filename, value_map)
    end
end

"""
    Implement PhyloDiamond algorithm (input gene tree file)
    input:
        gene_trees_filename
        m: the number of optimal phylogenetic networks returned
        output_filename: a file name for the output file (or "phylo_diamond.txt" by default)
    output:
        top m optimal phylogenetic networks
"""
function phylo_diamond(gene_trees_filename::String, m::Int64, output_filename::String="phylo_diamond.txt")
    cf = generate_cf_from_gene_trees(gene_trees_filename)
    t = cf_to_t(cf)
    cf, value_map = taxon_dict(cf)

    if length(t) <= 5
        error("PhyloDiamond only accept more than 5 taxon")
    elseif length(t) <= 8
        phylo_diamond_no_more_than_8_helper(cf, m, output_filename, value_map)
    else
        phylo_diamond_more_than_8_helper(cf, m, output_filename, value_map)
    end
end

"""
    helper function to handle no more than 8 taxa
    input:
        cf: cf table
        m: the number of optimal phylogenetic networks returned
        output_filename: input a filename if users need to save output to a file; otherwise leave it blank or ""
        newick: return networks in newick format if true; otherwise [(1,2),(3,4),(5,6),(7,8,9)]
        value_map: the dictionary of taxa to numbers
    output:
        top m optimal phylogenetic networks
"""
function phylo_diamond_no_more_than_8_helper(cf, m, output_filename, value_map)
    t = cf_to_t(cf)
    net_all = list_nw(t)
    inv_mean_sorted, net_all_sorted = get_inv_for_nw(net_all, cf)

    return phylo_diamond_output_helper(inv_mean_sorted[1:m], net_all_sorted[1:m], m, t, value_map, output_filename)
end

"""
    helper function to handle more than 8 taxa
    input:
        cf: cf table
        m: the number of optimal phylogenetic networks returned
        output_filename: input a filename if users need to save output to a file; otherwise leave it blank or ""
        newick: return networks in newick format if true; otherwise [(1,2),(3,4),(5,6),(7,8,9)]
        value_map: the dictionary of taxa to numbers
    output:
        top m optimal phylogenetic networks
"""
function phylo_diamond_more_than_8_helper(cf, m, output_filename, value_map)
    t = cf_to_t(cf)
    sub_all = subnetwork(t) #all possible subpermutation of the given network
    inv_mean_sorted, subnet_all_sorted = get_inv_for_nw(sub_all, cf)
    str = ""
    rst_net = []
    rst_inv = []
    
    for i in 1:length(subnet_all_sorted)
        #find the all the missing species for the subnetwork with smallest invariants
        top_t = N_to_t(subnet_all_sorted[i])
        mis_species = []
        for i in t
            if !(i in top_t)
                push!(mis_species, i)
            end
        end

        net = add_mis_species(mis_species, subnet_all_sorted[i:end]) #when selecting other top networks, remove the first few network information
        if !(net in rst_net)
            push!(rst_net, net)
            push!(rst_inv, inv_mean_sorted[i])
        end
        if length(rst_net) == m
            break
        end
    end

    return phylo_diamond_output_helper(rst_inv, rst_net, m, t, value_map, output_filename)
end

"""
    input:
        mis_species: the taxa missing from the subnetwork
        net_all_sorted: a list of all possible networks sorted by the invariant values
    output: add missing species to the subnetwork with smallest invariants
"""
function add_mis_species(mis_species, net_all_sorted)
    rst = net_all_sorted[1]
    n1 = net_all_sorted[1]
    for mis in mis_species
        flag = false #whether the missing species is found
        #find the position of the missing species in the next smallest-inv subnetworks
        for next_net in 2:length(net_all_sorted)
            for i in 1:4
                if mis in net_all_sorted[next_net][i]
                    n2 = net_all_sorted[next_net]
                    if n1[1][1] in n2[1] && n1[1][2] in n2[1] && n1[4][1] in n2[4] && n1[4][2] in n2[4]
                        if n1[3][1] in n2[2] && n1[3][2] in n2[2] && 
                            (n2[3][1] in n1[2] || n2[3][2] in n1[2])
                            push!(rst[2], mis)
                            flag = true
                        elseif n1[2][1] in n2[3] && n1[2][2] in n2[3] &&
                            n2[2][1] in n1[3] || n2[2][2] in n1[3]
                            push!(rst[3], mis)
                            flag = true
                        end
                    else
                        push!(rst[i], mis)
                        flag = true
                    end
                end
            end

            if flag #skip to proceed to the next missing species
                break
            end
        end
    end

    for i in 1:4
        rst[i] = sort(rst[i]; alg=QuickSort)
    end
    return rst
end

"""
    (assuming all taxon are denoted by number starting from 1)
    For the given network N with more than 8 taxon, find a list of taxon in subnetworks with 8 taxon
    subnetwork([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")])
    -> ["2", "3", "4", "5", "6","7", "8", "9"], ["1", "2", "3", "4", "5", "6", "7", "8"]...
"""
function subnetwork(t)
    ind_all = vcat([collect(combinations(1:length(t),i)) for i=8:8]...) #select all combination of 6, 7, 8 indexes for N
    ret = []
    
    for net_i in ind_all #iterate through all subnetworks
        ret = vcat(ret, list_nw(string.(net_i)))
    end
    return ret
end

"""
    input:
        N: array of tuples, individuals from each triangles of the network
        cf: the expected CF table
    output: an array of norm of invariants (we expect the value to be small if it is the correct network)
"""
function test_invariants(N, cf)
    a = get_a(cf, N)

    return [norm(inv_net1112(a)), 
    norm(inv_net1121(a)),
    norm(inv_net1211(a)),
    norm(inv_net2111(a)),
    norm(inv_net1122(a)),
    norm(inv_net1212(a)),
    norm(inv_net2112(a)),
    norm(inv_net2211(a)),
    norm(inv_net2121(a)),
    norm(inv_net1221(a)),
    norm(inv_net1222(a)),
    norm(inv_net2212(a)),
    norm(inv_net2122(a)),
    norm(inv_net2221(a)),
    norm(inv_net2222(a))]
end

"""
    input:
        inv_mean_sorted: a sorted list of invariant values for each network
        net_all_sorted: a list of all possible networks sorted by the invariant values
        newick: return networks in newick format if true; otherwise [(1,2),(3,4),(5,6),(7,8,9)]
        value_map: the dictionary of taxa to numbers
    output:
        a formatted string of optimal networks (net_all_sorted)
"""
function phylo_diamond_output_helper(inv_mean_sorted, net_all_sorted, m, t, value_map, output_filename)
    value_map = Dict(value => key for (key, value) in value_map)
    str = "Inference of top " * string(m) * " " * string(length(t)) * "-taxon phylogenetic networks with phylogenetic invariants\n"
    rank = tiedrank(inv_mean_sorted)
    ret = []

    for i in 1:length(net_all_sorted)
        # use the original taxon names according to value_map
        for a in 1:length(net_all_sorted[i])
            for b in 1:length(net_all_sorted[i][a])
                if net_all_sorted[i][a][b] != "na"
                    net_all_sorted[i][a][b] = value_map[net_all_sorted[i][a][b]]
                end
            end
        end
        newick = N_to_network(net_all_sorted[i])
        push!(ret, newick)
        str = str * string(Int(round(rank[i]))) * ". N" * N_to_N_num(net_all_sorted[i]) * " (" * string(inv_mean_sorted[i]) * ")" *
        "\n" * N_to_str(net_all_sorted[i]) *
        "\n\"" * newick * "\"\n" 
    end

    file = open(output_filename, "a")
    write(file, str)
    close(file)

    print(str)

    return Dict(zip(1:m, ret))
end

"""
    input:
        net_all: a list of all possible networks
        cf: cf table
    output:
        inv_mean_sorted: a sorted list of invariant values for each network
        net_all_sorted: a list of all possible networks sorted by the invariant values
"""
function get_inv_for_nw(net_all, cf)
    rst_inv = []
    for i in 1:length(net_all)
        val = test_invariants(net_all[i], cf)
        push!(rst_inv, mean(filter(!isnan, val)))
    end

    order = sortperm(rst_inv)
    inv_mean_sorted = rst_inv[order]
    net_all_sorted = net_all[order]
    return inv_mean_sorted, net_all_sorted
end

"""
    input: cf table
    output: replace original taxon names with numbers in the cf table and a mapping from taxon names to numbers
"""
function taxon_dict(cf)
    taxon = cf_to_t(cf)
    value_map = Dict(taxon[i] => string(i) for i in 1:length(taxon))
    for col in ["tx1", "tx2", "tx3", "tx4"]
        for i in 1:nrow(cf)
            cf[i,col] = string(value_map[cf[i,col]])
        end
    end
    return cf, value_map
end