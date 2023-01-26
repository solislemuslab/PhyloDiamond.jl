# phylo-invariants
Method to estimate phylogenetic networks from invariants

- Example code for gene tree simulation
- More detailed bash script for gene tree simulation could be found in `./simulation/sim_tree.sh`

```bash
./ms-converter --newick="((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n 100 --output=sim_trees_2222_100

./ms-converter --newick="((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n 100 --output=sim_trees_2221_100

./ms-converter --newick="((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);" --run --n 100 --output=sim_trees_2212_100

./ms-converter --newick="((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n 100 --output=sim_trees_2122_100

./ms-converter --newick="((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n 100 --output=sim_trees_1222_100

./ms-converter --newick="((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);" --run --n 100 --output=sim_trees_2211_100

./ms-converter --newick="((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);" --run --n 100 --output=sim_trees_2112_100

./ms-converter --newick="((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);" --run --n 100 --output=sim_trees_2121_100

./ms-converter --newick="((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n 100 --output=sim_trees_1221_100

./ms-converter --newick="((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);" --run --n 100 --output=sim_trees_1212_100

./ms-converter --newick="((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);" --run --n 100 --output=sim_trees_1122_100
```
