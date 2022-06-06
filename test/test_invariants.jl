## Script to test invariants on a given network
## Steps 2,3,4 are based on expectedCFTable.jl
## Steps 5,6,7 are from manual_tests.jl
## Claudia (June 2022)

using PhyloNetworks
using PhyloPlots
using DataFrames
using CSV

## 1. Choose a network in N vector format
N = [("A","E"),("C","B"),("D","F"),("G","H")]

## 2. Write the network in parenthetical format
## For this step, you need to draw the network by hand (rooted)
## and write the parenthetical format based on the wiki rules
network = "((((A,B))#H1:::0.8,((E,F),(#H1:::0.2,(C,D)))),(G,H));"


## 3. Read network in parenthetical format
net = readTopology(network)
plot(net,:R) ## just to check it matches your drawing


## 4. Create table of CF values
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
cf = df_wide[:,[:tx1, :tx2, :tx3, :tx4, :expCF12, :expCF13, :expCF14]]

## 5. Get the vector of a
a = get_a(cf, N)

## 6. Evaluating invariants on the true networks
## So, we expect numbers to be close to zero
## With the true network having the smallest value
norm(inv_net1112(a))
norm(inv_net1121(a))
norm(inv_net1211(a))
norm(inv_net2111(a))
norm(inv_net1122(a))
norm(inv_net1212(a))
norm(inv_net2112(a))
norm(inv_net2211(a))
norm(inv_net2121(a))
norm(inv_net1221(a))
norm(inv_net1222(a))
norm(inv_net2212(a))

## 7. Test a wrong network to see that invariants
## are not close to zero
N = [("A","E"),("C","B"),("D","F"),("G","H")]
a = get_a(cf, N)

norm(inv_net1112(a))
norm(inv_net1121(a))
norm(inv_net1211(a))
norm(inv_net2111(a))
norm(inv_net1122(a))
norm(inv_net1212(a))
norm(inv_net2112(a))
norm(inv_net2211(a))
norm(inv_net2121(a))
norm(inv_net1221(a))
norm(inv_net1222(a))
norm(inv_net2212(a))