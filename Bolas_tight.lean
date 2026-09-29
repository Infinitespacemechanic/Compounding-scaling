This is the complete file. It is ready to try on lean4web.

**Core (should compile without `Pi.Bounds`)**
- `drift_even`
- `drift_odd`
- `three_mass_locks`

Those three do not depend on `sin` or a decimal bound for `π`.

**Optional numeric block**
- `sin_31416_neg` through `drift_ratio_pos`

That block is logically correct now (`subst heq` is the right rewrite). The only likely failure is still `by norm_num` on `Real.sin 3.1416`.

**Push plan**
1. Paste this whole file.
2. If the error is on `sin_31416_neg`, delete from that lemma through `drift_ratio_pos` and keep the rest.
3. If the error is `change` failed to unify, the recurrence didn’t match `2*k+2`; send that goal and we can write the unfold as an explicit `have`.

Do not wait on the ratio lemma. The lock and the telescope are the theorems.
