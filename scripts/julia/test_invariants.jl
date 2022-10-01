"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
"""
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

    #N = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "na")]
    #test_all_possible_nw(N, generate_cf(N, 0), ".")
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
function test_all_possible_nw(N, cf, path)
    t = N_to_t(N)
    net_all = list_nw(t)

    df = DataFrame()
    file = open(path*"/rst.txt", "a")
    for i in 1:length(net_all)
        colname = N_to_str(net_all[i])
        val = test_invariants(net_all[i], cf)
        push!(val, mean(filter(!isnan, val)))
        df[!,colname] = val
    end
    insertcols!(df, 1, :row => ["1112","1121","1211","2111","1122","1212","2112","2211","2121","1221","1222","2212", "2122", "2221", "2222", "mean"])
    
    inv_mean =Matrix(df)[end,:][2:end]
    write(file, "========================================================\n") 
    write(file, "Actual Structure: " * N_to_str(N) * "\n")
    net_all_sorted = net_all[sortperm(inv_mean)]
    inv_mean_sorted = inv_mean[sortperm(inv_mean)]

    rank_true = 0
    rank_sym = 0
    inv_true = 0
    inv_sym = 0

    for i in 1:length(net_all)
        if compare_nw(net_all_sorted[i], N)
            if i == 1
                write(file, "(True network) YES! It is selected as the top network\n")
            else
                write(file, "(True network) NO! It is not selected as the top network\n")
            end

            if i <= 5
                write(file, "(True network) YES! It is selected as one of the top 5 networks\n")
            else
                write(file, "(True network) NO! It is not selected as one of the top 5 networks\n")
            end
            write(file, "(True network) Rank: " * string(i) * "\n")
            write(file, "(True network) Invariant difference: " * string(inv_mean_sorted[i]-inv_mean_sorted[1]) * "\n")
            rank_true = i
            inv_true = inv_mean_sorted[i]-inv_mean_sorted[1]
        end

        if compare_nw(net_all_sorted[i], [N[1], N[3], N[2], N[4]])
            if i == 1
                write(file, "(True network -symmetric) YES! It is selected as the top network\n")
            else
                write(file, "(True network -symmetric) NO! It is not selected as the top network\n")
            end

            if i <= 5
                write(file, "(True network -symmetric) YES! It is selected as one of the top 5 networks\n")
            else
                write(file, "(True network -symmetric) NO! It is not selected as one of the top 5 networks\n")
            end
            write(file, "(True network -symmetric) Rank: " * string(i) * "\n")
            write(file, "(True network -symmetric) Invariant difference: " * string(inv_mean_sorted[i]-inv_mean_sorted[1]) * "\n")
            rank_sym = i
            inv_sym = inv_mean_sorted[i]-inv_mean_sorted[1]
        end
    end

    for i in 1:5
        write(file, string(sort(inv_mean, rev=false)[1:5][i]) * ": " * N_to_str(net_all[sortperm(inv_mean)[1:5][i]]) * "\n")
    end
    close(file)

    N_num = N_to_N_num(N)
    ret = [N_num,
        N_to_str(N),
        N_to_str(net_all_sorted[1]), #top network
        rank_true,
        rank_sym,
        inv_true,
        inv_sym]

    CSV.write(path*"/network"*N_num*".csv",  df)
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
                colname=string(colname, j)
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

"""
sd,
num_genetree,
len_seq,
rep,
"""

"""
rst = []
len_seq=0
sd = 0
path = "./simulation/result"
for i in 0:29 #change replication number
    for num_genetrees in [100, 1000, 10000] #change number of gene trees
        path_sim_tree = string("./simulation/sim_trees", "/", num_genetrees) #the directory storing gene trees

        network = ["2222", "2221", "2212", "2122", "1222", "2211", "2121", "2112", "1221", "1212", "1122"]
        t = ["1", "2", "3", "4", "5", "6", "7", "8"]
        N = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")]
        network2222 = "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2222_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2222, cf, path,
        2222, sd, num_genetrees,len_seq, i)
        push!(rst, ret)
        
        t = ["1", "2", "3", "4", "5", "6", "7"]
        N = [("1", "2"), ("3", "4"), ("5", "6"), ("7","na")]
        network2221 = "((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2221_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2221, cf, path,
        2221, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6", "7"]
        N = [("1", "2"), ("3", "4"), ("5","na"), ("7", "6")]
        network2212 = "((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2212_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2212, cf, path,
        2212, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6", "7"]
        N = [("1", "2"), ("3","na"), ("5", "6"), ("7", "4")]
        network2122 = "((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2122_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2122, cf, path,
        2122, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6", "7"]
        N = [("1","na"), ("3", "4"), ("5", "6"), ("7", "2")]
        network1222 = "((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1222_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network1222, cf, path,
        1222, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6"]
        N = [("1", "2"), ("3", "4"), ("5","na"), ("6","na")]
        network2211 = "((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2211_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2211, cf, path,
        2211, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6"]
        N = [("1", "2"), ("3","na"), ("5", "4"), ("6","na")]
        network2121 = "((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2121_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2121, cf, path,
        2121, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6"]
        N = [("1", "2"), ("3","na"), ("5","na"), ("4", "6")]
        network2112 = "((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2112_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network2112, cf, path,
        2112, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6"]
        N = [("1","na"), ("3", "4"), ("5", "6"), ("2","na")]
        network1221 = "((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1221_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network1221, cf, path,
        1221, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6"]
        N = [("1","na"), ("3", "4"), ("2","na"), ("5", "6")]
        network1212 = "((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1212_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network1212, cf, path,
        1212, sd, num_genetrees,len_seq, i)
        push!(rst, ret)

        t = ["1", "2", "3", "4", "5", "6"]
        N = [("1","na"), ("2","na"), ("3", "4"), ("5", "6")]
        network1122 = "((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
        cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1122_", num_genetrees, "_", i))
        df, ret = test_all_possible_nw_rst(t, N, network1122, cf, path,
        1122, sd, num_genetrees,len_seq, i)
        push!(rst, ret)
    end
