#cd("/Users/zhaoxingwu/Desktop/claudia lab/2022 spring phylogenetic/phylo-invariants")
using PhyloNetworks
#raxmltrees = joinpath(dirname(pathof(PhyloNetworks)), "..","examples","raxmltrees.tre")
#less(raxmltrees)

genetrees = readMultiTopology("./simulation/sim_trees_2222_100");
q,t = countquartetsintrees(genetrees);
df = writeTableCF(q,t)