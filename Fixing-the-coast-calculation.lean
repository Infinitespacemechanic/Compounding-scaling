def coastLength (steps : Nat) (slice : Float) : Float :=
  (Float.ofNat steps) * slice + 0.0472  -- additive accumulation

-- six laser sticks = 2π
coastLength 6 ((2π - 0.0472)/6) = 2π