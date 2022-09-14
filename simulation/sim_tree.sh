for ((i = 0 ; i < 30 ; i++)); do #iterate replicates of gene trees
    for ((j = 100 ; j < 10001 ; j*=10)); do
        path="./sim_trees/$j/"
        #N2222
        ms-converter --newick="((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n $j --output=$path\sim_trees_2222_$j\_$i
        #N2221
        ms-converter --newick="((7:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n $j --output=$path\sim_trees_2221_$j\_$i
        #N2212
        ms-converter --newick="((7:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);" --run --n $j --output=$path\sim_trees_2212_$j\_$i
        #N2122
        ms-converter --newick="((7:1,4:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n $j --output=$path\sim_trees_2122_$j\_$i
        #N1222
        ms-converter --newick="((7:1,2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n $j --output=$path\sim_trees_1222_$j\_$i
        #N2211
        ms-converter --newick="((6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);" --run --n $j --output=$path\sim_trees_2211_$j\_$i
        #N2112
        ms-converter --newick="((4:1,6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1):2):1):1);" --run --n $j --output=$path\sim_trees_2112_$j\_$i
        #N2121
        ms-converter --newick="((6:1):4, (((3:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,4:1):2):1):1);" --run --n $j --output=$path\sim_trees_2121_$j\_$i
        #N1221
        ms-converter --newick="((2:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);" --run --n $j --output=$path\sim_trees_1221_$j\_$i
        #N1212
        ms-converter --newick="((5:1,6:1):4, (((3:1,4:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(2:1):2):1):1);" --run --n $j --output=$path\sim_trees_1212_$j\_$i
        #N1122
        ms-converter --newick="((5:1,6:1):4, (((2:1):2, ((1:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);" --run --n $j --output=$path\sim_trees_1122_$j\_$i
    done
done