end
writedlm( "temp.csv",  rst, ',')
"""

"""
function sim_with_est_gene_trees()
    rst = []
    sd = 0
    path = "./simulation/result"
    for i in 0:29 #change replication number
        for num_genetrees in [1000, 10000] #change number of gene trees
            for seq_len in [500, 2000] #change length of gene sequences

                path = "./simulation/result/estimated_genetrees_"*string(num_genetrees)*"_l"*string(seq_len)*"/"*string(i) #the path for different number of gene trees for ith replicate
                path_sim_tree = string("./simulation/sim_trees/estimated_gene_trees_", num_genetrees) #the directory storing gene trees

                mkdir(path) #create new directory

                network = ["2222", "2221", "2212", "2122", "1222", "2211", "2121", "2112", "1221", "1212", "1122"]
                t = ["1", "2", "3", "4", "5", "6", "7", "8"]
                N = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")]
                network2222 = "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2222_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2222, cf, path, 2222, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2222.csv",  df)
                
                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1", "2"), ("3", "4"), ("5", "6"), ("7","na")]
                network2221 = "((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2221_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2221, cf, path,
                2221, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2221.csv",  df)

                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1", "2"), ("3", "4"), ("5","na"), ("7", "6")]
                network2212 = "((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2212_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2212, cf, path,
                2212, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2212.csv",  df)

                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1", "2"), ("3","na"), ("5", "6"), ("7", "4")]
                network2122 = "((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2122_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2122, cf, path,
                1122, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2122.csv",  df)

                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1","na"), ("3", "4"), ("5", "6"), ("7", "2")]
                network1222 = "((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1222_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network1222, cf, path,
                1222, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network1222.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1", "2"), ("3", "4"), ("5","na"), ("6","na")]
                network2211 = "((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2211_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2211, cf, path,
                2211, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2211.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1", "2"), ("3","na"), ("5", "4"), ("6","na")]
                network2121 = "((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2121_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2121, cf, path,
                2121, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2121.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1", "2"), ("3","na"), ("5","na"), ("4", "6")]
                network2112 = "((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2112_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network2112, cf, path,
                2112, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network2112.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1","na"), ("3", "4"), ("5", "6"), ("2","na")]
                network1221 = "((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1221_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network1221, cf, path,
                1221, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network1221.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1","na"), ("3", "4"), ("2","na"), ("5", "6")]
                network1212 = "((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1212_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network1212, cf, path,
                1212, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network1212.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1","na"), ("2","na"), ("3", "4"), ("5", "6")]
                network1122 = "((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1122_l", seq_len, "_", i))
                df, ret = test_all_possible_nw_rst(t, N, network1122, cf, path,
                1122, sd, num_genetrees,seq_len, i)
                push!(rst, ret)
                CSV.write(path*"/network1122.csv",  df)

                

                network = ["2222", "2221", "2212", "2122", "1222", "2211", "2121", "2112", "1221", "1212", "1122"]
                t = ["1", "2", "3", "4", "5", "6", "7", "8"]
                N = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")]
                network2222 = "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2222_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2222, cf, path)
                CSV.write(path*"/network2222.csv",  df)
                
                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1", "2"), ("3", "4"), ("5", "6"), ("7","na")]
                network2221 = "((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2221_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2221, cf, path)
                CSV.write(path*"/network2221.csv",  df)

                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1", "2"), ("3", "4"), ("5","na"), ("7", "6")]
                network2212 = "((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2212_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2212, cf, path)
                CSV.write(path*"/network2212.csv",  df)

                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1", "2"), ("3","na"), ("5", "6"), ("7", "4")]
                network2122 = "((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2122_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2122, cf, path)
                CSV.write(path*"/network2122.csv",  df)

                t = ["1", "2", "3", "4", "5", "6", "7"]
                N = [("1","na"), ("3", "4"), ("5", "6"), ("7", "2")]
                network1222 = "((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1222_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network1222, cf, path)
                CSV.write(path*"/network1222.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1", "2"), ("3", "4"), ("5","na"), ("6","na")]
                network2211 = "((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2211_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2211, cf, path)
                CSV.write(path*"/network2211.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1", "2"), ("3","na"), ("5", "4"), ("6","na")]
                network2121 = "((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2121_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2121, cf, path)
                CSV.write(path*"/network2121.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1", "2"), ("3","na"), ("5","na"), ("4", "6")]
                network2112 = "((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/2112_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network2112, cf, path)
                CSV.write(path*"/network2112.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1","na"), ("3", "4"), ("5", "6"), ("2","na")]
                network1221 = "((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1221_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network1221, cf, path)
                CSV.write(path*"/network1221.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1","na"), ("3", "4"), ("2","na"), ("5", "6")]
                network1212 = "((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1212_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network1212, cf, path)
                CSV.write(path*"/network1212.csv",  df)

                t = ["1", "2", "3", "4", "5", "6"]
                N = [("1","na"), ("2","na"), ("3", "4"), ("5", "6")]
                network1122 = "((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
                cf = generate_cf_from_gene_trees(string(path_sim_tree, "/1122_l", seq_len, "_", i))
                df = test_all_possible_nw(t, N, network1122, cf, path)
                CSV.write(path*"/network1122.csv",  df)
                
            end
        end
    end
    writedlm( "temp.csv",  rst, ',')
