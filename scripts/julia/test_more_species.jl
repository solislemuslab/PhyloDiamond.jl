"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
include("./scripts/julia/test_invariants.jl")
"""

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics

function main()
    path = "."
    """
    N_list = [
    [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8","9")],
    [("1", "2","9"), ("3", "4"), ("5", "6"), ("7", "8")],
    [("1", "2"), ("3", "4","9"), ("5", "6"), ("7", "8")],
    [("1", "2"), ("3", "4"), ("5", "6","9"), ("7", "8")],

    [("1", "2"), ("3", "4"), ("5", "6","10"), ("7", "8","9")],
    [("1", "2"), ("3", "4","10"), ("5", "6"), ("7", "8","9")],
    [("1", "2","10"), ("3", "4"), ("5", "6"), ("7", "8","9")],
    [("1", "2"), ("3", "4","10"), ("5", "6","9"), ("7", "8")],
    [("1", "2","9"), ("3", "4"), ("5", "6","10"), ("7", "8")],
    [("1", "2","9"), ("3", "4","10"), ("5", "6"), ("7", "8")],

    [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8","9","10")],
    [("1", "2"), ("3", "4"), ("5", "6","9","10"), ("7", "8")],
    [("1", "2"), ("3", "4","9","10"), ("5", "6"), ("7", "8")],
    [("1", "2","9","10"), ("3", "4"), ("5", "6"), ("7", "8")],
    ]
    for i in 1:length(N_list)
        print(i)
        test_all_possible_sub_nw(N_list[i], generate_cf(N_list[i], 0), path, "True concordance factor table")
    end
    
    
    path = "."
    # list of networks with more than 8 species for testing
    N_list = [[("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")]] #2223
    #[("1", "na"), ("3", "4"), ("5", "6"), ("7", "8", "9", "2")], #1224
    #[("1", "2"), ("3", "na"), ("5", "6"), ("7", "8", "9", "4")], #2124
    #[("1", "2"), ("3", "4"), ("5", "6", "7", "8"), ("9", "na")]] #2241
    N_strc = ["2223", "1224", "2124", "2241"]
    for i in 1:length(N_list)
        test_all_possible_sub_nw(N_list[i], generate_cf(N_list[i], 0), path, "True concordance factor table")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/100/sim_trees_" *N_strc[i]*"_100_1"),
        path, N_strc[i]*" True gene tree (100)")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/1000/sim_trees_" *N_strc[i]*"_1000_1"),
        path, N_strc[i]*" True gene tree (1000)")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/10000/sim_trees_" *N_strc[i]*"_10000_1"),
        path, N_strc[i]*" True gene tree (10000)")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/estimated_gene_trees_1000/" *N_strc[i]*"_l500_1"),
        path, N_strc[i]*" Estimated gene tree (1000, l500)")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/estimated_gene_trees_1000/" *N_strc[i]*"_l2000_1"),
        path, N_strc[i]*" Estimated gene tree (1000, l2000)")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/estimated_gene_trees_10000/" *N_strc[i]*"_l500_1"),
        path, N_strc[i]*" Estimated gene tree (10000, l500)")
        test_all_possible_sub_nw(N_list[i], generate_cf_from_gene_trees("./simulation/sim_trees/estimated_gene_trees_10000/" *N_strc[i]*"_l2000_1"),
        path, N_strc[i]*" Estimated gene tree (10000, l2000)")
    
    end  
    """
end

function test_all_possible_sub_nw(N, cf, path, message)
    file = open(path*"/rst_dog.txt", "a")
    write(file, "========================================================\n") 
    write(file, message*"\n")
    write(file, "Actual Structure: " * N_to_str(N) * "\n")
    t = N_to_t(N)

    sub_all = subnetwork(N) #all possible subpermutation of the given network
    
    rst_inv = []
    for i in 1:length(sub_all)
        val = test_invariants(sub_all[i], cf)
        push!(rst_inv, mean(filter(!isnan, val)))
    end
    order = sortperm(rst_inv)
    rst_inv_sorted = rst_inv[order]
    net_all_sorted = sub_all[order]

    for i in 1:10
        write(file, N_to_str(net_all_sorted[i]) * ": " * " (" * string(rst_inv_sorted[i]) * ")" * "\n")
    end

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

        net = add_mis_species(mis_species, net_all_sorted[i:end])
        if !(net in rst)
            push!(rst, net)
            write(file, "SELECTED: " * N_to_str(net) * "\n")
        end
        if length(rst) == 3
            break
        end
    end

    
    close(file)
end

"""
    mis_species = ["9", "10"]
    net_all_sorted = [[("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")],
                      [("1", "2"), ("3", "4"), ("5", "6"), ("7", "9")],
                      [("1", "2"), ("3", "4"), ("5", "6"), ("7", "10")]]
    add_mis_species(mis_species, net_all_sorted) = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9", "10")]
"""
function add_mis_species(mis_species, net_all_sorted)
    #add missing species to the subnetwork with smallest invariants
    rst = net_all_sorted[1]
    for mis in mis_species
        flag = false #whether the missing species is found
        #find the position of the missing species in the next smallest-inv subnetworks
        for next_net in 2:length(net_all_sorted)
            for i in 1:4
                if mis in net_all_sorted[next_net][i]
                    #write(file, "Missing species " * string(mis) * " from " * N_to_str(rst_net[order[next_net]]) * " (" * string(rst_inv[order[next_net]]) * ")" * "\n")
                    push!(rst[i], mis)
                    flag = true
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
function subnetwork(N)
    t = N_to_t(N)
    #ind_all = vcat([collect(combinations(1:length(t),i)) for i=6:8]...) #select all combination of 6, 7, 8 indexes for N
    ind_all = vcat([collect(combinations(1:length(t),i)) for i=8:8]...) #select all combination of 6, 7, 8 indexes for N
    ret = []
    
    for net_i in ind_all #iterate through all subnetworks
        ret = vcat(ret, list_nw(string.(net_i)))
    end
    return ret
end

main()