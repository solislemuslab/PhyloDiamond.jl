using PhyloDiamond
using Test
print(pwd())
@testset "PhyloDiamond.jl" begin
    cf = PhyloDiamond.generate_cf([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")], 0)
    dict = PhyloDiamond.phylo_diamond(cf, 5)
    @test length(dict) == 5
    @test dict[5] == "((9:1,5:1,6:1):4, (((7:1,8:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
    @test dict[4] == "((5:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1,9:1):2):1):1);"
    @test dict[2] == "((7:1,8:1,9:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
    @test dict[3] == "((8:1,9:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,3:1,4:1):2):1):1);"
    @test dict[1] == "((7:1,8:1,9:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"

        function almost_equal(a::Float64, b::Float64; tol::Float64=1e-10)
        return abs(a - b) < tol
    end
    
    function compare_phylogenetic_strings(str1::String, str2::String)
        # Regular expression pattern to extract numerical values
        num_pattern = r"[-+]?\d*\.?\d+([eE][-+]?\d+)?"
    
        # Extract numerical values from both strings
        nums1 = [parse(Float64, m.match) for m in eachmatch(num_pattern, str1)]
        nums2 = [parse(Float64, m.match) for m in eachmatch(num_pattern, str2)]
    
        # Check if the number of extracted values is the same
        if length(nums1) != length(nums2)
            return false
        end
    
        # Compare the numerical values with a tolerance
        for (n1, n2) in zip(nums1, nums2)
            if !almost_equal(n1, n2)
                return false
            end
        end
    
        # Remove numerical values from both strings for final comparison
        stripped_str1 = replace(str1, num_pattern => "")
        stripped_str2 = replace(str2, num_pattern => "")
    
        # Check if the remaining strings are identical
        return stripped_str1 == stripped_str2
    end
    f = open("phylo_diamond.txt", "r")
    s = read(f, String)
    close(f)
    s_1 = "Inference of top 5 9-taxon phylogenetic networks with phylogenetic invariants\n1. N2223 (2.2216927709301364e-16)\n[(1,2),(3,4),(5,6),(7,8,9)]\n((7:1,8:1,9:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);\n2. N2223 (2.2230610911746716e-16)\n[(1,2),(5,6),(3,4),(7,8,9)]\n((7:1,8:1,9:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);\n2. N2232 (2.2230610911746716e-16)\n[(1,2),(5,6),(7,3,4),(8,9)]\n((8:1,9:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,3:1,4:1):2):1):1);\n4. N2232 (0.006576057988736475)\n[(1,2),(3,4),(7,8,9),(5,6)]\n((5:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1,9:1):2):1):1);\n5. N2223 (0.00657929000066336)\n[(1,2),(7,8),(3,4),(9,5,6)]\n((9:1,5:1,6:1):4, (((7:1,8:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);\n"
    @test compare_phylogenetic_strings(s, s_1)
    rm("phylo_diamond.txt")

    dict = PhyloDiamond.phylo_diamond("./file/gt.txt", 5)
    @test length(dict) == 5
    @test dict[5] == "((5:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1):2):1):1);"
    @test dict[4] == "((3:1,4:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1):2):1):1);"
    @test dict[2] == "((7:1,8:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
    @test dict[3] == "((3:1,4:1):4, (((7:1,8:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    @test dict[1] == "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    f = open("phylo_diamond.txt", "r")
    s = read(f, String)
    close(f)
    s_1 = "Inference of top 5 8-taxon phylogenetic networks with phylogenetic invariants\n1. N2222 (0.03689157145883046)\n[(1,2),(3,4),(5,6),(7,8)]\n((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);\n2. N2222 (0.03823994257144703)\n[(1,2),(5,6),(3,4),(7,8)]\n((7:1,8:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);\n3. N2222 (0.04097959230267735)\n[(1,2),(7,8),(5,6),(3,4)]\n((3:1,4:1):4, (((7:1,8:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);\n4. N2222 (0.04258688497092598)\n[(1,2),(5,6),(7,8),(3,4)]\n((3:1,4:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1):2):1):1);\n5. N2222 (0.04789498610785061)\n[(1,2),(3,4),(7,8),(5,6)]\n((5:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1):2):1):1);\n"
    @test s == s_1
    rm("phylo_diamond.txt")
end

include("test_mapping.jl")
include("test_helper.jl")
