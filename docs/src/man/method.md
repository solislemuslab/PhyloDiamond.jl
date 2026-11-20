# The method in brief

PhyloDiamond estimates where a hybridization happened from concordance factors,
using **phylogenetic invariants** instead of likelihood. This makes it very fast,
but it estimates less than likelihood methods such as SNaQ. This page explains what
it estimates and what it does not. See
[Wu and Solís-Lemus (2024)](https://doi.org/10.1093/bioadv/vbae014) for the details.

## The model: one 4-node hybridization cycle

PhyloDiamond assumes the gene trees come from the multispecies network coalescent on a
level-1 network with **one hybridization event that forms a cycle of 4 nodes**
(the "diamond"). The cycle splits the taxa into four clades:

- `n0`: the **hybrid clade**, below the hybrid node;
- `n1` and `n2`: the two **parent clades**, the sister clades whose ancestors
  contributed genes to the hybrid clade;
- `n3`: the remaining clade.

The network type `N2222` gives the number of taxa in `n0`, `n1`, `n2`, `n3`, in that
order. `N1112` has one taxon in each of `n0`, `n1`, `n2` and two in `n3`.

## Phylogenetic invariants

For a given network, the expected CFs of all 4-taxon sets are functions of the
network's branch lengths and inheritance probability γ. A **phylogenetic invariant**
is a polynomial in the CFs that equals zero for every choice of branch lengths and γ
when the data come from that network. Invariants depend only on how the taxa are
split into the four clades.

The invariants were derived once, for each network type with up to 8 taxa, by
eliminating the branch lengths and γ from the CF equations (a Gröbner basis
computation in Macaulay2). PhyloDiamond stores them as ready-to-use formulas.
No algebra is done when you run it.

## The score

For each candidate network, PhyloDiamond:

1. puts the CFs from your data into that network's invariants;
2. takes the L2 norm of each set of invariants. A network has one set for itself and
   one for each smaller network type it contains;
3. averages these norms. This is the **invariant score**.

If the data fit the network perfectly, every invariant is zero and so is the score.
With real data, the score is never exactly zero, and smaller is better.
PhyloDiamond scores every candidate network and reports the `m` lowest.

## What PhyloDiamond can and cannot tell you

PhyloDiamond estimates the **position of the hybridization cycle**: which taxa are in
the hybrid clade, in each parent clade, and in the remaining clade.

It does **not** estimate:

- **γ or branch lengths.** The invariants do not depend on them, which is why the
  output newick strings use fixed placeholder values.
- **Relationships inside a clade.**
- **Which parent clade is major.** Swapping `n1` and `n2` gives a network with a
  similar score, so the two usually rank next to each other.

Accuracy also depends on the data. In the paper's simulations:

- Networks with a **single taxon in the hybrid clade** were hard to recover with
  fewer than 10,000 gene trees.
- With at least 2 taxa in each clade, accuracy was high.

Results also depend on which taxa are sampled.

## Why report several networks

The true network, or its `n1`/`n2` swap, is usually among the 5 best-scoring networks,
even when it is not the first. That is why we recommend `m = 5`. A practical approach
is to use PhyloDiamond to narrow thousands of candidate networks down to a few, and then
compare those few with a likelihood method such as SNaQ. The likelihood method can
also estimate γ and branch lengths.

## How long it takes

With 6 to 8 taxa, PhyloDiamond scores all candidate networks (2520 for 8 taxa).
With more taxa, it scores every 8-taxon subset and then places the remaining taxa
(see [Input and output](@ref "More than 8 taxa")).

On the *Canis* data analyzed in the paper (6 taxa, 449,450 gene trees),
PhyloDiamond took 6.78 seconds, compared with 140.58 seconds for SNaQ. It recovered
the same hybridization as SNaQ and PhyloNet's maximum likelihood method: from the
ancestor of dogs and grey wolves into the golden jackal.

## Assumptions to keep in mind

- **Only one 4-node hybridization cycle.** PhyloDiamond always returns a network of
  this shape, even when the data come from a tree, a network with more than one
  hybridization, or a cycle of another size.
- **At least 6 taxa.**
