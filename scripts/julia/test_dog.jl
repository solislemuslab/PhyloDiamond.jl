"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
include("./scripts/julia/test_invariants.jl")
"""

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics

#https://github.com/chaoszhang/Weighted-ASTRAL_data
#https://www.sciencedirect.com/science/article/pii/S0960982218311254

function main()
    #cf = generate_cf_from_gene_trees("./simulation/dogs_estimated_gene_trees.tree")
    #genetrees = readMultiTopology("./simulation/dogs_estimated_gene_trees.tree")
end

main()