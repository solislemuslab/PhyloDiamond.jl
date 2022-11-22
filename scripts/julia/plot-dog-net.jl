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

# Network by PhyloNet ML/MPL

net2 = readTopology("(Dog:3.1093779661515573,((Coyote:7.208999474296622)#H1:1.219551624477565::0.37254126097149937,(GreyWolf:1.1053487333120922,(((AfricanHuntingDog:2.4260642271330113,Dhole:2.3564769490752617):2.772352422508372,GoldenJackal:0.22027852088219652):0.6767915156445676,#H1:0.036267875697669975::0.6274587390285007):0.8128409570875169):0.1316571705926631):0.12396177767673128);")
rootatnode!(net2,"AfricanHuntingDog")
plot(net2,:R, showNodeNumber=true)
rotate!(net2, -5)
plot(net2, style=:majortree, edgewidth=2.0, arrowlen=0.1,
tipoffset = 0.1, majorhybridedgecolor = "blue",
minorhybridedgecolor = "blue")

net3 = readTopology("(((GreyWolf:1.0,((GoldenJackal:1.0,(AfricanHuntingDog:1.0,Dhole:1.0):2.9515483888182037):0.9268244647120316)#H1:1.6389735456732464::0.4217546175615423):0.06249851837557456,(Coyote:1.0,#H1:0.05390224918811372::0.5782453824384577):1.1458980337503157):0.3200450215571163,Dog:1.0);")
rootatnode!(net3,"Coyote")
plot(net3,:R, showNodeNumber=true)
rotate!(net3, -4)
plot(net3, style=:majortree, edgewidth=2.0, arrowlen=0.1,
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