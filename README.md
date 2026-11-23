# A circuit gate can make a new low merge on several lines

This is an auxiliary research note about the circuit-counting approach in the public [P vs NP project](https://pequalnp.com/). It does not solve P vs NP, prove L-meta-606, or refute L-meta-606. It has not been accepted by the project's checker.

## Formal finite result

The accompanying Lean file constructs a monotone fan-in-two circuit with seven gates on six inputs. It computes

`(x0 AND y0) OR (x1 AND y0) OR (x2 AND y1) OR (x3 AND y1)`.

Its final OR gate is a **new low merge at both line inputs**, using the project's actual `IsNewLowMerge` definition. The incidence relation is rectangle-free. Thus an argument assigning at most one line to each new low-merge gate fails for unrestricted circuits, even in this small example.

The circuit has four AND gates, two branch OR gates, and a final OR. The branches are `(x0 AND y0) OR (x2 AND y1)` and `(x1 AND y0) OR (x3 AND y1)`.

## General family: mathematical argument

This paragraph is an informal argument reviewed independently; it is not formalized for arbitrary m in the attached Lean file.

For m >= 1, take m disjoint two-edge stars with point variables x_(0,w), x_(1,w) and line variables y_w. Compute the 2m terms x_(e,w) AND y_w. Separately OR the terms with e=0 into A and those with e=1 into B, then output A OR B. The circuit has 4m-1 gates.

Fix one line w by setting y_w=true and every other line input false. Before the output, every low wire is false or one of the singleton point functions x_(0,w), x_(1,w). The active line input itself is not low. Empty or singleton alive sets do not change the class labels in the definition's fold, so the labels remain the initial point labels. At the output, the two distinct point classes merge. The final gate is therefore a new low merge on every one of the m lines.

Consequently there is no absolute constant bounding the number of lines served by one new low-merge gate for arbitrary monotone fan-in-two circuits. Every gate of this example reaches the output, so deleting gates that cannot reach the output does not remove the obstruction.

## What remains open

This example does not contradict a bound on the total number of new merges proportional to the total circuit size. Its final gate serves m lines, while the circuit has 4m-1 gates. It also does not exclude arguments that first find a minimum-size circuit or prove a suitable normalization: the same function has a factored circuit with 3m-1 gates.

The useful next mathematical target is a bound that charges repeated line-dependent merges to work elsewhere in the circuit, or a normalization theorem that justifies a stronger local bound.

## Verification and reproduction

The finite Lean source compiled with exit 0 using the project's pinned Lean 4.36.0 and Mathlib revision fc4f59e577feb1a4956671bc04ac18aaaf8cd842. An axiom audit listed only propext, Classical.choice and Quot.sound. An independent agent reviewed the statement, witness, and argument.

The unchanged project checker returned no verdict: `CHECKER FAULT: the verifier ended without a verdict (exit 137).` A separate trivial `True` theorem also failed in the same environment. This is not an ACCEPTED result, and the precise cause of termination has not been established.

To reproduce, use the official repository at commit fb6bee7d9e1bdb1b1fe92937d8690c63a6df6de7 and its pinned toolchain and dependency manifest. Place L_meta_606_obstruction.lean in lean/PEqualNP/Outside/, fetch the pinned Mathlib cache by the project's instructions, then run from lean/:

```sh
lake build PEqualNP.Outside.L_meta_606_obstruction
```

For the full unchanged checker, place statement.txt at the repository root and run there:

```sh
node tools/check-lean.mjs lean/PEqualNP/Outside/L_meta_606_obstruction.lean statement.txt check
```

The statement is an auxiliary statement, not a posted gap eligible for a project proof PR. Public project definitions: [LowMerge](https://github.com/brilliant-hq/pequalnp-proofs/blob/fb6bee7d9e1bdb1b1fe92937d8690c63a6df6de7/lean/PEqualNP/Defs/LowMerge.lean) and [NewLowMerge](https://github.com/brilliant-hq/pequalnp-proofs/blob/fb6bee7d9e1bdb1b1fe92937d8690c63a6df6de7/lean/PEqualNP/Defs/NewLowMerge.lean).
