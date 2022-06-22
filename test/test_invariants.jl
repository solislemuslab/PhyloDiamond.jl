## Script to test invariants on a given network
## Steps 2,3,4 are based on expectedCFTable.jl
## Steps 5,6,7 are from manual_tests.jl
## Claudia (June 2022)

using PhyloNetworks
using PhyloPlots
using DataFrames
using CSV, Statistics

## 1. Choose a network in N vector format
## 2. Write the network in parenthetical format
    ## For this step, you need to draw the network by hand (rooted)
    ## and write the parenthetical format based on the wiki rules
## 3. Read network in parenthetical format
## 4. Create table of CF values
## 5. Get the vector of a
## 6. Evaluating invariants on the true networks
    ## So, we expect numbers to be close to zero
    ## With the true network having the smallest value
## 7. Test a wrong network to see that invariants are not close to zero


function main()
    """
    t = ["A", "B", "C", "D", "E", "F", "G", "H"]
    N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,H))),(C,D));"
    df = test_all_possible_nw(t, N, network)
    CSV.write("network2222.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G))),(C,D));"
    df = test_all_possible_nw(t, network)
    CSV.write("network2221.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", "B"), ("C", "D"), ("E", NaN), ("G", "F")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(G,F))),(C,D));"
    df = test_all_possible_nw(t, network)
    CSV.write(".\\result\\network2212.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", "B"), ("C", NaN), ("E", "F"), ("G", "D")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,D))),(C));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network2122.csv",  df)

    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", NaN), ("C", "D"), ("E", "F"), ("G", "B")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,B))),(C,D));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network1222.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", "B"), ("C", "D"), ("E", NaN), ("F", NaN)]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(F))),(C,D));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network2211.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", "B"), ("C", NaN), ("E", "D"), ("F", NaN)]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,D)),(F))),(C));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network2121.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", "B"), ("C", NaN), ("E", NaN), ("F", "D")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(F, D))),(C));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network2112.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("C", "D"), ("E", "F"), ("B", NaN)]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(B))),(C,D));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network1221.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("C", "D"), ("B", NaN), ("E", "F")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(B)),(E,F))),(C,D));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network1212.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("B", NaN), ("C", "D"), ("E", "F")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(C,D)),(E,F))),(B));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network1122.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("B", NaN), ("C", "D"), ("E", "F")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(C,D)),(E,F))),(B));"
    df = test_all_possible_nw(t, network)
    CSV.write("./result/network1122.csv",  df)
    """

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("B", NaN), ("C", "D"), ("E", "F")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(C,D)),(E,F))),(B));"
    df = test_all_possible_nw(t, network)
end


"""
    input:
        N: array of tuples, individuals from each triangles of the network
        network: the parenthetical format based on the wiki rules
    output: the table of CF values
"""
function generate_cf(N, network)
    net = readTopology(network)
    plot(net,:R) ## just to check it matches your drawing
    
    #identifiable edges lengths were originally missing, so assigned default value of 1.0
    quartets = PhyloNetworks.allQuartets(tipLabels(net), false) 
    tx1 = []
    tx2 = []
    tx3 = []
    tx4 = []

    for q in quartets
        push!(tx1,q.taxon[1])
        push!(tx2,q.taxon[2])
        push!(tx3,q.taxon[3])
        push!(tx4,q.taxon[4])
    end

    df = DataFrame(tx1=tx1, tx2=tx2, tx3=tx3, tx4=tx4, obsCF1=ones(length(tx1)), obsCF2=zeros(length(tx1)), obsCF3=zeros(length(tx1)))
    cf = readTableCF!(df)

    ## We need to optimize the pseudolikelihood on the network for those dummy observed CF in order to compute the expected CFs
    topologyQPseudolik!(net, cf)
    df_wide = fittedQuartetCF(cf)

    ## "true" concordance factors:
    cf = df_wide[:,[:tx1, :tx2, :tx3, :tx4, :expCF12, :expCF13, :expCF14]]
    #println(size(cf, 1))
    return cf
end

"""
    input:
        N: array of tuples, individuals from each triangles of the network
        cf: the expected CF table
    output: an array of norm of invariants (we expect the value to be small if it is the correct network)
"""
function test_invariants(N, cf)
    a = get_a(cf, N)
    """
    for i in 1:length(a)
        print(i,": ")
        println(a[i])
    end
    """
    return [norm(inv_net1112(a)), 
    norm(inv_net1121(a)),
    norm(inv_net1211(a)),
    norm(inv_net2111(a)),
    norm(inv_net1122(a)),
    norm(inv_net1212(a)),
    norm(inv_net2112(a)),
    norm(inv_net2211(a)),
    norm(inv_net2121(a)),
    norm(inv_net1221(a)),
    norm(inv_net1222(a)),
    norm(inv_net2212(a))]
end

"""
input:
    t: array of taxa ["A", "B", "C", "D", "E", "F", "G", "H"]
    N: [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
    network: newick format "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,H))),(C,D));"
output:
    a dataframe of invariant values where each column is each possible network of n taxa, 
    the last row is the average of all invariants
    the true network is N
"""
function test_all_possible_nw(t, N, network)
    net_all = list_nw(t)
    cf = generate_cf(N, network)
    println(cf)
    df = DataFrame()
    for i in 1:length(net_all)
        colname = ""
        for n in net_all[i]
            for j in n
                colname=string(colname, j)
            end
            colname=string(colname,",")
        end
        val = test_invariants(net_all[i], cf)
        push!(val, mean(filter(!isnan, val)))
        df[!,colname] = val
    end
    insertcols!(df, 1, :row => ["1112","1121","1211","2111","1122","1212","2112","2211","2121","1221","1222","2212", "mean"])
    
    inv_mean =Matrix(df)[end,:][2:end]
    println(sort(inv_mean, rev=false)[1:5]) #print the top large invariant mean
    println(net_all[sortperm(inv_mean)[1:5]]) #print the corresponding network structure
    return df
end

main()