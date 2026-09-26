import Mathlib

open Real

def pi3 : ℝ := π / 3

theorem fifteen_twentyfour_circle : (15 * 24 : ℕ) = 360 := by native_decide
theorem fifteen_twentyfour_second : (2 * 15 * 24 : ℕ) = 720 := by native_decide

theorem fifteen_twentyfour_rad : (360 : ℝ) * (π / 180) = 2 * π := by ring
theorem fifteen_twentyfour_pi3 : (6 : ℝ) * (π / 3) = 2 * π := by ring
theorem fifteen_twentyfour_bridge : (15 * 24 : ℝ) = 360 := by norm_num

-- dot → two → three → six packing fits 15x24 grid
def grid15x24 : ℕ := 15 * 24 -- 360 positions
def secondUnit : ℕ := 2 * grid15x24 -- 720 = 4π

theorem grid_second : secondUnit = 2 * grid15x24 := rfl
theorem grid_360 : grid15x24 = 360 := by simp [grid15x24]

-- Coastal sticks in degrees
def Coast15x24 (sticks : ℕ) : ℝ := sticks * (π / 3) -- each stick pi/3
theorem coast15x24_6 : Coast15x24 6 = 2 * π := by simp [Coast15x24]; ring
theorem coast15x24_12 : Coast15x24 12 = 4 * π := by simp [Coast15x24]; ring
theorem coast15x24_15x24 : Coast15x24 360 = 120 * π := by simp [Coast15x24]; ring
