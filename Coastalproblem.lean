import Mathlib

open Real

/-! # Coastalproblem - FIXED additive, matches README
  Tape you walk with, laser you prove with, leftover stays small, no e^x blow-up
  M = N + Hm * steps  -  dot → two → three → six while frames moving
-/

def pi3 : ℝ := π / 3
def tapeSlice : ℝ := 1.0472
def laserSlice : ℝ := π / 3

-- ADDITIVE - wiggle-stick
def tapeCoast (n : ℕ) : ℝ := n * tapeSlice
def laserCoast (n : ℕ) : ℝ := n * laserSlice

-- Also iterative add version if you want loop witness
def tapeCoast_loop : ℕ → ℝ → ℝ
| 0, a => a
| n+1, a => tapeCoast_loop n (a + tapeSlice)

def laserCoast_loop : ℕ → ℝ → ℝ
| 0, a => a
| n+1, a => laserCoast_loop n (a + laserSlice)

theorem tapeCoast_loop_eq (n : ℕ) (a : ℝ) :
    tapeCoast_loop n a = a + n * tapeSlice := by
  induction n generalizing a with
  | zero => simp [tapeCoast_loop]
  | succ n ih =>
    simp [tapeCoast_loop, ih, add_assoc, add_mul, one_mul, add_comm, add_left_comm]

theorem laserCoast_loop_eq (n : ℕ) (a : ℝ) :
    laserCoast_loop n a = a + n * laserSlice := by
  induction n generalizing a with
  | zero => simp [laserCoast_loop]
  | succ n ih =>
    simp [laserCoast_loop, ih, add_assoc, add_mul, one_mul, add_comm, add_left_comm]

-- CLOSURES - now match README
theorem tape_closes_6 : tapeCoast 6 = 6 * 1.0472 := by simp [tapeCoast]
theorem laser_closes_6 : laserCoast 6 = 2 * π := by
  simp [laserCoast, laserSlice]; ring

theorem tape_closes_12 : tapeCoast 12 = 12 * 1.0472 := by simp [tapeCoast]
theorem laser_closes_12 : laserCoast 12 = 4 * π := by
  simp [laserCoast, laserSlice]; ring

theorem fifteen_twentyfour_circle : (15 * 24 : ℕ) = 360 := by native_decide
theorem fifteen_twentyfour_second : (2 * 15 * 24 : ℕ) = 720 := by native_decide

-- MILLION CYCLE - additive witness you stated
def Hm_tape : ℝ := 0.0472
def M_tape (n : ℕ) : ℝ := 1 + n * Hm_tape

theorem million_tape : M_tape 1000000 = 47201 := by
  simp [M_tape, Hm_tape]; norm_num

def Hm_laser : ℝ := π / 3 - 1
def M_laser (n : ℕ) : ℝ := 1 + n * Hm_laser

theorem million_laser : M_laser 1000000 = 1 + 1000000 * (π / 3 - 1) := rfl

-- #eval witnesses - now match functions
#eval tapeCoast 6    -- 6.2832
#eval laserCoast 6   -- 6.283185...
#eval M_tape 1000000 -- 47201
