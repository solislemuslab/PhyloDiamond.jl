# Quick start

This page runs PhyloDiamond on a small example. See [Input and output](input_output.md)
for the input formats and how to read the results in detail, and
[The method in brief](method.md) for what PhyloDiamond estimates.

## Install and load

PhyloDiamond is a [Julia](https://julialang.org) package. If you don't have Julia yet,
install it following the [official instructions](https://julialang.org/downloads/).
Then, inside Julia:

```julia
using Pkg
Pkg.add("PhyloDiamond")
```

Load the package at the start of every Julia session:

```@example qs
using PhyloDiamond
```

To see the help for a function, type `?` followed by its name, for example `?phylo_diamond`.

## Run on a file of gene trees

PhyloDiamond comes with a small example file: 100 gene trees on 8 taxa
(named `1` to `8`), one tree per line in newick format.
These gene trees were simulated on a network with hybrid clade `(1,2)`,
parent clades `(3,4)` and `(5,6)`, and remaining clade `(7,8)`.

```@example qs
genetrees = joinpath(pkgdir(PhyloDiamond), "test", "file", "gt.txt")
readline(genetrees) # the first gene tree
```

To estimate the 5 best-fitting networks:

```@example qs
res = phylo_diamond(genetrees, 5)
nothing # hide
```

The first run takes a few seconds because Julia compiles the code; later runs are faster.

## Read the result

`phylo_diamond` does three things:

- prints a report (above);
- writes the same report to `phylo_diamond.txt` in the current folder.
  If that file already exists, the new report is **added at the end**;
- returns a dictionary from rank (1 = best) to the network in extended newick format:

```@example qs
res[1]
```

Every candidate network has a single 4-node hybridization cycle that splits the taxa
into four clades, `n0`, `n1`, `n2` and `n3`. The best network in the report reads:

```
1. N2222 (0.03689157145883046)
[(1,2),(3,4),(5,6),(7,8)]
```

- `[(1,2),(3,4),(5,6),(7,8)]` lists the taxa in `n0`, `n1`, `n2`, `n3`:
  - `n0 = (1,2)` is the **hybrid clade**;
  - `n1 = (3,4)` and `n2 = (5,6)` are the two **parent clades** that `n0` inherits from;
  - `n3 = (7,8)` is the remaining clade.
- `N2222` is the number of taxa in `n0`, `n1`, `n2`, `n3`.
- The number in parentheses is the **invariant score**. Smaller scores mean
  the data fit that network better.

This is the network the gene trees were simulated on, so PhyloDiamond recovers the true clades.

Network 2 is the same network with `n1` and `n2` swapped. PhyloDiamond often
cannot tell the two parent clades apart, so these two networks usually have close scores.

!!! warning "Branch lengths and γ are placeholders"
    PhyloDiamond estimates only **which taxa are in each clade**. The branch lengths
    and inheritance probabilities in the newick strings are fixed placeholders
    (see [Input and output](@ref "What the newick string does and does not tell you")).

## Next steps

- To run PhyloDiamond on your own data (gene trees or a table of concordance
  factors), see [Input and output](input_output.md).
- To learn what the four clades and the score mean, see [The method in brief](method.md).

```@setup qs
rm("phylo_diamond.txt"; force = true) # keep the report file out of the deployed docs
```
