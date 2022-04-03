using CSV, DataFrames
# cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/code")

function main()
    cf = CSV.read("N2222_expCF.txt", DataFrame)
    for i in 1:70
        temp = Array(cf[i, :])
        q = temp[1:4]
        cfs = temp[5:7]
        n = get_n([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], q)
        if n != [1, 1, 1, 1]
            #print(q)
            #println(cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], q, cfs))
        end
    end
    get_a(cf, [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")])
end

"""
    input:
        N: array of tuples, individuals from each triangles of the network
        q: individuals of the quartet
        eg. get_n([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], ["C", "E", "G", "H"])
            [0, 1, 1, 2]
    output: the number of individuals from each of the 4 triangles of the network (the quartet structure)
"""
function get_n(N, q)
    rst = [0, 0, 0, 0]
    for i in 1:4
        for j in 1:4
            if q[j] in N[i]
                rst[i] += 1
            end
        end
    end
    return rst
end

"""
    input:
        N: array of tuples, individuals from each triangles of the network
        q: individuals of the quartet
        cfs: the dataframe storing the cf values
    eg. cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")],
                ["A","B","E","C"], 
                [0.8718629189804454,0.06406854050977726,0.06406854050977726])
        [0.8718629189804454,0.06406854050977726,0.06406854050977726]
    output: returns the CFs in the order major, minor, minor
"""
function cfs_in_order(N, q, cfs)
    n = get_n(N, q)
    # ignore the case [1, 1, 1, 1]
    ind_major = findall(x->x==2, n)[1] # index of n with major split
    ret = [N[ind_major][1], N[ind_major][2]] # the two taxon in the major split
    # if q[1] is one of the two taxon in the major split
    # locate `a` with index of the other taxon in q
    if q[1] == ret[1]
        i = findall(x->x==ret[2], q)[1]
        if i == 2
            return [cfs[1], cfs[2], cfs[3]]
        elseif i == 3
            return [cfs[2], cfs[1], cfs[3]]
        elseif i == 4
            return [cfs[3], cfs[1], cfs[2]]
        end
    elseif q[1] == ret[2]
        i = findall(x->x==ret[1], q)[1]
        if i == 2
            return [cfs[1], cfs[2], cfs[3]]
        elseif i == 3
            return [cfs[2], cfs[1], cfs[3]]
        elseif i == 4
            return [cfs[3], cfs[1], cfs[2]]
        end
    # if q[1] is not one of the two taxon in the major split
    elseif (q[2] == ret[1]) & (q[3] == ret[2]) |
        (q[2] == ret[2]) & (q[3] == ret[1])
        return [cfs[3], cfs[1], cfs[2]]
    elseif (q[2] == ret[1]) & (q[4] == ret[2]) |
        (q[2] == ret[2]) & (q[4] == ret[1])
        return [cfs[2], cfs[1], cfs[3]]
    elseif (q[3] == ret[1]) & (q[4] == ret[2]) |
        (q[3] == ret[2]) & (q[4] == ret[1])
        return [cfs[1], cfs[2], cfs[3]]
    end
    return false
end

"""
    input:
        df: dataframe of concordance factors
        N: array of tuples, individuals from each triangles of the network
    output: returns vector a
        for a's with the same quartet structure `n`, take the mean of a's
        the order of a is determined by the order of its corresponding quartet structure in the dataframe

"""
function get_a(df, N)
    a = []
    c = [] # create vector that counts how many rows are mapped to each a value
    n_arr = [] # keep track of what quartet structure a stands for
    for i in 1:70
        temp = Array(cf[i, :])
        q = temp[1:4]
        cfs = [temp[5], temp[6], temp[7]]
        n = get_n(N, q)
        if n != [1, 1, 1, 1] #skip it for now
            cfs_ord = cfs_in_order(N, q, cfs)
            ind = findall(x->x==n, n_arr) # check if the same quartet structure has been visited before
            if size(ind) != (0,) # if the same quarter structure has been found
                a[ind[1]] += cfs
                c[ind[1]] += 1
            else # if not found
                push!(a, cfs)
                push!(c, 1)
                push!(n_arr, n)
            end
        end
    end

    for i in 1:length(c)
        a[i] = a[i]/c[i] # take the mean of a
    end

    ret = []
    for i in a 
        push!(ret, i[1])
        push!(ret, i[2])
        push!(ret, i[3])
    end
    return ret
end

main()