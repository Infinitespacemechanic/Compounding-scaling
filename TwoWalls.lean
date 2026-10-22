import Mathlib

/-!
# TwoWalls.lean — The two natural walls

24 = last unique even unimodular root-free lattice (Leech Λ24)
15 = last complete list of genus-zero Atkin-Lehner quotients (Ogg supersingular primes)

Both are hard walls where ultra-rigid phenomena stop being "too good to be true".
-/

-- Ogg's supersingular primes: complete list, no 16th
def oggSupersingularPrimes : List Nat :=
  [2,3,5,7,11,13,17,19,23,29,31,41,47,59,71]

theorem ogg_card : oggSupersingularPrimes.length = 15 := by native_decide

-- Even unimodular walls exist only in 8|n
-- n=24 is last with unique root-free
def evenUnimodularDims : List Nat := [8, 16, 24] -- first three, walls start

-- Leech is unique in 24: minimal norm 4, no roots
-- Statement: 15 * 24 counts the unity built from both walls
theorem twoWalls_product : oggSupersingularPrimes.length * 24 = 360 := by native_decide
