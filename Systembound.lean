import Mathlib

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
  -- B = s₀ + K*Mcap/(1-q) — tape measure finite bound, not infinite
  let B := sys.s 0 + sys.K * Mcap / (1 - sys.q)
  use B
  have h1q : 0 < 1 - sys.q := by linarith
  have hKMc : 0 ≤ sys.K * Mcap := by
    have hM0 : 0 ≤ Mcap := le_trans (sys.hm0 0) (hMcap 0)
    exact mul_nonneg (le_of_lt sys.hK) hM0
  have hB0 : 0 ≤ sys.K * Mcap / (1 - sys.q) := div_nonneg hKMc (le_of_lt h1q)
  -- induction: s_n ≤ B
  intro n
  induction n with
  | zero => linarith
  | succ n ih =>
    -- s_{n+1} ≤ q s_n + K m_{n+1} ≤ q B + K Mcap ≤ B
    calc sys.s (n+1) ≤ sys.q * sys.s n + sys.K * sys.m (n+1) := sys.dyn n
      _ ≤ sys.q * B + sys.K * Mcap := by
        have hm : sys.m (n+1) ≤ Mcap := hMcap (n+1)
        have : sys.K * sys.m (n+1) ≤ sys.K * Mcap := by
          exact mul_le_mul_of_nonneg_left hm (le_of_lt sys.hK)
        exact add_le_add (mul_le_mul_of_nonneg_left ih hq0) this
      _ ≤ B := by
        -- q B + K Mcap = q s₀ + K Mcap/(1-q) ≤ s₀ + K Mcap/(1-q) = B
        -- because q s₀ ≤ s₀ for q<1, s₀≥0
        have hqs0 : sys.q * sys.s 0 ≤ sys.s 0 := by
          have hs0 : 0 ≤ sys.s 0 := sys.hs0 0
          nlinarith
        have hqdiv : sys.q * (sys.K * Mcap / (1 - sys.q)) + sys.K * Mcap = sys.K * Mcap / (1 - sys.q) := by
          field_simp
          ring
        calc sys.q * B + sys.K * Mcap
          = sys.q * sys.s 0 + sys.q * (sys.K * Mcap / (1 - sys.q)) + sys.K * Mcap := by ring
          _ = sys.q * sys.s 0 + sys.K * Mcap / (1 - sys.q) := by rw [hqdiv]
          _ ≤ sys.s 0 + sys.K * Mcap / (1 - sys.q) := by linarith
          _ = B := rfl

theorem zero_feed_death (sys : System)
  (h0 : ∃ n, sys.m n = 0) : Dies sys.s := by
  obtain ⟨n, hn⟩ := h0; exact sys.death n hn

-- q ≥ 1 => no promise. Boundedness is not claimed unless you add growth.
-- i.e. we do NOT have Bounded nor ¬Bounded from q ≥ 1 alone
-- tape 1.0472 additive M = N + Hm is q=1 bounded by Mcap*n = 47,201 after 1e6 finite