for ((i = 0 ; i < 1 ; i++)); do #replicate
    for ((j = 1000 ; j < 1001 ; j*=10)); do #number of estimated gene trees: 1000, 10000
        for ((k = 500 ; k < 1001 ; k*=4)); do #length of gene sequences: 500, 2000
            sim_tree_path="./sim_trees/$j/"
            
            #N2222
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2222_$j\_$i > alignment.sg.phy
            split -l 9 -a 5 alignment.sg.phy
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2222_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy
            
            #N2221
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2221_$j\_$i > alignment.sg.phy
            split -l 8 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2221_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N2212
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2212_$j\_$i > alignment.sg.phy
            split -l 8 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2212_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N2122
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2122_$j\_$i > alignment.sg.phy
            split -l 8 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2122_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N1222
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_1222_$j\_$i > alignment.sg.phy
            split -l 8 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/1222_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N2211
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2211_$j\_$i > alignment.sg.phy
            split -l 7 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2211_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N2112
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2112_$j\_$i > alignment.sg.phy
            split -l 7 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2112_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N2121
            $sim_tree_path\sim_trees_2121_$j\_$i
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_2121_$j\_$i > alignment.sg.phy
            split -l 7 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/2121_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N1221
            $sim_tree_path\sim_trees_1221_$j\_$i
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_1221_$j\_$i > alignment.sg.phy
            split -l 7 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/1221_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N1212
            $sim_tree_path\sim_trees_1212_$j\_$i
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_1212_$j\_$i > alignment.sg.phy
            split -l 7 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/1212_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy

            #N1122
            seq-gen -mHKY -s0.036 -f0.300414,0.191363,0.196748,0.311475 -n1 -l$k < $sim_tree_path\sim_trees_1122_$j\_$i > alignment.sg.phy
            split -l 7 -a 5 alignment.sg.phy
            filename_splited=(x*)
            for h in x*; do
                iqtree2 -s $h --prefix "o$h"
            done
            cat *.treefile >> ./sim_trees/estimated_gene_trees_$j/1122_l$k\_$i
            rm o*
            rm x*
            rm alignment.sg.phy
        done
    done
done
