# PhyloDiamond.jl

[PhyloDiamond.jl](https://github.com/solislemuslab/PhyloDiamond.jl) is a
[Julia](https://julialang.org) package to find where a hybridization happened,
from gene trees or concordance factors. It looks for a phylogenetic network with
one 4-node hybridization cycle, and uses algebraic invariants instead of likelihood.
This makes it very fast: on the *Canis* data in the paper below, it took 7 seconds,
compared with 2 minutes for SNaQ.

## When to use it

Use PhyloDiamond to quickly find which taxa are involved in a hybridization:
the hybrid clade and its two parent clades. It is a good first step: it narrows
thousands of candidate networks down to a few. You can then compare those with a
likelihood method such as [SNaQ](https://github.com/JuliaPhylo/SNaQ.jl), which also
estimates inheritance probabilities and branch lengths.

PhyloDiamond needs at least 6 taxa and assumes a single 4-node hybridization cycle.
See [The method in brief](man/method.md) for what it can and cannot estimate.

## Where to go next

- [Quick start](man/quickstart.md): install PhyloDiamond and run it on an example.
- [Input and output](man/input_output.md): use your own gene trees or concordance
  factors, and read the results.
- [The method in brief](man/method.md): what PhyloDiamond estimates, and its assumptions.
- [Library](lib/public_methods.md): reference for the functions.

## Citation

If you use `PhyloDiamond.jl` in your work, we kindly ask that you cite the following paper:

- Wu, Z., Solís-Lemus, C. (2024). Ultrafast learning of four-node hybridization cycles in phylogenetic networks using algebraic invariants. *Bioinformatics Advances*, 4(1), vbae014. [doi:10.1093/bioadv/vbae014](https://doi.org/10.1093/bioadv/vbae014).

## Getting help

Please report bugs and ask questions by opening an [issue](https://github.com/solislemuslab/PhyloDiamond.jl/issues/new).
