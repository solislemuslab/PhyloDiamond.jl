# Julia script to plot the dog network
# Claudia (November 2022)

using PhyloNetworks, PhyloPlots

net = readTopology("((((((1,3),5),(2)#H1),6),#H1),4);")
rootatnode!(net,"1")

plot(net,:R, showNodeNumber=true)
rotate!(net, -4)

## Now with the names:
net = readTopology("((((((AfricanHuntDog,Dhole),GoldenJackal),(Coyote)#H1),GreyWolfEUR),#H1),Dog);")
rootatnode!(net,"AfricanHuntDog")

plot(net,:R, showNodeNumber=true)
rotate!(net, -4)
plot(net,:R)