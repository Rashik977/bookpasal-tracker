# Questions: BP-15 ESLint + Prettier + Husky with test setup and CI in GitHub

| # | Question | Recommended Option | Consequence | Status |
|---|---|---|---|---|
| 1 | How should we handle 48 pre-existing FE ESLint errors? | Option A: Baseline / staged only | Rashik chose Option B: Fix all 48 errors to eliminate tech debt now. | Resolved (Option B) |
| 2 | What should Husky execute and on which hooks? | Option A: `pre-commit` (lint-staged) + `pre-push` (npm test) | Keeps commits fast; prevents broken tests from pushing. | Resolved (Option A) |
| 3 | How to resolve `no-explicit-any` errors in frontend? | Option A: Define proper TypeScript types | Clean typing matching backend API models. | Resolved (Option A) |
