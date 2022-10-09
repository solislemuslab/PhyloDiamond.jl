"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
include("./scripts/julia/test_invariants.jl")
"""

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics

function main()
    path = "."
    # list of networks with more than 8 species for testing
    N_list = [[("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")], #2223
    [("1", "na"), ("3", "4"), ("5", "6"), ("7", "8", "9", "2")], #1224
    [("1", "2"), ("3", "na"), ("5", "6"), ("7", "8", "9", "4")]] #2124
    N_strc = ["2223", "1224", "2124"]
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
    
    
    
end

function test_all_possible_sub_nw(N, cf, path, message)
    file = open(path*"/rst.txt", "a")
    write(file, "========================================================\n") 
    write(file, message*"\n")
    write(file, "Actual Structure: " * N_to_str(N) * "\n")
    rst_net = [] 
    rst_inv = []
    t = N_to_t(N)

    sub_all = subnetwork(N) #list of subnetworks with 6, 7, 8 species
    for temp in sub_all
        net_all = list_nw(temp) #all possible permutation of the given network
        df = DataFrame()
        for i in 1:length(net_all)
            colname = N_to_str(net_all[i])
            val = test_invariants(net_all[i], cf)
            push!(val, mean(filter(!isnan, val)))
            df[!,colname] = val
        end
        insertcols!(df, 1, :row => ["1112","1121","1211","2111","1122","1212","2112","2211","2121","1221","1222","2212", "2122", "2221", "2222", "mean"])
        
        inv_mean =Matrix(df)[end,:][2:end]
        net_all_sorted = net_all[sortperm(inv_mean)]

        #write(file, N_to_str(net_all_sorted[1])*": "*string(inv_mean[1])*"\n")
        push!(rst_inv, inv_mean[1])
        push!(rst_net, net_all_sorted[1])
    end

    #find the all the missing species for the subnetwork with smallest invariants
    order = sortperm(rst_inv)
    top_t = N_to_t(rst_net[order[1]])
    write(file, "Top subnetwork: " * N_to_str(rst_net[order[1]]) * " (" * string(rst_inv[order[1]]) * ")" * "\n")
    mis_species = []
    for i in t
        if !(i in top_t)
            push!(mis_species, i)
        end
    end

    #add missing species to the subnetwork with smallest invariants
    for mis in mis_species
        flag = false #whether the missing species is found
        #find the position of the missing species in the next smallest-inv subnetworks
        for next_net in 2:length(order)
            for i in 1:4
                if mis in rst_net[order[next_net]][i]
                    write(file, "Missing species " * string(mis) * " from " * N_to_str(rst_net[order[next_net]]) * " (" * string(rst_inv[order[next_net]]) * ")" * "\n")
                    push!(rst_net[order[1]][i], mis)
                    flag = true
                end
            end

            if flag #skip to proceed to the next missing species
                break
            end
        end
    end

    write(file, "SELECTED: " * N_to_str(rst_net[order[1]]) * "\n")
    
    close(file)
end

"""
    For the given network N with more than 8 taxon, find a list of taxon in subnetworks with 8, 7, 6 taxon
    subnetwork([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")])
    -> ["1", "2", "3", "4", "5", "7"], ["1", "2", "3", "4", "5", "8"], ["1", "2", "3", "4", "5", "9"]...["2", "3", "4", "5", "6", "8", "9"], ["1", "2", "3", "4", "5", "6", "7", "8"]
"""
function subnetwork(N)
    t = N_to_t(N)
    ind_all = vcat([collect(combinations(1:length(t),i)) for i=6:8]...) #select all combination of 6, 7, 8 indexes for N
    ret = []
    
    for net_i in ind_all
        t_cnt = [0, 0, 0, 0] #
        sub_N = [[], [], [], []]
        for t_i in net_i
            if t[t_i] in N[4]
                t_cnt[4] = t_cnt[4]+1
                push!(sub_N[4], t[t_i])
            elseif t[t_i] in N[1]
                t_cnt[1] = t_cnt[1]+1
                push!(sub_N[1], t[t_i])
            elseif t[t_i] in N[2]
                t_cnt[2] = t_cnt[2]+1
                push!(sub_N[2], t[t_i])
            else
                t_cnt[3] = t_cnt[3]+1
                push!(sub_N[3], t[t_i])
            end
        end

        if t_cnt[4] > 0 && t_cnt[1] > 0 && t_cnt[2] > 0 && t_cnt[3] > 0 && 
            t_cnt[4] < 3 && t_cnt[1] < 3 && t_cnt[2] < 3 && t_cnt[3] < 3
            push!(ret, N_to_t(sub_N))
        end
    end
    return ret
end

main()