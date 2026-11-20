"""
    input:
        t: array of taxa
        length(list_nw(["A", "B", "C", "D", "E", "F", "G", "H"])) ->2520 (N2222)
        length(list_nw(["A", "B", "C", "D", "E", "F", "G"])) ->2520 (N1222, N2122, N2212, N2221)
        length(list_nw(["A", "B", "C", "D", "E", "F"])) ->1080 (N1122, N1212, N1221, N2112, N2121, N2211)
        length(list_nw(["A", "B", "C", "D", "E"])) ->240 (N1112, N1121, N1211, N2111)
    output: 
        the whole list of potential networks for those taxa
"""
function list_nw(t)
    #fill taxa array to length 8 with "na"
    if length(t) != 8
        for i in 1:8-length(t)
            push!(t, "na") #use string "na" to avoid problems of NaN
        end
    end

    ret = Vector{Any}([])

    #n0
    for i in 1:7
        for j in i+1:8
            #if both items are NaN, skip
            #since n_i should be either 1 or 2
            if t[i]=="na" && t[j]=="na"
                continue
            end
            #remove the two selected items: t[i], t[j]
            temp = deleteat!(deepcopy(t), i) 
            t1 = Vector{Any}(deleteat!(deepcopy(temp), j-1)) #length 6

            #n1
            for a in 1:5
                for b in a+1:6
                    if t1[a]=="na" && t1[b]=="na"
                        continue
                    end
                    #remove the two selected items: t1[a], t1[b]
                    temp = deleteat!(deepcopy(t1), a)
                    t2 = Vector{Any}(deleteat!(deepcopy(temp), b-1)) #length 4

                    #n2
                    for c in 1:3
                        for d in c+1:4
                            if t2[c]=="na" && t2[d]=="na"
                                continue
                            end

                            #n3
                            #remove the two selected items: t2[c], t2[d]
                            temp = deleteat!(deepcopy(t2), c) 
                            t3 = Vector{Any}(deleteat!(deepcopy(temp), d-1)) #length 2
                            if !(t3[1]=="na" && t3[2]=="na")
                                push!(ret, Vector{Any}([
                                    [t[i], t[j]], 
                                    [t1[a], t1[b]], 
                                    [t2[c], t2[d]], 
                                    [t3[1], t3[2]]
                                    ]))
                            end
                        end
                    end
                end
            end
        end
    end

    ret = Vector{Vector{Vector{Any}}}(unique!(ret)) #remove duplicated items (6 or 5 taxa)

    return ret
end

"""
    input: two N 
    output: true if the two networks are the same; false, otherwise
    compare_nw([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")],
               [("1", "2"), ("3", "4"), ("5", "6"), ("7", "9")]) -> false
    compare_nw([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")],
               [("1", "2"), ("3", "4"), ("5", "6"), ("8", "7")]) -> true     
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
    N_to_str([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8", "9")])
    -> "[(1,2),(3,4),(5,6),(7,8,9)]"   
"""
function N_to_str(N)
    ret = "["
    for n in N
        ret=ret*"("
        for j in n
            if j != "na"
                ret=string(ret, j*",")
            end
        end
        ret=ret[1:end-1]*"),"
    end
    return ret[1:end-1]*"]"
end

"""
    input: array of tuples, individuals from each triangles of the network  
    output: the parenthetical network format based on the wiki rules (default branch length and inheritance probability)
    N_to_network([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")])
    -> "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
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
    N_to_t([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")])
    -> [ "1", "2", "3", "4", "5", "6", "7", "8"]
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
    output: N_num 
    N_to_N_num([("1", "2"), ("3", "4"), ("5", "6"), ("7", "8")])
    -> "2222"
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

"""
    input: cf table
    output: an array of distinct taxa names
"""
function cf_to_t(cf)
    t = unique!(cf[:,1])
    t = vcat(t, unique!(cf[:,2]), unique!(cf[:,3]), unique!(cf[:,4]))
    return unique!(t)
end


"""
    generate_cf_from_gene_trees(filename_genetrees)

Read gene trees from a file (one newick tree per line) and return a `DataFrame` of
concordance factors: for each set of 4 taxa, the proportion of gene trees with each
of the 3 quartet topologies. The columns are `t1, t2, t3, t4, CF12_34, CF13_24, CF14_23`,
the format that [`phylo_diamond`](@ref) takes.
"""
function generate_cf_from_gene_trees(filename_genetrees)
    genetrees = readmultinewick(filename_genetrees)
    q, t = countquartetsintrees(genetrees)
    df_wide = DataFrame(tablequartetCF(q, t))
    df = df_wide[:, [:t1, :t2, :t3, :t4, :CF12_34, :CF13_24, :CF14_23]]
    return df
end
