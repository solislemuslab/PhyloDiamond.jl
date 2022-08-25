#cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("../scripts/julia/mapping.jl")
include("../scripts/julia/invariants.jl")
## Script to test invariants on a given network
## Steps 2,3,4 are based on expectedCFTable.jl
## Steps 5,6,7 are from manual_tests.jl
## Claudia (June 2022)

using PhyloNetworks
using PhyloPlots
using DataFrames
using CSV, Statistics, Distributions, Random

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
    path = "./test/result/"
    
    t = ["A", "B", "C", "D", "E", "F", "G", "H"]
    N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,H))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2222.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2221.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", "B"), ("C", "D"), ("E", NaN), ("G", "F")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(G,F))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2212.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", "B"), ("C", NaN), ("E", "F"), ("G", "D")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,D))),(C));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2122.csv",  df)

    t = ["A", "B", "C", "D", "E", "F", "G"]
    N = [("A", NaN), ("C", "D"), ("E", "F"), ("G", "B")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,B))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network1222.csv",  df)
    
    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", "B"), ("C", "D"), ("E", NaN), ("F", NaN)]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(F))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2211.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", "B"), ("C", NaN), ("E", "D"), ("F", NaN)]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,D)),(F))),(C));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2121.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", "B"), ("C", NaN), ("E", NaN), ("F", "D")]
    network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(F, D))),(C));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network2112.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("C", "D"), ("E", "F"), ("B", NaN)]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(B))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network1221.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("C", "D"), ("B", NaN), ("E", "F")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(B)),(E,F))),(C,D));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network1212.csv",  df)

    t = ["A", "B", "C", "D", "E", "F"]
    N = [("A", NaN), ("B", NaN), ("C", "D"), ("E", "F")]
    network = "(((A)#H1:::0.8, ((#H1:::0.2,(C,D)),(E,F))),(B));"
    df = test_all_possible_nw(t, N, network, generate_cf(N, network))
    CSV.write(path*"/network1122.csv",  df)
    
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

    noise = rand(Normal(0, 0.000005), nrow(cf))
    for i in 1:nrow(cf)
        ind = randperm(3)
        if cf[i, ind[1]+4]+noise[i]<1 && cf[i, ind[1]+4]+noise[i]>0
            if cf[i, ind[2]+4]-noise[i]/2<1 && cf[i, ind[2]+4]-noise[i]/2>0
                if cf[i, ind[3]+4]-noise[i]/2<1 && cf[i, ind[3]+4]-noise[i]/2>0
                    cf[i, ind[1]+4] = cf[i, ind[1]+4]+noise[i]
                    cf[i, ind[2]+4] = cf[i, ind[2]+4]-noise[i]/2
                    cf[i, ind[3]+4] = cf[i, ind[3]+4]-noise[i]/2
                end
            end
        end 
    end
    
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
    norm(inv_net2212(a)),
    norm(inv_net2122(a)),
    norm(inv_net2221(a)),
    norm(inv_net2222(a))]
end

"""
input:
    t: array of taxa ["A", "B", "C", "D", "E", "F", "G", "H"]
    N: [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
    network: newick format "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,H))),(C,D));"
    cf: cf table
output:
    a dataframe of invariant values where each column is each possible network of n taxa, 
    the last row is the average of all invariants
    the true network is N
"""
function test_all_possible_nw(t, N, network, cf)
    net_all = list_nw(t)
    df = DataFrame()
    file = open("./test/result/rst.txt", "a")

    for i in 1:length(net_all)
        colname = N_to_str(net_all[i])
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
    insertcols!(df, 1, :row => ["1112","1121","1211","2111","1122","1212","2112","2211","2121","1221","1222","2212", "2122", "2221", "2222", "mean"])
    
    inv_mean =Matrix(df)[end,:][2:end]
    write(file, "========================================================\n") 

    write(file, "Actual Structure: " * N_to_str(N) * "\n")
    for i in 1:5
        write(file, string(sort(inv_mean, rev=false)[1:5][i]) * ": " * N_to_str(net_all[sortperm(inv_mean)[1:5][i]]) * "\n")
        #println(sort(inv_mean, rev=false)[1:5][i], ": ", net_all[sortperm(inv_mean)[1:5][i]]) #print the top large invariant mean
    end
    close(file)
    return df
end

function N_to_str(N)
    colname = ""
    for n in N
        for j in n
            colname=string(colname, j)
        end
        colname=string(colname,",")
    end
    return colname
end

main()