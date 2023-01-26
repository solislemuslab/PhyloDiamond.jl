using CSV, DataFrames

"""
    input:
        N: array of tuples, individuals from each triangles of the network
        q: individuals of the quartet
        eg. get_n([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], ["C", "E", "G", "H"])
            [0, 1, 1, 2]
            get_n([("A", "B"), ("C", "D"), ("E", NaN), ("G", "H")], ["C", "E", "G", "H"])
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

    if n != [1, 1, 1, 1] 
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
    end

    #handle case1111
    #enumerate all possible order of q, and its corresponding cf
    all_cfs = []
    all_q = []
    push!(all_cfs, [cfs[1], cfs[2], cfs[3]])
    push!(all_q, [q[1], q[2], q[3], q[4]])
    push!(all_q, [q[2], q[1], q[4], q[3]])
    push!(all_q, [q[3], q[4], q[1], q[2]])
    push!(all_q, [q[4], q[3], q[2], q[1]])

    push!(all_cfs, [cfs[1], cfs[3], cfs[2]])  
    push!(all_q, [q[1], q[2], q[4], q[3]])
    push!(all_q, [q[2], q[1], q[3], q[4]])
    push!(all_q, [q[3], q[4], q[2], q[1]])
    push!(all_q, [q[4], q[3], q[1], q[2]])

    push!(all_cfs, [cfs[2], cfs[1], cfs[3]])
    push!(all_q, [q[1], q[3], q[2], q[4]])
    push!(all_q, [q[2], q[4], q[1], q[3]])
    push!(all_q, [q[3], q[1], q[4], q[2]])
    push!(all_q, [q[4], q[2], q[3], q[1]])

    push!(all_cfs, [cfs[2], cfs[3], cfs[1]])
    push!(all_q, [q[1], q[3], q[4], q[2]])
    push!(all_q, [q[2], q[4], q[3], q[1]])
    push!(all_q, [q[3], q[1], q[2], q[4]])
    push!(all_q, [q[4], q[2], q[1], q[3]])

    push!(all_cfs, [cfs[3], cfs[2], cfs[1]])
    push!(all_q, [q[1], q[4], q[3], q[2]])
    push!(all_q, [q[2], q[3], q[4], q[1]])
    push!(all_q, [q[3], q[2], q[1], q[4]])
    push!(all_q, [q[4], q[1], q[2], q[3]])

    push!(all_cfs, [cfs[3], cfs[1], cfs[2]])
    push!(all_q, [q[1], q[4], q[2], q[3]])
    push!(all_q, [q[2], q[3], q[1], q[4]])
    push!(all_q, [q[3], q[2], q[4], q[1]])
    push!(all_q, [q[4], q[1], q[3], q[2]])

    q_order = [] #reorder quartet according to order of N
    for i in 1:4
        for j in 1:4
            if q[j] in N[i]
                push!(q_order, q[j])
            end
        end
    end

    if n == [1, 1, 1, 1] 
        ind = findall(x->x==q_order, all_q)[1]
        return all_cfs[(ind-1)÷4+1]
    end
    
    return false
end

"""
    input:
        cf: dataframe of concordance factors
        N: array of tuples, individuals from each triangles of the network
        verbose (default false): print variables to screen
    output: returns vector a
        for a's with the same quartet structure `n`, take the mean of a's
        the order of a is determined by the order of n_order

"""
function get_a(cf, N; verbose=false::Bool)
    # 19 different n, 57 different a
    # this is a vector that we control (as developers), so we can define it internally
    n_order = [[0, 0, 2, 2], [0, 1, 2, 1], [0, 1, 1, 2], [0, 2, 2, 0], 
                [0, 2, 1, 1], [0, 2, 0, 2], [1, 0, 2, 1], [1, 0, 1, 2], 
                [1, 1, 2, 0], [1, 1, 1, 1], [1, 1, 0, 2], [1, 2, 1, 0], 
                [1, 2, 0, 1], [2, 0, 2, 0], [2, 0, 1, 1], [2, 0, 0, 2], 
                [2, 1, 1, 0], [2, 1, 0, 1], [2, 2, 0, 0]]   
    a = zeros(length(n_order)*3) 
    c = zeros(length(n_order)*3) #create vector that counts how many rows are mapped to each a value
                                 #it has the repeated entried to match the dimension of a

    for i in 1:nrow(cf)
        verbose && @show i
        temp = Array(cf[i, :])
        q = temp[1:4]
        verbose && @show q
        cfs = [temp[5], temp[6], temp[7]]
        verbose && @show cfs
        n = get_n(N, q)
        verbose && @show n
        if (sum(n) != 4) #if input network does not match with cf table
            continue
        end

        cfs_ord = cfs_in_order(N, q, cfs) #reorder cf as major, minor, minor
                                          #according to N
        verbose && @show cfs_ord
        ind = findall(x->x==n, n_order)[1] #the correct index of n in vector a
        verbose && @show ind
        a[ind*3] += cfs_ord[3]
        a[ind*3-1] += cfs_ord[2]
        a[ind*3-2] += cfs_ord[1]
        c[ind*3] += 1
        c[ind*3-1] += 1
        c[ind*3-2] += 1
    end

    a = a./c
    
    return a
end