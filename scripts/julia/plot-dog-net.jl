# Julia script to plot the dog network
# Claudia (November 2022)

using PhyloNetworks, PhyloPlots

# Network by SNaQ and invariants

net = readTopology("(((Coyote,((GreyWolf,Dog):0.4736595577884197,#H7:::0.2642622177134866):0.14802726306398745):1.5457473684659713,(GoldenJackal)#H7:::0.7357377822865134):2.4037173930657434,AfricanHuntingDog,Dhole);")
rootatnode!(net,"AfricanHuntingDog")
plot(net,:R)
plot(net,:R, showNodeNumber=true)
rotate!(net, -2)
rotate!(net, -3)
rotate!(net, -4)
rotate!(net, -5)

using RCall
R"par"(mar=[.1,.1,.1,.1]);
plot(net, style=:majortree, edgewidth=2.0, arrowlen=0.1,
tipoffset = 0.1, majorhybridedgecolor = "forestgreen",
minorhybridedgecolor = "forestgreen")

# Network by PhyloNet ML

net2 = readTopology("(AfricanHuntingDog:1.6101210673311783,(Dhole:3.098659596612107,((GoldenJackal:0.06861236708130897)#H1:0.38708669395167933::0.748622919326696,(Coyote:3.9986647804844644,(#H1:0.8103263495430857::0.25137708067330405,(Dog:2.936141610506084,GreyWolf:0.5582715925453998):0.3935145303756744):0.08298883848855856):2.0660671784296514):2.678281274906509):3.7168919379799035);")
rootatnode!(net2,"AfricanHuntingDog")
plot(net2,:R, showNodeNumber=true)
rotate!(net2, -6)
plot(net2, style=:majortree, edgewidth=2.0, arrowlen=0.1,
tipoffset = 0.1, majorhybridedgecolor = "blue",
minorhybridedgecolor = "blue")
## same as snaq, so not included

# Network by PhyloNet MPL

net3 = readTopology("(AfricanHuntingDog:1.0,((((Coyote:1.0,(Dog:1.0,GreyWolf:1.0):0.5745418868229112):0.836566984410819,(GoldenJackal:1.0)#H1:1.0::0.940732692938983):2.2916146136988855,#H1:1.0::0.059267307061017016):0.8776623951631757,Dhole:1.0):5.909315396052653);")
rootatnode!(net3,"AfricanHuntingDog")
plot(net3,:R, showNodeNumber=true)
rotate!(net3, -3)
rotate!(net3, -4)
rotate!(net3, -5)
rotate!(net3, -6)
plot(net3, edgewidth=2.0, arrowlen=0.1,
tipoffset = 0.1, majorhybridedgecolor = "darkmagenta",
minorhybridedgecolor = "darkmagenta")

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