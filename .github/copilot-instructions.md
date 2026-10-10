This is a Lean 4 project. Build with the pinned toolchain and Mathlib in lakefile.lean. Do not change theorem statements unless the issue asks for it.

The model is additive, not exponential.
Growth step: M = N + Hm
Not: N * e^x, exp, or continuous compounding.

Goal: finite, stable growth with no blow-up.
Prefer additive steps, cycle stability checks, and explicit bounds.
A 1_000_000 cycle bound must be stated and proved or checked, not assumed.
Do not replace an additive step with an exponential model.
Do not delete README explanation. Add build notes at the end.
