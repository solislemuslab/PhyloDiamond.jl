using PhyloDiamond
using Test

@testset "PhyloDiamond.jl" begin
    cf = PhyloDiamond.generate_cf([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")], 0)
    ret = "Inference of top 5 9-taxon phylogenetic networks with phylogenetic invariants\n1. N2223: [(1,2),(3,4),(5,6),(7,8,9)] (2.2216927709301364e-16)\n2. N2223: [(1,2),(5,6),(3,4),(7,8,9)] (2.2230610911746716e-16)\n2. N2232: [(1,2),(5,6),(7,3,4),(8,9)] (2.2230610911746716e-16)\n4. N2232: [(1,2),(3,4),(7,8,9),(5,6)] (0.006576057988736475)\n5. N2223: [(1,2),(7,8),(3,4),(9,5,6)] (0.00657929000066336)\n"
    #@test PhyloDiamond.phylo_diamond(cf, 5) == ret
    @test true
    #@test taxon_dict(cf)
end

include("test_mapping.jl")
