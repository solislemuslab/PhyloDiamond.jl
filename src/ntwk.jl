include("mapping.jl")
include("invariants.jl")
include("helper.jl")

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics

function phylo_diamond(cf::DataFrame, m::Int64; output_filename=nothing)
    t = cf_to_t(cf)
    #rename taxon to numbers

    if length(t) <= 5
        print("PhyloDiamond only accept more than 5 taxon\n")
        return
    elseif length(t) <= 8
        phylo_diamond_no_more_than_8_helper(cf, m, output_filename)
    else
        phylo_diamond_more_than_8_helper(cf, m, output_filename)
    end
end

function phylo_diamond(gene_trees_filename::String, m::Int64; output_filename=nothing)
    t = cf_to_t(generate_cf_from_gene_trees(gene_trees_filename))
    #rename taxon to numbers

    if length(t) <= 5
        print("PhyloDiamond only accept more than 5 taxon\n")
        return
    elseif length(t) <= 8
        phylo_diamond_no_more_than_8_helper(cf, m, output_filename)
    else
        phylo_diamond_more_than_8_helper(cf, m, output_filename)
    end
end

"""
input:
    N: [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
    cf: cf table
output:
    a dataframe of invariant values where each column is each possible network of n taxa, 
    the last row is the average of all invariants
    the true network is N
"""
function phylo_diamond_no_more_than_8_helper(cf, m, output_filename)
    str = ""
    t = cf_to_t(cf)
    net_all = list_nw(t)

    df = DataFrame() #storing the invariant values of each possible nw
    
    for i in 1:length(net_all)
        colname = N_to_str(net_all[i])
        val = test_invariants(net_all[i], cf)
        push!(val, mean(filter(!isnan, val)))
        df[!,colname] = val
    end
    insertcols!(df, 1, :row => ["1112","1121","1211","2111","1122","1212","2112","2211","2121","1221","1222","2212", "2122", "2221", "2222", "mean"])
    
    inv_mean =Matrix(df)[end,:][2:end]
    net_all_sorted = net_all[sortperm(inv_mean)]
    inv_mean_sorted = inv_mean[sortperm(inv_mean)]

    for i in 1:m
        str = str*string(sort(inv_mean, rev=false)[1:m][i]) * ": " * N_to_str(net_all[sortperm(inv_mean)[1:m][i]]) * "\n"
    end

    if output_filename !== nothing
        file = open(output_filename, "a")
        write(file, str)
        close(file)
    end
    return str
end

function phylo_diamond_more_than_8_helper(cf, m, output_filename)
    str = ""
    t = cf_to_t(cf)
    sub_all = subnetwork(t) #all possible subpermutation of the given network
    
    rst_inv = []
    for i in 1:length(sub_all)
        val = test_invariants(sub_all[i], cf)
        push!(rst_inv, mean(filter(!isnan, val)))
    end
    order = sortperm(rst_inv)
    rst_inv_sorted = rst_inv[order]
    net_all_sorted = sub_all[order]

    rst = []
    for i in 1:length(net_all_sorted)
        #find the all the missing species for the subnetwork with smallest invariants
        top_t = N_to_t(net_all_sorted[i])
        mis_species = []
        for i in t
            if !(i in top_t)
                push!(mis_species, i)
            end
        end

        net = add_mis_species(mis_species, net_all_sorted[i:end]) #when selecting other top networks, remove the first few network information
        if !(net in rst)
            push!(rst, net)
            str = str * N_to_str(net)* ": " * " (" * string(rst_inv_sorted[i]) * ")" * "\n"
        end
        if length(rst) == m
            break
        end
    end

    if output_filename !== nothing
        file = open(output_filename, "a")
        write(file, str)
        close(file)
    end

    return str
end

function add_mis_species(mis_species, net_all_sorted)
    #add missing species to the subnetwork with smallest invariants
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
    #ind_all = vcat([collect(combinations(1:length(t),i)) for i=6:8]...) #select all combination of 6, 7, 8 indexes for N
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