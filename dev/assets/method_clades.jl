# Draws method_clades.png (used in man/method.md). Not run during the docs build.
# Needs PhyloNetworks, PhyloPlots, RCall and R. Usage:
#   julia method_clades.jl method_clades.png
# Made with Julia 1.13.1, PhyloNetworks 1.5.0, PhyloPlots 2.1.0, RCall 0.14.14.
using PhyloNetworks, PhyloPlots, RCall
net = readnewick("(n3:2,((n1:2,(n0:1)#H1:1::0.7):1,(#H1:1::0.3,n2:2):1):1);")
labels = Dict("n0" => "n0: hybrid clade", "n1" => "n1: parent clade",
              "n2" => "n2: parent clade", "n3" => "n3: remaining clade")
for l in net.leaf; l.name = labels[l.name]; end
R"png"(ARGS[1], width=600, height=360, res=100)
R"par"(mar=[0,0,0,0])
plot(net, xlim=[0.5, 7.5])
R"dev.off()"
