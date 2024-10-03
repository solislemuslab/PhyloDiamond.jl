__precompile__()

module PhyloDiamond

  using LinearAlgebra
  using CSV
  using DataFrames
  using PhyloNetworks
  using PhyloPlots
  using Statistics
  using Distributions
  using Random
  using DelimitedFiles
  using Combinatorics
  using StatsBase

  export phylo_diamond
  export 
    list_nw,
    compare_nw,
    N_to_str,
    N_to_network,
    N_to_t,
    N_to_N_num,
    cf_to_t,
    generate_cf_from_gene_trees,
    generate_cf,
    inv_net1112,
    inv_net1121,
    inv_net1211,
    inv_net2111,
    inv_net1122,
    inv_net1212,
    inv_net2112,
    inv_net2211,
    inv_net2121,
    inv_net1221,
    inv_net1222,
    inv_net2212,
    inv_net2122,
    inv_net2221,
    inv_net2222,
    get_n,
    cfs_in_order,
    get_a,
    phylo_diamond,
    test_invariants,
    get_inv_for_nw,
    taxon_dict

  include("mapping.jl")
  include("invariants.jl")
  include("helper.jl")
  include("ntwk.jl")
end
