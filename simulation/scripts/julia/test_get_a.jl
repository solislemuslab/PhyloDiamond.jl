# Automatic test for the get_a function
# Claudia (June 2022)

include("../create_cf.jl")

# Reading CF table:
cf = CSV.read("scripts/julia/N2222_expCF.txt", DataFrame)

# Reading network
N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")] ## true network
i=1
temp = Array(cf[i, :])
q = temp[1:4]
cfs = [temp[5], temp[6], temp[7]]
n = get_n(N, q)
n == [2,0,2,0] || error("wrong n")
cfs_ord = cfs_in_order(N, q, cfs)
round.(cfs_ord;digits=2) == [0.96,0.02,0.02] || error("wrong cfs_ord")

i=69
temp = Array(cf[i, :])
q = temp[1:4]
cfs = [temp[5], temp[6], temp[7]]
n = get_n(N, q)
n == [0,1,1,2] || error("wrong n")
cfs_ord = cfs_in_order(N, q, cfs)
round.(cfs_ord;digits=2) == [0.91,0.05,0.05] || error("wrong cfs_ord")


N = [("A","E"),("C","B"),("D","F"),("G","H")]
i=1
temp = Array(cf[i, :])
q = temp[1:4]
cfs = [temp[5], temp[6], temp[7]]
n = get_n(N, q)
n == [2,1,1,0] || error("wrong n")
cfs_ord = cfs_in_order(N, q, cfs)
round.(cfs_ord;digits=2) == [0.02,0.96,0.02] || error("wrong cfs_ord")


i=2
temp = Array(cf[i, :])
q = temp[1:4]
cfs = [temp[5], temp[6], temp[7]]
n = get_n(N, q)
n == [2,2,0,0] || error("wrong n")
cfs_ord = cfs_in_order(N, q, cfs)
round.(cfs_ord;digits=2) == [0.06,0.87,0.06] || error("wrong cfs_ord")



cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")],
                    ["A","H","E","C"], 
                    [0.7, 0.2, 0.1]) == [0.1,0.2,0.7] || error("wrong cfs order")
cfs_in_order([("E", "F"), ("A", "B"), ("G", "H"), ("C", "D"), ],
                    ["A","H","E","C"], 
                    [0.7, 0.2, 0.1]) == [0.2,0.1,0.7] || error("wrong cfs order")
cfs_in_order([("A", "B"), ("E", "F"), ("G", "H"), ("C", "D"), ],
                    ["E","C","A","H"], 
                    [0.7, 0.2, 0.1]) == [0.2,0.7,0.1] || error("wrong cfs order")