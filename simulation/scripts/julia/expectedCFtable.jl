using PhyloNetworks
using PhyloPlots
using DataFrames
using CSV

## Read network in parenthetical format
net = readTopology("((((A,B))#H1:::0.8,((E,F),(#H1:::0.2,(C,D)))),(G,H));")
plot(net,:R) ## just to check it matches the ipad notes
printEdges(net) 

## List of quartets and create dummy CF table with observed cf
## we need this CF table so that readTableCF creates the DataCF object
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

## We need to optimize the pseudolikelihood
## on the network for those dummy observed CF
## in order to compute the expected CFs
topologyQPseudolik!(net, cf)
df_wide = fittedQuartetCF(cf)

## "true" concordance factors:
expcf = df_wide[:,[:tx1, :tx2, :tx3, :tx4, :expCF12, :expCF13, :expCF14]]
CSV.write("scripts/julia/N2222_expCF.txt", expcf)