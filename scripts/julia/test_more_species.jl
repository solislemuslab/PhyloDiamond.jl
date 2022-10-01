"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
include("./scripts/julia/test_invariants.jl")
"""

using PhyloNetworks
using PhyloPlots
using DataFrames
using CSV, Statistics, Distributions, Random
using DelimitedFiles

function main()
    path = "."
    file = open(path*"/rst.txt", "a")
    N_list = [[("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")],
              [("1", "2", "9"), ("3", "4"), ("5", "6"), ("7", "8")],
              [("1", "2"), ("3", "4", "9"), ("5", "6"), ("7", "8")],
              [("1", "2"), ("3", "4"), ("5", "6", "9"), ("7", "8")],
              [("1", "na"), ("3", "4"), ("5", "6"), ("7", "8", "9", "2")],
              [("1", "2"), ("3", "na"), ("5", "6"), ("7", "8", "9", "4")],
              [("1", "2"), ("3", "4"), ("5", "na"), ("7", "8", "9", "6")],
              [("1", "2"), ("3", "4", "6"), ("5", "na"), ("7", "8", "9")],
              [("1", "2", "6"), ("3", "4"), ("5", "na"), ("7", "8", "9")],
              [("1", "2", "4"), ("3", "na"), ("5", "6"), ("7", "8", "9")]]
    
    for N in N_list
        write(file, "========================================================\n") 
        write(file, "Actual Structure: " * N_to_str(N) * "\n")
        cf = generate_cf(N, N_to_network(N), 0)
        rst_net = []
        rst_inv = []
        t = N_to_t(N)
        for i in t
            temp = []
            for j in t
                if j != i
                    push!(temp, j)
                end
            end

            net_all = list_nw(temp)

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

            write(file, N_to_str(net_all_sorted[1])*": "*string(inv_mean[1])*"\n")
            push!(rst_inv, inv_mean[1])
            push!(rst_net, net_all_sorted[1])
        end

        order = sortperm(rst_inv)
        mis_species = t[order[1]]

        for i in 1:4
            if mis_species in rst_net[order[2]][i]
                push!(rst_net[order[1]][i], mis_species)
            end
        end
        write(file, "SELECTED: " * N_to_str(rst_net[order[1]]) * "\n")
    end
    close(file)
end

main()