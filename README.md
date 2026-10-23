# Compounding-scaling

There's a fine point on the ruler...a cutoff that's productive, predictable, and steady..... unlike other compounding choices. This runs 1 million cycles without blowing up! M = N + (π/3 − 1). Additive stays finite. Exponential does not.

## Coastal Closing - Tape Measure vs Laser Survey - Mechanical Higgs 0.0472

**M = N + Hm, not N * e^x. Dot → two → three → six while all frames moving.**

### Tape Measure = 1.0472 field measurement
- Steel tape expands hot, contracts cold - day/night breathing
- Hard to find a ball, man makes them, nature makes hail and eroded rock
- Graphite pair lattice two layers thick, slip = surf where water and land mix
- 6 steps = 6.2832 error 0.0000147 - first closure
- Million cycle witness: M = N + Hm = 47,201 after 1e6 - finite, not inf
- You can walk with it

### Laser Survey = π/3 full Pi
- Dot was just dot, then two and three, mass that can take shape
- Bees finishing last section as location changing, when pack perfect hexagon first six
- 6 * π/3 = 2π exact, 12 * π/3 = 4π = 720 second unit
- You can prove with it

### Bridge = envCost = tape - laser = 2.4488e-06
- Slip between pair lattice layers
- Chord helps tune for location - environment has its cost
- Coastal problem closes at 4.72% compound, not infinite fractal

### Witnesses
- `coastal_closing.png` - Tape & laser close, Euler e/2 bombs
- `million_cycle.png` - Million cycle finite
- `drift.png` - Chord of right answers, only tape & laser stay low
- `dot-two-three-six-packing-witness.mp4` - Video: dot → chain → triangle → hexagon → graphite two layers → tape measuring coast → 6=2π → 12=4π → M=N+Hm → million cycle stable

### How to run
Lean4: `CompoundingScaling.lean`
HTML: `Coastal-Closing-Mechanical-Higgs.html` - tape vs laser interactive

Coastal closes. Euler says infinite. 1.0472 says finite. Tape you can walk with, laser you can prove with.

## Build notes
The Lean library is `CompoundingScaling.lean`. Build it with the pinned Lean 4.22.0 toolchain and Mathlib v4.22.0:

```sh
lake build
```

The theorem `million_step_bound` proves the additive model's bound after 1,000,000 steps.
