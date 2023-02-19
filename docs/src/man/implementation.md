# Implementing PhyloDiamond Algorithm
## Functions
To implement PhyloDiamond Algorithm, users can either input a concordance factor table or directly input a file of gene trees.
### Function taking in a concordance factor table
Below takes in three parameters including a concordance factor table:
```julia
phylo_diamond(cf::DataFrame, m::Int64, output_filename::String="phylo_diamond.txt")
```
- `cf`: a dataframe containing concordance factor values with taxon names in the first 4 columns and values in the last 3 columns
  - Each row correspond to a taxon set `s={a,b,c,d}`
  - There are only three possible quartet splits `q1=ab|cd, q2=ac|bd, q3=ad|bc`
  - The dataframe should contain 7 columns, ordered as `a, b, c, d, q1, q2, q3`
- `m`: the number of optimal phylogenetic networks returned
- `output_filename`: a file name for the output file (or "phylo_diamond.txt" by default)
### Function taking in a gene tree file
Below takes in three parameters including a gene tree file:
```julia
phylo_diamond(gene_trees_filename::String, m::Int64, output_filename::String="phylo_diamond.txt")
```
- `gene_trees_filename`: the file name storing all gene trees
- `m`: the number of optimal phylogenetic networks returned
- `output_filename`: a file name for the output file (or "phylo_diamond.txt" by default)


## Examples
First load the package.
```julia
using PhyloDiamond
```
### Example 1: taking in a concordance factor table
If your concordance factor table is in csv file format, you need to read the file in Julia first. If you have not used the CSV.jl package before then you may need to install it first:
```julia
using Pkg
Pkg.add("CSV")
```
The CSV.jl functions are not loaded automatically and must be imported into the session.
```julia
using CSV
```
The concordance factor table can now be read from a CSV file at path `input` using
```julia
df = DataFrame(CSV.File(input))
```
```
70×7 DataFrame
 Row │ tx1     tx2     tx3     tx4     expCF12    expCF13      expCF14     
     │ String  String  String  String  Float64    Float64      Float64     
─────┼─────────────────────────────────────────────────────────────────────
   1 │ 7       8       3       4       0.999392   0.000303961  0.000303961
   2 │ 7       8       3       1       0.993192   0.00340375   0.00340375
   3 │ 7       8       3       2       0.993192   0.00340375   0.00340375
   4 │ 7       8       3       5       0.98779    0.00610521   0.00610521
   5 │ 7       8       3       6       0.98779    0.00610521   0.00610521
   6 │ 7       8       4       1       0.993192   0.00340375   0.00340375
   7 │ 7       8       4       2       0.993192   0.00340375   0.00340375
   8 │ 7       8       4       5       0.98779    0.00610521   0.00610521
  ⋮  │   ⋮       ⋮       ⋮       ⋮         ⋮           ⋮            ⋮
  63 │ 3       1       2       6       0.0999344  0.0999344    0.800131
  64 │ 3       1       5       6       0.964386   0.0178072    0.0178072
  65 │ 3       2       5       6       0.964386   0.0178072    0.0178072
  66 │ 4       1       2       5       0.0999344  0.0999344    0.800131
  67 │ 4       1       2       6       0.0999344  0.0999344    0.800131
  68 │ 4       1       5       6       0.964386   0.0178072    0.0178072
  69 │ 4       2       5       6       0.964386   0.0178072    0.0178072
  70 │ 1       2       5       6       0.984151   0.00792452   0.00792452
```

Then we can implement PhyloDiamond algorithm on this concordance factor table. 
```julia
phylo_diamond(df, 5)
```
It outputs a dictionary, where is key is the rank and the value is the infered network. The networks are represented in newick format.
```
Dict{Int64, Any} with 5 entries:
  5 => "((7:1,8:1):4, (((1:1,2:1):2, ((3:1,4:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
  4 => "((5:1,6:1):4, (((7:1,8:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
  2 => "((7:1,8:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
  3 => "((5:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1):2):1):1);"
  1 => "((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
```

Below is what is stored in the output file:
```
Inference of top 5 8-taxon phylogenetic networks with phylogenetic invariants
1. N2222 (2.2216927709301364e-16)
[(1,2),(3,4),(5,6),(7,8)]
"((7:1,8:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
2. N2222 (2.2230610911746716e-16)
[(1,2),(5,6),(3,4),(7,8)]
"((7:1,8:1):4, (((5:1,6:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
3. N2222 (0.006576057988736475)
[(1,2),(3,4),(7,8),(5,6)]
"((5:1,6:1):4, (((3:1,4:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(7:1,8:1):2):1):1);"
4. N2222 (0.00657929000066336)
[(1,2),(7,8),(3,4),(5,6)]
"((5:1,6:1):4, (((7:1,8:1):2, ((1:1,2:1):1)#H1:1::0.7):1, (#H1:1::0.3,(3:1,4:1):2):1):1);"
5. N2222 (0.0066877783427965855)
[(3,4),(1,2),(5,6),(7,8)]
"((7:1,8:1):4, (((1:1,2:1):2, ((3:1,4:1):1)#H1:1::0.7):1, (#H1:1::0.3,(5:1,6:1):2):1):1);"
```
To understand the output file, take the first network as an example. `N2222` is the structure of the network, meaning that there are 2 taxon in clades n0, n1, n2, n3. The value followed is the corresponding score for the infered network, and a small score represents a highly possible network. `[(1,2),(3,4),(5,6),(7,8)]` is the parenthetical format of the network. Then it is the newick format of the network
### Example 2: taking in a gene tree file
Here is an example genetree file "gt.txt":
```
((7:0.722,8:0.722):2.844,(((3:0.878,4:0.878):0.907,(1:0.935,2:0.935):0.849):1.005,(5:1.853,6:1.853):0.937):0.776);
((7:0.649,8:0.649):2.104,((5:1.919,6:1.919):0.374,((3:0.634,4:0.634):1.442,(1:0.660,2:0.660):1.416):0.218):0.460);
((7:0.942,8:0.942):3.188,(6:3.361,(5:2.130,((1:0.816,2:0.816):1.294,(3:1.045,4:1.045):1.065):0.021):1.231):0.769);
  ⋮               ⋮               ⋮               ⋮               ⋮               ⋮               ⋮               ⋮
(((3:0.600,4:0.600):1.746,(1:0.841,2:0.841):1.506):0.654,((7:0.613,8:0.613):2.148,(5:0.762,6:0.762):1.999):0.239);
((7:0.702,8:0.702):2.679,((5:1.454,6:1.454):0.672,(3:1.942,(4:1.707,(1:0.674,2:0.674):1.033):0.234):0.184):1.255);
(((3:0.647,4:0.647):1.243,(1:1.407,2:1.407):0.483):0.844,((7:0.581,8:0.581):1.979,(5:1.204,6:1.204):1.357):0.173);
```
```julia
phylo_diamond("gt.txt", 5)
```

## Error reporting

Please report any bugs and errors by opening an
[issue](https://github.com/solislemuslab/PhyloDiamond.jl/issues/new).