include("mapping.jl")
include("invariants.jl")
include("helper.jl")
include("ntwk.jl")

function main()
    print(phylo_diamond(generate_cf([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")], 0), 5; output_filename="rst.txt"))
    
    #phylo_diamond_more_than_8_helper(generate_cf([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8","9")], 0))
   
end

main()