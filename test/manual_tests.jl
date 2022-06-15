#cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/code/phylo-invariants")
include("../mapping.jl")
using DelimitedFiles, DataFrames, CSV


# Reading CF table:
cf = CSV.read("scripts/julia/N2222_expCF.txt", DataFrame)


# We use the following networks to run get_a line by line (see test-get-a.pdf iPad notes)
# Reading network
#N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")] ## true network
#N = [("A", "D"), ("C", "B"), ("E", "F"), ("G", "H")]
N = [("A","E"),("C","B"),("D","F"),("G","H")]

rst = get_a(cf, N, verbose=false)

i=70
temp = Array(cf[i, :])
q = temp[1:4]
cfs = [temp[5], temp[6], temp[7]]
n = get_n(N, q)

cfs_ord = cfs_in_order(N, q, cfs) #reorder cf as major, minor, minor
                                          #according to N

#for i in 1:Int(length(rst)/3)
    #println(rst[i*3-2], " ", rst[i*3-1], " ", rst[i*3])
#end

#for i in 1:70
#    temp = Array(cf[i, :])
#    q = temp[1:4]
#    cfs = temp[5:7]
#    n = get_n(N, q)
    #println(n)
#    if n != [1, 1, 1, 1]
        #println(cfs_in_order(N, q, cfs)[1], ", ", cfs_in_order(N, q, cfs)[2], ", ", cfs_in_order(N, q, cfs)[3])
#    else
        #println(cfs[1], ", ", cfs[2], ", ", cfs[3])
#    end
#end
#get_a(cf, N)

#--------------------------------
# Testing cfs_in_order
#--------------------------------
#(1, 1, 1, 1), N2222
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")],
                    ["A","H","E","C"], 
                    [0.7, 0.2, 0.1])==[0.1, 0.2, 0.7])
println(cfs_in_order([("E", "F"), ("A", "B"), ("G", "H"), ("C", "D"), ],
                    ["A","H","E","C"], 
                    [0.7, 0.2, 0.1])==[0.2, 0.1, 0.7])
println(cfs_in_order([("A", "B"), ("E", "F"), ("G", "H"), ("C", "D"), ],
                    ["E","C","A","H"], 
                    [0.7, 0.2, 0.1])==[0.2, 0.7, 0.1])

#N2122
println(cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")],
                ["A","B","E","C"], 
                [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1]) #2110
println(cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")],
                ["A","E","C","B"], 
                [0.1, 0.1, 0.8])==[0.8, 0.1, 0.1]) #2110
println(cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")],
                ["E","G","A","C"], 
                [0.7, 0.2, 0.1])==[0.7, 0.2, 0.1]) #1111
println(cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")],
                ["H","G","A","B"], 
                [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1]) #2002

#N2221
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],
                ["E","B","F","C"], 
                [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1]) #1120
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],
                ["A","B","C","F"], 
                [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1]) #2110
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],
                ["F","G","A","C"], 
                [0.7, 0.2, 0.1])==[0.7, 0.2, 0.1]) #1111
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],
                ["B","F","A","E"], 
                [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1]) #2020

#N2111
println(cfs_in_order([("A", "B"), ("C", NaN), ("E", NaN), ("G", NaN)],
                ["E","B","G","A"], 
                [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1]) #2011
println(cfs_in_order([("A", "B"), ("C", NaN), ("E", NaN), ("G", NaN)],
                ["B","E","G","A"], 
                [0.1, 0.1, 0.8])==[0.8, 0.1, 0.1]) #2011

#N2211
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],
                ["C","B","D","A"], 
                [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1]) #2200
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],
                ["A","B","C","D"], 
                [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1]) #2200
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],
                ["C","G","D","A"], 
                [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1]) #1201
println(cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],
                ["E","G","C","B"], 
                [0.7, 0.1, 0.2])==[0.7, 0.2, 0.1]) #1111

#--------------------------------
# Testing invariants in true N
#--------------------------------

include("../mapping.jl")
include("../invariants.jl")

# Reading CF table:
cf = CSV.read("scripts/julia/N2222_expCF.txt", DataFrame)

# Reading network
N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")] ## true network

a = get_a(cf, N)

norm(inv_net1112(a))
norm(inv_net1121(a))
norm(inv_net1211(a))
norm(inv_net2111(a))
norm(inv_net1122(a))
norm(inv_net1212(a))
norm(inv_net2112(a))
norm(inv_net2211(a))
norm(inv_net2121(a))
norm(inv_net1221(a))
norm(inv_net1222(a))
norm(inv_net2212(a))
## We do not have the true invariants which are 2222, but
## we still expect all invariants to be relative close to 0.0
## as the order of the taxa matches with the invariants
# this is not true for the following network

# Reading network
N = [("A","E"),("C","B"),("D","F"),("G","H")]
a = get_a(cf, N)

norm(inv_net1112(a))
norm(inv_net1121(a))
norm(inv_net1211(a))
norm(inv_net2111(a))
norm(inv_net1122(a))
norm(inv_net1212(a))
norm(inv_net2112(a))
norm(inv_net2211(a))
norm(inv_net2121(a))
norm(inv_net1221(a))
norm(inv_net1222(a))
norm(inv_net2212(a))
## They are much larger than zero, yay!

#------------------------------------------------------
# Testing invariants in true N using test_invariants.jl
#------------------------------------------------------
include("test_invariants.jl")

N = [("A", NaN),("C","D"),("E","F"),("G","H")]
network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,H))),(C,D));"
#network = "((((C,D),(A)#H1:::0.8),(#H1:::0.2,(E,F))),(G,H));"
N_test = [("G", NaN),("E", "A"),("C","H"),("D","F")] 
println(test_invariants(N_test, generate_cf(N, network)))
#writedlm( "temp.csv",  test_invariants(N_test, generate_cf(N, network)), ',')

t = ["A", "B", "C", "D", "E", "F", "G", "H"]
net_all = list_nw(t)
N = [("A", "B"),("C","D"),("E","F"),("G","H")]
network = "(((A, B)#H1:::0.8, ((#H1:::0.2,(E, F)),(G, H))),(C, D));"
cf = generate_cf(N, network)
df = DataFrame()
for i in 1:length(net_all)
    colname = "Test$i"
    df[!,colname] = test_invariants(net_all[i], cf)
end
#CSV.write( "temp.csv",  df)

#--------------------------------
# Testing list_nw
#--------------------------------

t = ["A", "B", "C", "D", "E"]
t = ["A", "B", "C", "D", "E", "F"]
t = ["A", "B", "C", "D", "E", "F", "G"]
t = ["A", "B", "C", "D", "E", "F", "G", "H"]
ret = list_nw(t)
for i in 1:length(ret)
    #println(i, ret[i])
end

