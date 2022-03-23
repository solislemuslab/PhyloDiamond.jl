"""
    input:
        n: array of tuples, individuals from each triangles of the network
        q: individuals of the quartet
        eg. get_n([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], ["C", "E", "G", "H"])
            [0, 1, 1, 2]
    output: the number of individuals from each of the 4 triangles of the network (the quartet structure)
"""
function get_n(n, q)
    rst = [0, 0, 0, 0]
    for i in 1:4
        for j in 1:4
            if q[j] in n[i]
                rst[i] += 1
            end
        end
    end
    return rst
end

"""
    input:
        q: individuals of the quartet
        df_cf: the dataframe storing the cf values
    eg. get_cf(["A","B","E","C"], 
                [["A","B","E","F",0.9628253832799631,0.01858730836001843,0.01858730836001843],
                 ["A","B","E","C",0.8718629189804454,0.06406854050977726,0.06406854050977726]])
        ["A","B","E","C",0.8718629189804454,0.06406854050977726,0.06406854050977726]
    output: the corresponding cf value for the quartet
"""
function get_cf(q, df_cf)
    for i in df_cf
        if (q[1] in i) & (q[2] in i) & (q[3] in i) & (q[4] in i)
            return i
        end
    end
    return false
end

"""
    input:
        n: array of tuples, individuals from each triangles of the network
        q: individuals of the quartet
        df_cf: the dataframe storing the cf values
    eg. get_cf_m([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")],
                ["A","B","E","C"], 
                [["A","B","E","F",0.9628253832799631,0.01858730836001843,0.01858730836001843],
                 ["A","B","E","C",0.8718629189804454,0.06406854050977726,0.06406854050977726]])
        0.8718629189804454
    output: find the major split value
"""

function get_cf_m(n, q, df_cf)
    n_struc = get_n(n, q)
    cf = get_cf(q, df_cf)
    taxon_major = findall(x->x==2, n_struc) # the taxon with major split
    ret = [n[taxon_major[1]][1], n[taxon_major[1]][2]]
    if cf[1] == ret[1]
        i = findall(x->x==ret[2], cf)
        return cf[i[1]+3]
    elseif cf[1] == ret[2]
        i = findall(x->x==ret[1], cf)
        return cf[i[1]+3]
    elseif (cf[2] == ret[1]) & (cf[3] == ret[2]) |
        (cf[2] == ret[2]) & (cf[3] == ret[1])
        return cf[7]
    elseif (cf[2] == ret[1]) & (cf[4] == ret[2]) |
        (cf[2] == ret[2]) & (cf[4] == ret[1])
        return cf[6]
    elseif (cf[3] == ret[1]) & (cf[4] == ret[2]) |
        (cf[3] == ret[2]) & (cf[4] == ret[1])
        return cf[5]
    end
    return false
end