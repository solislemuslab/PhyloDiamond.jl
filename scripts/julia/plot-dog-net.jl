# Julia script to plot the dog network
# Claudia (November 2022)

using PhyloNetworks, PhyloPlots

# Network by SNaQ and invariants

net = readTopology("(((2,((6,4):0.4736595577884197,#H7:::0.2642622177134866):0.14802726306398745):1.5457473684659713,(5)#H7:::0.7357377822865134):2.4037173930657434,1,3);")




# Other networks

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