-- Coastal Closing repair
-- Rob Laakkonen — wiggle-stick / mechanical leftover 0.0472
-- Tape = rounded field stick you can walk with
-- Laser = π/3 stick you can prove with
-- Million ticks stay finite because we ADD the leftover, we do not raise it to a power

import Mathlib

open Real

def pi3 : ℝ := π / 3
def Hm : ℝ := pi3 - 1

def tapeSlice : ℚ := 10472 / 10000
def tapeHiggs : ℚ := 472 / 10000
def envCost : ℚ := tapeSlice - (104719755 / 100000000)  -- rounded gap only

/-- One stick, counted. Not multiplied. -/
def tapeCoast (steps : ℕ) : ℚ := steps * tapeSlice
def laserCoast (steps : ℕ) : ℝ := steps * pi3

theorem tape_six_is_near_two_pi :
    |(tapeCoast 6 : ℝ) - 2 * π| < 0.00002 := by
  -- 6 * 1.0472 = 6.2832,  2π ≈ 6.283185307
  native_decide

theorem laser_six_is_two_pi : laserCoast 6 = 2 * π := by
  simp [laserCoast, pi3]; ring

theorem laser_twelve_is_four_pi : laserCoast 12 = 4 * π := by
  simp [laserCoast, pi3]; ring

theorem three_make_a_container : 3 * pi3 = π := by
  simp [pi3]; ring

/-- Additive leftover: M = N + Hm. -/
def after (cycles : ℕ) (start : ℚ) : ℚ := start + cycles * tapeHiggs

theorem million_tape : after 1000000 1 = 47201 := by
  native_decide

theorem million_is_finite : after 1000000 1 < 100000 := by
  native_decide

structure Coast where
  sticks : ℕ
  heading : Fin 6

def Coast.length (c : Coast) : ℝ := c.sticks * pi3

def refine (c : Coast) (extra : ℕ) : Coast :=
  { c with sticks := c.sticks + extra }

def descend (c : Coast) (k : ℕ) : Coast :=
  { c with sticks := c.sticks - k }

theorem refine_adds_linear (c : Coast) (extra : ℕ) :
    (refine c extra).length = c.length + extra * pi3 := by
  simp [refine, Coast.length, add_mul]

theorem descend_subtracts_linear (c : Coast) (k : ℕ) (h : k ≤ c.sticks) :
    (descend c k).length = c.length - k * pi3 := by
  simp [descend, Coast.length, Nat.cast_sub h, sub_mul]

theorem any_heading_same_length (n : ℕ) (d₁ d₂ : Fin 6) :
    Coast.length ⟨n, d₁⟩ = Coast.length ⟨n, d₂⟩ := rfl

/-- The broken version, kept only as a warning label. -/
def doNotMultiply (steps : ℕ) (slice : ℝ) : ℝ := slice ^ steps
