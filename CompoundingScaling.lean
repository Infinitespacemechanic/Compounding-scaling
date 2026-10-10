import Mathlib

def Hm : ℝ := Real.pi / 3 - 1

def growthStep (N : ℝ) : ℝ := N + Hm

def after (cycles : ℕ) (start : ℝ) : ℝ :=
  start + cycles * Hm

theorem growth_step_is_additive (N : ℝ) :
    growthStep N = N + Hm := rfl

theorem after_succ (cycles : ℕ) (start : ℝ) :
    after (cycles + 1) start = after cycles start + Hm := by
  simp only [after, Nat.cast_add, Nat.cast_one]
  ring

theorem million_step_value :
    after 1000000 1 = 1 + 1000000 * (Real.pi / 3 - 1) := by
  simp [after, Hm]

theorem million_step_bound :
    after 1000000 1 < 333335 := by
  rw [million_step_value]
  nlinarith [Real.pi_lt_four]
