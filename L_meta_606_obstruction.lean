import PEqualNP.Defs

namespace PEqualNP.Outside.L_meta_606_obstruction

open PEqualNP.CircuitLowerBounds

def exampleCircuit : Circuit :=
  ⟨[⟨GateOp.and, [0, 4]⟩,
    ⟨GateOp.and, [1, 4]⟩,
    ⟨GateOp.and, [2, 5]⟩,
    ⟨GateOp.and, [3, 5]⟩,
    ⟨GateOp.or, [6, 8]⟩,
    ⟨GateOp.or, [7, 9]⟩,
    ⟨GateOp.or, [10, 11]⟩], 12⟩

end PEqualNP.Outside.L_meta_606_obstruction

open PEqualNP.Outside.L_meta_606_obstruction

set_option maxRecDepth 10000 in
set_option maxHeartbeats 4000000 in
theorem PEqualNP.Outside.L_meta_606_obstruction :
    ∃ C : PEqualNP.CircuitLowerBounds.Circuit,
      PEqualNP.MetaComplexity.Monotone2 C ∧ C.size = 7 ∧ C.output = 12 ∧
      (∀ (x : Fin 4 → Bool) (y : Fin 2 → Bool),
        C.eval (List.ofFn x ++ List.ofFn y) =
          decide (∃ (p : Fin 4) (w : Fin 2),
            p.val / 2 = w.val ∧ x p = true ∧ y w = true)) ∧
      (∀ w : Fin 2,
        PEqualNP.LowMerge.IsNewLowMerge 4 2
          (fun p w => decide (p.val / 2 = w.val)) C 12 w) ∧
      (∀ (p p' : Fin 4) (w w' : Fin 2), p ≠ p' → w ≠ w' →
        ¬ (p.val / 2 = w.val ∧ p.val / 2 = w'.val ∧
           p'.val / 2 = w.val ∧ p'.val / 2 = w'.val)) := by
  refine ⟨exampleCircuit, ?_, rfl, rfl, ?_, ?_, ?_⟩
  · simp [PEqualNP.MetaComplexity.Monotone2, exampleCircuit]
  · decide
  · decide
  · decide
