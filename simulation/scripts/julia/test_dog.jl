"""
cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
include("./scripts/julia/mapping.jl")
include("./scripts/julia/invariants.jl")
include("./scripts/julia/test_invariants.jl")
"""

using PhyloNetworks, PhyloPlots, DataFrames, CSV, Statistics, Distributions, Random, DelimitedFiles, Combinatorics
using JLD2

#https://github.com/chaoszhang/Weighted-ASTRAL_data
#https://www.sciencedirect.com/science/article/pii/S0960982218311254

#choose(13, 4) = 715
#choose(12, 4)
function main()
end

function read_gene_trees()
    #cf = generate_cf_from_gene_trees("./simulation/dogs_estimated_gene_trees.tree")
    #genetrees = readMultiTopology("./simulation/sim_trees/dogs_estimated_gene_trees.tree")
    #save_object("dog_genetrees.jld2", genetrees)
    #DataFrame(taxon = unique!(vcat(df[:, "t1"], df[:, "t2"], df[:, "t3"], df[:, "t4"])))

    """
    tm = DataFrame(CSV.File("./simulation/sim_trees/dog/taxonmap.csv"))
    taxonmap = Dict(row[:individual] => row[:species] for row in eachrow(tm))
    genetrees = load_object("dog_genetrees.jld2")
    q,t = countquartetsintrees(genetrees, taxonmap, showprogressbar=true);
    save_object("q.jld2", q)
    save_object("t.jld2", t)
    df_wide = writeTableCF(q,t)
    df = df_wide[:,[:t1, :t2, :t3, :t4, :CF12_34, :CF13_24, :CF14_23]]
    save_object("cf_dog.jld2", df)
    
    
    df = load_object("./simulation/sim_trees/dog/cf_dog_merged.jld2")
    tm = DataFrame(CSV.File("./simulation/sim_trees/dog/taxonmap.csv"))
    taxon = unique!(tm[:,"species"])

    for temp in ["Grey wolf Asian (Eurasian)", "Grey wolf North American", "Grey wolf Middle Eastern",
        "African golden wolf hybrid", "African golden wolf Northwestern","African golden wolf Eastern",
        "AndeanFox"]
        deleteat!(taxon, findall(x->x==temp,taxon))
        df = df[df[:,"t1"].!=temp,:]
        df = df[df[:,"t2"].!=temp,:]
        df = df[df[:,"t3"].!=temp,:]
        df = df[df[:,"t4"].!=temp,:]
    end
    
    value_map = Dict(taxon[i] => i for i in 1:length(taxon))
    for col in ["t1", "t2", "t3", "t4"]
        for i in 1:nrow(df)
            df[i,col] = string(value_map[df[i,col]])
        end
    end
    """
end

function run_snaq()
    @time net0 = snaq!(readTopology("./simulation/sim_trees/dog/start.tree"), readTableCF(df), hmax=1, filename="net0_bucky", seed=123, runs=10)
end

function script_phylonet_dog_unrooted()
    f = open("./simulation/sim_trees/dog/dogs_estimated_gene_trees.tree", "r")
    file = open("dog.nex", "a")
    cnt = 0
    write(file, "#NEXUS\nBEGIN Trees;\n")
    for line in readlines(f)
        cnt+=1
        net = readTopology(line)
        leaf = []
        for i in net.leaf
            push!(leaf, i.name)
        end
        #delete species
        for i in leaf
            if i in ind_del
                deleteleaf!(net, i, keeporiginalroot=true)
            end
        end

        flag = Dict(Pair.(taxon, false))
        net_merge = net
        leaf_del = []
        leaf = []
        for i in net.leaf
            push!(leaf, i.name)
        end
        for i in 1:length(leaf)
            if leaf[i] in tm[:,"individual"]
                if !flag[tm_dict[leaf[i]]]
                    flag[tm_dict[leaf[i]]] = true
                    net_merge.leaf[i].name = string(value_map[tm_dict[leaf[i]]])
                else
                    push!(leaf_del, leaf[i])
                end
            end
        end
        for i in leaf_del
            deleteleaf!(net_merge, i, keeporiginalroot=true)
        end
        if length(net_merge.leaf) > 3
            write(file, "Tree gt"* string(cnt)* "="* writeTopology(net_merge)*"\n")
        end
    end
    write(file, "END;\nBEGIN PHYLONET;\nInferNetwork_MPL (all) 1 -x 10 -pl 10;\nEND;")
    close(f)
    close(file)
end

#creating input file for phylonet
function script_phylonet_dog_rooted()
    f = open("./scripts/julia/dog.nex", "r")
    file = open("dog_rooted.nex", "a")
    cnt = 0
    write(file, "#NEXUS\nBEGIN Trees;\n")
    for line in readlines(f)
        if startswith(line, "Tree")
            _, net = split(line, "=")
            net = readTopology(net)
            if net.numTaxa > 4
                cnt+=1
                if "1" in tipLabels(net)
                    rootatnode!(net,"1")
                else
                    rootatnode!(net,"3")
                end
                write(file, "Tree gt"* string(cnt)* "="* writeTopology(net)*"\n")
            end
        end
    end
    write(file, "END;\nBEGIN PHYLONET;\nInferNetwork_MPL (all) 1 -x 10 -pl 10;\nEND;")
    close(f)
    close(file)
end

main()

"""
tm = DataFrame(CSV.File("./simulation/sim_trees/dog/taxonmap.csv")) #6 species
    for temp in ["Grey wolf Asian (Eurasian)", "Grey wolf North American", "Grey wolf Middle Eastern",
        "African golden wolf hybrid", "African golden wolf Northwestern","African golden wolf Eastern",
        "AndeanFox"]
        tm = tm[tm[:,"species"].!=temp,:]
    end
    tm_dict = Dict(Pair.(tm.individual, tm.species))
    taxon = unique!(tm[:,"species"])
    value_map = Dict(taxon[i] => i for i in 1:length(taxon))

    tm_del = DataFrame(CSV.File("./simulation/sim_trees/dog/taxonmap_del.csv")) #species need to be deleted
    ind_del = tm_del[:, "individual"]

    
"""