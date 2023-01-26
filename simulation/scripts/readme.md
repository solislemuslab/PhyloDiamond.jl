# Julia

- `text_convert.jl` contains the functions to convert between the julia, latex and macaulay formats for the invariants.
- `invariants.jl` contains the invariant functions with `a` as input vector (CF values from CF table)
- `mapping.jl` contains the functions to map the CF values from a CF table into the `a` vector
- `mapping-fn.jl` pseudo code for mapping CF table to values

# Macaulay2

- (all): all cf
- (sub): independent cf
- (incomplete): a subset of cf that gives output
- (quadratic): cf containing quadratic terms

## Macaulay2 scripts to obtain the phylogenetic invariants

The scripts correspond to networks with 4-cycle hybridizations (4 nodes in the hybridization cycle). `Nijkl` represents the specific network; for example, `N1112` corresponds to the network with 1 taxon from `n_0`, 1 taxon from `n_1`, 1 taxon from `n_2` and 2 taxa from `n_3`.

Files with extension `.m2` are the macaulay2 script and the files with `_out.txt` in the file name are the output files. Some scripts do not have output files because they were computationally intensive and have not been run to completion.

The command to run the scripts in the terminal is (after having installed [Macaulay2](http://www2.macaulay2.com/Macaulay2/)):
```
cat file.m2 | M2 >& file_out.txt &
```
