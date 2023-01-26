include("mapping.jl")
include("invariants.jl")

## Script to test invariants on a given network
## Steps 2,3,4 are based on expectedCFTable.jl
## Steps 5,6,7 are from manual_tests.jl

using PhyloNetworks
using PhyloPlots
using DataFrames
using CSV, Statistics, Distributions, Random
using DelimitedFiles

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

## network structures

function main()
    network2222 = "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    network2221 = "((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    network2212 = "((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
    network2122 = "((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    network1222 = "((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    network2211 = "((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
    network2121 = "((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);"
    network2112 = "((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
    network1221 = "((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
    network1212 = "((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);"
    network1122 = "((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
    network2222 = "((((1:1,2:1):1)#H1:1.5::0.7, ((#H1:0.5::0.3,(5:1,6:1):2):0.5,(7:1,8:1):2):0.5):1,(3:1,4:1):2);"
    #net = readTopology(network2222)
    #plot(net,:R, showEdgeLength=true)
    #sim_with_est_gene_trees()
    #sim_with_gene_trees()
    #sim_with_noise()

    N = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")]
    test_all_possible_nw(generate_cf(N, 0))
    #@time test_all_possible_nw(N, cf, ".")
    #generate_cf(N, 0)
   
end

"""
    input: the name of the file storing a list of gene trees
    output: the table of CF values
"""
function generate_cf_from_gene_trees(filename_genetrees)
    genetrees = readMultiTopology(filename_genetrees);
    q,t = countquartetsintrees(genetrees);
    df_wide = writeTableCF(q,t)
    df = df_wide[:,[:t1, :t2, :t3, :t4, :CF12_34, :CF13_24, :CF14_23]]
    return df
end

"""
    input:
        N: array of tuples, individuals from each triangles of the network
        network: the parenthetical format based on the wiki rules
    output: the table of CF values
"""
function generate_cf(N, sd)
    network = N_to_network(N)
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

    ## adding noise to cf table
    noise = rand(Normal(0, sd), nrow(cf))
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
    N: [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
    cf: cf table
output:
    a dataframe of invariant values where each column is each possible network of n taxa, 
    the last row is the average of all invariants
    the true network is N
"""
function test_all_possible_nw(cf)
    #get all unique taxon names from cf table
    t = unique!(cf[:,1])
    t = vcat(t, unique!(cf[:,2]), unique!(cf[:,3]), unique!(cf[:,4]))
    net_all = list_nw(unique!(t))

    df = DataFrame()
    for i in 1:length(net_all)
        colname = N_to_str(net_all[i])
        val = test_invariants(net_all[i], cf)
        push!(val, mean(filter(!isnan, val)))
        df[!,colname] = val
    end
    insertcols!(df, 1, :row => ["1112","1121","1211","2111","1122","1212","2112","2211","2121","1221","1222","2212", "2122", "2221", "2222", "mean"])
    
    inv_mean =Matrix(df)[end,:][2:end]
    print("========================================================\n") 
    print("Actual Structure: " * N_to_str(N) * "\n")
    net_all_sorted = net_all[sortperm(inv_mean)]
    inv_mean_sorted = inv_mean[sortperm(inv_mean)]

    rank_true = 0
    rank_sym = 0
    inv_true = 0
    inv_sym = 0

    for i in 1:length(net_all)
        if compare_nw(net_all_sorted[i], N)
            if i == 1
                #write(file, "(True network) YES! It is selected as the top network\n")
            else
                #write(file, "(True network) NO! It is not selected as the top network\n")
            end

            if i <= 5
                #write(file, "(True network) YES! It is selected as one of the top 5 networks\n")
            else
                #write(file, "(True network) NO! It is not selected as one of the top 5 networks\n")
            end
            #write(file, "(True network) Rank: " * string(i) * "\n")
            #write(file, "(True network) Invariant difference: " * string(inv_mean_sorted[i]-inv_mean_sorted[1]) * "\n")
            rank_true = i
            inv_true = inv_mean_sorted[i]-inv_mean_sorted[1]
        end

        if compare_nw(net_all_sorted[i], [N[1], N[3], N[2], N[4]])
            if i == 1
                #write(file, "(True network -symmetric) YES! It is selected as the top network\n")
            else
                #write(file, "(True network -symmetric) NO! It is not selected as the top network\n")
            end

            if i <= 5
                #write(file, "(True network -symmetric) YES! It is selected as one of the top 5 networks\n")
            else
                #write(file, "(True network -symmetric) NO! It is not selected as one of the top 5 networks\n")
            end
            #write(file, "(True network -symmetric) Rank: " * string(i) * "\n")
            #write(file, "(True network -symmetric) Invariant difference: " * string(inv_mean_sorted[i]-inv_mean_sorted[1]) * "\n")
            rank_sym = i
            inv_sym = inv_mean_sorted[i]-inv_mean_sorted[1]
        end
    end

    for i in 1:5
        #write(file, string(sort(inv_mean, rev=false)[1:5][i]) * ": " * N_to_str(net_all[sortperm(inv_mean)[1:5][i]]) * "\n")
    end

    N_num = N_to_N_num(N)
    ret = [N_num,
        N_to_str(N),
        N_to_str(net_all_sorted[1]), #top network
        rank_true,
        rank_sym,
        inv_true,
        inv_sym]

    return ret
end

"""
    input: two N 
    output: true if the two networks are the same; false, otherwise
"""
function compare_nw(N1, N2)
    for i in 1:4
        for j in 1:2
            if !(N1[i][j] in N2[i])
                return false
            end
        end 
    end
    return true
end

"""
    input: array of tuples, individuals from each triangles of the network  
    output: a string of the input, mainly for saving
"""
function N_to_str(N)
    colname = ""
    for n in N
        for j in n
            if j != "na"
                colname=string(colname*"-", j)
            end
        end
        colname=string(colname,",")
    end
    return colname
end

"""
    input: array of tuples, individuals from each triangles of the network  
    output: the parenthetical network format based on the wiki rules
"""
function N_to_network(N)
    rst = []
    for i_taxon in 1:length(N)
        str = ""
        for species in N[i_taxon]
            if species != "na"
                if N[i_taxon][end] != "na" && N[i_taxon][end] == species
                    str = str*species*":1"
                elseif N[i_taxon][end] == "na" && N[i_taxon][end-1] == species
                    str = str*species*":1"
                else
                    str = str*species*":1,"
                end
            end
        end
        push!(rst, str)
    end

    return "((" * rst[4] *"):4, (((" * rst[2] * "):2, ((" * rst[1] * "):1)#H1:1::0.7):1, (#H1:1::0.3,(" * rst[3] * 
    "):2):1):1);"
end

"""
    input: array of tuples, individuals from each triangles of the network  
    output: an array of each species, ignoring na
"""
function N_to_t(N)
    t = []
    for i_taxon in 1:length(N)
        for species in N[i_taxon]
            if species != "na"
                push!(t, species)
            end
        end
    end
    return t
end

"""
    input: array of tuples, individuals from each triangles of the network  
    output: N_num eg. 2222
"""
function N_to_N_num(N)
    rst = ""
    for i_taxon in 1:length(N)
        cnt = 0
        for species in N[i_taxon]
            if species != "na"
                cnt += 1
            end
        end
        rst = rst*string(cnt)
    end
    return rst
end

main()