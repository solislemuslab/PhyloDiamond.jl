# Draws io_network.png (used in man/input_output.md). Not run during the docs build.
# Needs PhyloNetworks, PhyloPlots, RCall and R. Usage:
#   julia io_network.jl io_network.png
# Made with Julia 1.13.1, PhyloNetworks 1.5.0, PhyloPlots 2.1.0, RCall 0.14.14.
using PhyloNetworks, PhyloPlots, RCall
nw = "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
net = readnewick(nw)
R"png"(ARGS[1], width=600, height=400, res=100)
R"par"(mar=[0,0,0,0])
plot(net)
R"dev.off()"
