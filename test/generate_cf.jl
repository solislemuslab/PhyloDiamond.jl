#=
Simulate a concordance factor table from a 4-node-cycle network (used by the tests).
Moved out of the package so that PhyloDiamond does not depend on SNaQ.
=#

"""
    generate_cf(N, sd=0)

Expected concordance factors for the network with clades `N`
(e.g. `[("1","2"), ("3","4"), ("5","6"), ("7","8")]`), with default branch lengths
and γ (see `N_to_network`). `sd` controls Gaussian noise added to the CFs.
Returns a DataFrame with columns `tx1, tx2, tx3, tx4, expCF12, expCF13, expCF14`.
"""
function generate_cf(N, sd=0)
    network = N_to_network(N)
    net = readnewick(network)
    # clades with 3+ taxa are polytomies. SNaQ 1.2 errors on them inside
    # topologyQpseudolik! (update_yz! gets `nothing`), so resolve them here with
    # zero-length edges, as SNaQ/PhyloNetworks 0.15 did internally: expected CFs unchanged.
    for n in copy(net.node)
        if !n.hybrid && length(n.edge) > 3
            PhyloNetworks.resolvetreepolytomy!(net, n)
        end
    end

    quartets = SNaQ.allQuartets(tiplabels(net), false)
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

    df = DataFrame(tx1=tx1, tx2=tx2, tx3=tx3, tx4=tx4, CF12_34=ones(length(tx1)), CF13_24=zeros(length(tx1)), CF14_23=zeros(length(tx1)))
    cf = readtableCF!(df)

    ## compute the expected CFs on the fixed network (dummy observed CFs)
    topologyQpseudolik!(net, cf)
    df_wide = fittedquartetCF(cf)

    ## "true" concordance factors:
    cf = df_wide[:,[:tx1, :tx2, :tx3, :tx4, :expCF12, :expCF13, :expCF14]]

    ## adding noise to cf table
    noise = sd .* randn(nrow(cf))
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
