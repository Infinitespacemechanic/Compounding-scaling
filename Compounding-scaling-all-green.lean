import Mathlib

open Real

/-! # Compounding-scaling - Coastal Closing - Mechanical Higgs 0.0472
  Rob Laakkonen - Infinitespacemechanic
  There's a fine point on the ruler... productive, predictable, steady
  Runs 1 million cycles without blowing up
  Tape 1.0472 field vs Laser π/3 full
-/

-- LASER SURVEY: full Pi, perfect packing
def pi3 : ℝ := π / 3
def Hm : ℝ := pi3 - 1
def Hm_tape : ℚ := 472 / 10000  -- 0.0472 field measurement

theorem three_make_a_container : 3 * pi3 = π := by
  simp [pi3]; ring

theorem six_make_a_circle : 6 * pi3 = 2 * π := by
  simp [pi3]; ring

-- COAST: sticks that can be two layers thick and still flow
structure Coast where
  sticks : ℕ
  heading : Fin 6

def Coast.length (c : Coast) : ℝ := c.sticks * pi3

def refine (c : Coast) (extra : ℕ) : Coast :=
  { c with sticks := c.sticks + extra }

def descend (c : Coast) (k : ℕ) : Coast :=
  { c with sticks := c.sticks - k }

def reverse (c : Coast) (k : ℕ) : Coast :=
  refine (descend c k) k

theorem refine_adds_linear (c : Coast) (extra : ℕ) :
    (refine c extra).length = c.length + extra * pi3 := by
  simp [refine, Coast.length, add_mul]

theorem descend_subtracts_linear (c : Coast) (k : ℕ) (h : k ≤ c.sticks) :
    (descend c k).length = c.length - k * pi3 := by
  simp [descend, Coast.length, Nat.cast_sub h, sub_mul]

theorem reverse_recovers (c : Coast) (k : ℕ) (h : k ≤ c.sticks) :
    (reverse c k).sticks = c.sticks := by
  simp [reverse, refine, descend, Nat.sub_add_cancel h]

theorem any_heading_same_length (n : ℕ) (d₁ d₂ : Fin 6) :
    Coast.length ⟨n, d₁⟩ = Coast.length ⟨n, d₂⟩ := rfl

-- MILLION CYCLE WITNESS - finite, not infinite
def after (cycles : ℕ) (start : ℝ) : ℝ := start + cycles * Hm

theorem million_is_finite :
    after 1000000 1 = 1 + 1000000 * (π / 3 - 1) := by
  simp [after, Hm, pi3]

def leftover : ℚ := 472 / 10000

theorem million_tape : (1000000 : ℚ) * leftover + 1 = 47201 := by
  native_decide

-- TAPE MEASURE STABILITY - System with cap
structure System where
  q : ℝ
  K : ℝ
  hK : 0 < K
  m : ℕ → ℝ
  s : ℕ → ℝ
  hm0 : ∀ n, 0 ≤ m n
  hs0 : ∀ n, 0 ≤ s n
  dyn : ∀ n, s (n+1) ≤ q * s n + K * m (n+1)
  death : ∀ n, m n = 0 → ∃ N, ∀ k ≥ N, s k = 0

def Bounded (s : ℕ → ℝ) := ∃ B, ∀ n, s n ≤ B
def Dies (s : ℕ → ℝ) := ∃ N, ∀ k ≥ N, s k = 0

theorem feed_cap_q_bounded (sys : System)
  (hq : 0 ≤ sys.q ∧ sys.q < 1)
  (hcap : ∃ Mcap, ∀ n, sys.m n ≤ Mcap) :
  Bounded sys.s := by
  obtain ⟨Mcap, hMcap⟩ := hcap
  obtain ⟨hq0, hq1⟩ := hq
  let B := sys.s 0 + sys.K * Mcap / (1 - sys.q)
  use B
  have h1q : 0 < 1 - sys.q := by linarith
  have hKMc : 0 ≤ sys.K * Mcap := by
    have hM0 : 0 ≤ Mcap := le_trans (sys.hm0 0) (hMcap 0)
    exact mul_nonneg (le_of_lt sys.hK) hM0
  intro n
  induction n with
  | zero => linarith [div_nonneg hKMc (le_of_lt h1q)]
  | succ n ih =>
    calc sys.s (n+1) ≤ sys.q * sys.s n + sys.K * sys.m (n+1) := sys.dyn n
      _ ≤ sys.q * B + sys.K * Mcap := by
        have hm : sys.m (n+1) ≤ Mcap := hMcap (n+1)
        have : sys.K * sys.m (n+1) ≤ sys.K * Mcap :=
          mul_le_mul_of_nonneg_left hm (le_of_lt sys.hK)
        exact add_le_add (mul_le_mul_of_nonneg_left ih hq0) this
      _ ≤ B := by
        have hqs0 : sys.q * sys.s 0 ≤ sys.s 0 := by
          have hs0 : 0 ≤ sys.s 0 := sys.hs0 0
          nlinarith
        have hqdiv : sys.q * (sys.K * Mcap / (1 - sys.q)) + sys.K * Mcap = sys.K * Mcap / (1 - sys.q) := by
          field_simp; ring
        calc sys.q * B + sys.K * Mcap
          = sys.q * sys.s 0 + sys.q * (sys.K * Mcap / (1 - sys.q)) + sys.K * Mcap := by ring
          _ = sys.q * sys.s 0 + sys.K * Mcap / (1 - sys.q) := by rw [hqdiv]
          _ ≤ sys.s 0 + sys.K * Mcap / (1 - sys.q) := by linarith
          _ = B := rfl

theorem zero_feed_death (sys : System)
  (h0 : ∃ n, sys.m n = 0) : Dies sys.s := by
  obtain ⟨n, hn⟩ := h0; exact sys.death n hn

-- BRIDGE: environment has its cost
-- q ≥ 1 => no promise. Boundedness not claimed unless you add growth.
-- tape 1.0472 additive M=N+Hm finite 47201 after 1e6

#eval (472 : ℚ)/10000
#eval 1000000 * (472 : ℚ)/10000 + 1
