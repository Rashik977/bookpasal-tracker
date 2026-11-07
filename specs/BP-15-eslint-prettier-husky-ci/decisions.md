# Decisions: BP-15 ESLint + Prettier + Husky with test setup and CI in GitHub

| Decision | Context & Options | Rationale | Date |
|---|---|---|---|
| Fix all legacy FE ESLint errors | Option A: Baseline / ignore legacy errors.<br>Option B: Fix all 48 pre-existing frontend ESLint errors in BP-15. | Rashik chose Option B to ensure a clean slate before release rather than dealing with deferred technical debt later. CI will strictly enforce `npm run lint`. | 2026-11-07 |
| Husky git hooks configuration | Option A: `pre-commit` runs `lint-staged`; `pre-push` runs `npm test`.<br>Option B: `pre-commit` runs both `lint-staged` and `npm test`. | Option A keeps everyday local commits snappy while preventing unformatted/broken code commits, and blocking broken tests from ever reaching remote branches. | 2026-11-07 |
| Proper typing vs any suppression | Option A: Define proper TypeScript types and interfaces.<br>Option B: Downgrade `@typescript-eslint/no-explicit-any` to warn/suppress. | Option A ensures high quality, type-safe API client code and eliminates lint errors at the root. | 2026-11-07 |
| Backend ESLint flat config & globals | Added `globals` package and set `"no-useless-catch": "off"`. | Standard for ESLint 9/10 flat config in Node ESM; preserves existing model try-catch patterns without risky invasive refactoring. | 2026-11-07 |