end

function sim_with_gene_trees()
    for i in 0:0 #change replication number
        for num_genetrees in [100, 1000, 10000] #change number of gene trees

            path = "./simulation/result/genetrees_"*string(num_genetrees)*"/"*string(i) #the path for different number of gene trees for ith replicate
            path_sim_tree = string("./simulation/sim_trees", "/", num_genetrees) #the directory storing gene trees
            
            mkdir(path) #create new directory

            network = ["2222", "2221", "2212", "2122", "1222", "2211", "2121", "2112", "1221", "1212", "1122"]
            t = ["1", "2", "3", "4", "5", "6", "7", "8"]
            N = [("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")]
            network2222 = "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2222_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2222, cf, path)
            CSV.write(path*"/network2222.csv",  df)
            
            t = ["1", "2", "3", "4", "5", "6", "7"]
            N = [("1", "2"), ("3", "4"), ("5", "6"), ("7","na")]
            network2221 = "((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2221_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2221, cf, path)
            CSV.write(path*"/network2221.csv",  df)

            t = ["1", "2", "3", "4", "5", "6", "7"]
            N = [("1", "2"), ("3", "4"), ("5","na"), ("7", "6")]
            network2212 = "((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2212_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2212, cf, path)
            CSV.write(path*"/network2212.csv",  df)

            t = ["1", "2", "3", "4", "5", "6", "7"]
            N = [("1", "2"), ("3","na"), ("5", "6"), ("7", "4")]
            network2122 = "((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2122_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2122, cf, path)
            CSV.write(path*"/network2122.csv",  df)

            t = ["1", "2", "3", "4", "5", "6", "7"]
            N = [("1","na"), ("3", "4"), ("5", "6"), ("7", "2")]
            network1222 = "((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1222_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network1222, cf, path)
            CSV.write(path*"/network1222.csv",  df)

            t = ["1", "2", "3", "4", "5", "6"]
            N = [("1", "2"), ("3", "4"), ("5","na"), ("6","na")]
            network2211 = "((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2211_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2211, cf, path)
            CSV.write(path*"/network2211.csv",  df)

            t = ["1", "2", "3", "4", "5", "6"]
            N = [("1", "2"), ("3","na"), ("5", "4"), ("6","na")]
            network2121 = "((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2121_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2121, cf, path)
            CSV.write(path*"/network2121.csv",  df)

            t = ["1", "2", "3", "4", "5", "6"]
            N = [("1", "2"), ("3","na"), ("5","na"), ("4", "6")]
            network2112 = "((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_2112_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network2112, cf, path)
            CSV.write(path*"/network2112.csv",  df)

            t = ["1", "2", "3", "4", "5", "6"]
            N = [("1","na"), ("3", "4"), ("5", "6"), ("2","na")]
            network1221 = "((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1221_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network1221, cf, path)
            CSV.write(path*"/network1221.csv",  df)

            t = ["1", "2", "3", "4", "5", "6"]
            N = [("1","na"), ("3", "4"), ("2","na"), ("5", "6")]
            network1212 = "((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1212_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network1212, cf, path)
            CSV.write(path*"/network1212.csv",  df)

            t = ["1", "2", "3", "4", "5", "6"]
            N = [("1","na"), ("2","na"), ("3", "4"), ("5", "6")]
            network1122 = "((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
            cf = generate_cf_from_gene_trees(string(path_sim_tree, "/sim_trees_1122_", num_genetrees, "_", i))
            df = test_all_possible_nw(t, N, network1122, cf, path)
            CSV.write(path*"/network1122.csv",  df)
        end
    end
