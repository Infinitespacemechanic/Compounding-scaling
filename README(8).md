# 15 × 24 = 360 — Unity for the Sphere

[15x24 Unity](15x24-unity.png)

> **Two walls. One unity. One clock.**

This repo is `15x24`. Not `15x25`. The typo matters — `15*25=375` breaks the circle.

### The Walls

**24** is where it stops being nice.

- Even unimodular lattices exist only in dimensions `8|n`.
- `n=8`: 1 lattice (E8, has roots)
- `n=16`: 2 lattices (both have roots)
- `n=24`: 24 lattices — the Niemeier lattices. Exactly 1 root-free: Leech Λ24.
- Past 24: >10 million lattices. Uniqueness never returns.
- Physics: bosonic string `26 = 24 + 2`.

**15** is also a wall.

- Ogg's supersingular primes: `2,3,5,7,11,13,17,19,23,29,31,41,47,59,71`
- No 16th. `X0(p)+` has genus zero iff `p` is in this list.
- Exactly the prime divisors of |Monster|.
- Ogg offered a bottle of whiskey for an explanation. That bottle is Monstrous Moonshine.

### The Unity

```lean
def grid15x24 : ℕ := 15 * 24 -- 360 positions
def secondUnit : ℕ := 2 * grid15x24 -- 720 = 4π

theorem grid_360 : grid15x24 = 360 := by rfl
theorem grid_720 : secondUnit = 720 := by rfl
```

Discrete `ℕ` and continuous `ℝ` agree:

```lean
theorem fifteen_twentyfour_bridge : (15 * 24 : ℝ) = 360 := by norm_num
theorem fifteen_twentyfour_rad : (360 : ℝ) * (π / 180) = 2 * π := by ring
```

### The Packing: dot → two → three → six

Each coastal stick = π/3 = 60° = 4 hours.

```lean
def Coast15x24 (sticks : ℕ) : ℝ := sticks * (π / 3)

theorem coast_6 : Coast15x24 6 = 2 * π := by simp [Coast15x24]; ring  -- one circle
theorem coast_12 : Coast15x24 12 = 4 * π := by simp [Coast15x24]; ring -- secondUnit
theorem coast_360 : Coast15x24 360 = 120 * π := by simp [Coast15x24]; ring -- 60 circles
```

Logic: `6 × π/3 = 2π`. Hexagon packs the plane and closes the sphere.

### The Irony: Stick Meets Circle = 24h

When the stick meets the circle, it becomes time.

Earth rotates 360° in 24 hours → 15° per hour.

```
24 hours × 15° = 360°
15 × 24 = 360
```

- 6 sticks × 60° = 360° = one day
- 6 sticks × 4h = 24h

```lean
theorem time_unity : (24 : ℝ) * 15 = 360 := by norm_num
theorem hour_angle : (360 : ℝ) / 24 = 15 := by norm_num
```

The same numbers where math stops being ultra-symmetric are exactly what make a clock work.

### Weight 12 = 24/2

Why weight 12 matters for SL2(Z):

```
dim M12 = 2 = <E4^3, Δ> because 12 = 24/2
E12 = E4^3 - (432000/691) Δ
Θ_Leech = E4^3 - 720Δ  -- kills q^1 term, no roots
```

- 720 appears again: `2 * 360`
- 691 does NOT divide |M|. It's the numerator of B12, giving Ramanujan congruence `τ(n) ≡ σ11(n) mod 691`. Extra arithmetic accident, not Moonshine.

### Structure

```
15x24/
├── TwoWalls.lean    -- 24 = Leech wall, 15 = Ogg wall
├── Unity.lean       -- 15*24=360 by rfl, discrete→continuous
├── Time.lean        -- 24h×15°=360°, stick meets circle
└── FifteenTwentyFour.lean -- main import
```

### Forks to Consider

- **Position:** 15 meridians × 24 parallels = 360 coastal cells = where
- **State:** 720° = 4π = double cover = which way you turned = orientation
- **Time:** 24h × 15° = 360° = when

Keep the mystery. Logic is shown. By rfl.

### Lean Build

```bash
lake build
```

Requires Mathlib.

---
*by rfl. No axioms beyond.*
