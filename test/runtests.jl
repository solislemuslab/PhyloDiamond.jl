using PhyloDiamond
using Test

@testset "PhyloDiamond.jl" begin
    cf = PhyloDiamond.generate_cf([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")], 0)
    dict = PhyloDiamond.phylo_diamond(cf, 5)
    @test length(dict) == 5
    dict = PhyloDiamond.phylo_diamond("./test/file/gt.txt", 5)
    @test length(dict) == 5
end

include("test_mapping.jl")
include("test_helper.jl")
