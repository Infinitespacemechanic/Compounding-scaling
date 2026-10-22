import Mathlib

open Real

/-!
# Time.lean — When stick meets circle, it's a 24h period. More irony.

24 hours × 15° = 360°
Earth rotation is the unity.

15 = degrees per hour = arithmetic wall (Ogg)
24 = hours = geometric wall (Leech)
-/

def hoursPerDay : ℕ := 24
def degreesPerHour : ℕ := 15

theorem time_unity_nat : hoursPerDay * degreesPerHour = 360 := by rfl
theorem time_unity_real : (24 : ℝ) * 15 = 360 := by norm_num
theorem hour_angle : (360 : ℝ) / 24 = 15 := by norm_num

-- π/3 = 60° = 4 hours
def stickHours : ℝ := (π / 3) / (π / 180) / 15 -- should be 4

theorem stick_is_four_hours : (π / 3 : ℝ) / (π / 180) = 60 := by ring
theorem six_sticks_one_day : (6 : ℝ) * 60 = 360 := by norm_num
theorem six_sticks_24h : (6 : ℝ) * 4 = 24 := by norm_num

-- Coastal logic in time
def Coast15x24Time (sticks : ℕ) : ℝ := sticks * 4 -- each π/3 stick = 4h

theorem coast_time_6 : Coast15x24Time 6 = 24 := by simp [Coast15x24Time]
theorem coast_time_12 : Coast15x24Time 12 = 48 := by simp [Coast15x24Time]

-- Forks:
-- Position: 15 meridians × 24 parallels = 360 cells = where
-- State: 720° = double cover = which way you turned
-- Time: 24h × 15° = where the shadow falls = when
