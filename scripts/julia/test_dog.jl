"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
include("./scripts/julia/test_invariants.jl")
include("./scripts/julia/test_more_species.jl")
"""

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics
using JLD2

#https://github.com/chaoszhang/Weighted-ASTRAL_data
#https://www.sciencedirect.com/science/article/pii/S0960982218311254

#choose(13, 4) = 715
#choose(12, 4)
function main()
    #cf = generate_cf_from_gene_trees("./simulation/dogs_estimated_gene_trees.tree")
    #genetrees = readMultiTopology("./simulation/sim_trees/dogs_estimated_gene_trees.tree")
    #save_object("dog_genetrees.jld2", genetrees)
    #DataFrame(taxon = unique!(vcat(df[:, "t1"], df[:, "t2"], df[:, "t3"], df[:, "t4"])))

    """
    tm = DataFrame(CSV.File("./simulation/sim_trees/dog/taxonmap.csv"))
    taxonmap = Dict(row[:individual] => row[:species] for row in eachrow(tm))
    genetrees = load_object("dog_genetrees.jld2")
    q,t = countquartetsintrees(genetrees, taxonmap, showprogressbar=true);
    save_object("q.jld2", q)
    save_object("t.jld2", t)
    df_wide = writeTableCF(q,t)
    df = df_wide[:,[:t1, :t2, :t3, :t4, :CF12_34, :CF13_24, :CF14_23]]
    save_object("cf_dog.jld2", df)
    """
    
    df = load_object("./simulation/sim_trees/dog/cf_dog_merged.jld2")
    tm = DataFrame(CSV.File("./simulation/sim_trees/dog/taxonmap.csv"))
    df = df[df[:,"t1"].!="AndeanFox",:]
    df = df[df[:,"t2"].!="AndeanFox",:]
    df = df[df[:,"t3"].!="AndeanFox",:]
    df = df[df[:,"t4"].!="AndeanFox",:]

    taxon = unique!(tm[:,"species"])
    deleteat!(taxon, findall(x->x=="AndeanFox",taxon))
    value_map = Dict(taxon[i] => i for i in 1:length(taxon))
    for col in ["t1", "t2", "t3", "t4"]
        for i in 1:nrow(df)
            df[i,col] = string(value_map[df[i,col]])
        end
    end

    test_all_possible_sub_nw([("1", "2", "3"), ("4","5", "6"), ("7", "8", "9"), ("10", "11", "12")], 
    df, ".", "True concordance factor table")
    
end

main()