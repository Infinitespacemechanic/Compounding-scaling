import Lake
open Lake DSL

package «compounding-scaling» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.22.0"

@[default_target]
lean_lib CompoundingScaling where
  roots := #[`CompoundingScaling]