end

function sim_with_noise()
    for i in 1:30
        for sd in [0.0005, 0.00005, 0.000005]
            path = "./simulation/result/noise_normal_0_"*string(sd)*"/"*string(i)
            mkdir(path)

            t = ["A", "B", "C", "D", "E", "F", "G", "H"]
            N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,H))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2222.csv",  df)
            
            t = ["A", "B", "C", "D", "E", "F", "G"]
            N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "na")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2221.csv",  df)
            
            t = ["A", "B", "C", "D", "E", "F", "G"]
            N = [("A", "B"), ("C", "D"), ("E", "na"), ("G", "F")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(G,F))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2212.csv",  df)
            
            t = ["A", "B", "C", "D", "E", "F", "G"]
            N = [("A", "B"), ("C", "na"), ("E", "F"), ("G", "D")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,D))),(C));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2122.csv",  df)

            t = ["A", "B", "C", "D", "E", "F", "G"]
            N = [("A", "na"), ("C", "D"), ("E", "F"), ("G", "B")]
            network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(G,B))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network1222.csv",  df)
            
            t = ["A", "B", "C", "D", "E", "F"]
            N = [("A", "B"), ("C", "D"), ("E", "na"), ("F", "na")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(F))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2211.csv",  df)

            t = ["A", "B", "C", "D", "E", "F"]
            N = [("A", "B"), ("C", "na"), ("E", "D"), ("F", "na")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E,D)),(F))),(C));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2121.csv",  df)

            t = ["A", "B", "C", "D", "E", "F"]
            N = [("A", "B"), ("C", "na"), ("E", "na"), ("F", "D")]
            network = "(((A,B)#H1:::0.8, ((#H1:::0.2,(E)),(F, D))),(C));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network2112.csv",  df)

            t = ["A", "B", "C", "D", "E", "F"]
            N = [("A", "na"), ("C", "D"), ("E", "F"), ("B", "na")]
            network = "(((A)#H1:::0.8, ((#H1:::0.2,(E,F)),(B))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network1221.csv",  df)

            t = ["A", "B", "C", "D", "E", "F"]
            N = [("A", "na"), ("C", "D"), ("B", "na"), ("E", "F")]
            network = "(((A)#H1:::0.8, ((#H1:::0.2,(B)),(E,F))),(C,D));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network1212.csv",  df)

            t = ["A", "B", "C", "D", "E", "F"]
            N = [("A", "na"), ("B", "na"), ("C", "D"), ("E", "F")]
            network = "(((A)#H1:::0.8, ((#H1:::0.2,(C,D)),(E,F))),(B));"
            df = test_all_possible_nw(t, N, network, generate_cf(N, network, sd), path)
            CSV.write(path*"/network1122.csv",  df)
        end
    end
end
"""