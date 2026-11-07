## Summary
Remediates all 48 legacy ESLint errors, introduces Prettier code formatting, Husky git hooks (`pre-commit` and `pre-push`), and GitHub Actions CI workflow for `bookpasal_frontend`.

## Slices & Changes
- **Slice 02 - Frontend Legacy ESLint Remediation and Typed API Models**:
  - Remediated all 48 legacy ESLint errors across components, mutations, and pages without behavioral regression.
  - Excluded build output and icons from linting in `eslint.config.mjs`.
  - Replaced unescaped apostrophes and quotation marks with HTML entity escapes (`&apos;`, `&quot;`).
  - Addressed Next.js `<img>` vs `<Image />` rules and unused parameters.
  - Added strictly typed `Question` and `AuthUser` models and `"book" | "collection"` discrimination payloads in `types/index.ts`.
  - Refactored `QuestionSection.tsx` and `QuestionItem.tsx` with clean typed state.
  - Added `tests/lint.test.ts` to assert zero ESLint errors in CI/test runner.
- **Slice 03 - Frontend Prettier, Husky, and CI**:
  - Configured Prettier (`.prettierrc`, `.prettierignore`) and verified 100% repository formatting compliance.
  - Set up Husky (`prepare`, `.husky/pre-commit` executing `lint-staged`, `.husky/pre-push` running `npm test`).
  - Added GitHub Actions workflow `.github/workflows/ci.yml` verifying lint, format, tsc typecheck, test, and Next.js build on pushes and PRs targeting `develop`.
  - Added `tests/pipeline.test.ts` for automated CI test coverage.
  - Fixed executable file permissions (`100755`) on husky hooks.

## Mobile Screenshots
<!-- Captured in mobile viewport (375x667) -->
| Screen / Feature | Viewport | Screenshot |
| :--- | :--- | :--- |
| Home Page | Mobile (375x667) | ![Home Mobile](./evidence/fe-mobile-home.png) |
| Book Detail | Mobile (375x667) | ![Book Detail Mobile](./evidence/fe-mobile-book.png) |
| Collection Detail | Mobile (375x667) | ![Collection Detail Mobile](./evidence/fe-mobile-collection.png) |
| Orders Page | Mobile (375x667) | ![Orders Page Mobile](./evidence/fe-mobile-orders.png) |

## Verification
- Tests: `npm test` -> PASS (4 passed across 3 test files)
- Lint: `npm run lint` -> PASS (0 errors, 41 legacy warnings)
- Typecheck: `npx tsc --noEmit` -> PASS
- Build: `npm run build` -> PASS (All 15 routes compiled and static pages generated successfully)
*(Baseline note: 41 pre-existing legacy frontend lint warnings left untouched per policy).*

## How to Test
1. Check out `bp-15-eslint-prettier-husky-ci` in `bookpasal_frontend`.
2. Run `npm run lint` -> verify 0 errors.
3. Run `npm run format:check` -> verify clean formatting.
4. Run `npm test` -> verify 4 tests pass.
5. Run `npm run build` -> verify clean production build.
6. Stage a file and commit -> verify Husky runs Prettier and ESLint via `lint-staged`.

## Decisions & Trade-offs
- Preserved 41 legacy warnings (e.g. `<img>` tags on remote Cloudinary URLs, unused imports in untouched files) per baseline rule.
- Created reusable `AuthUser` type in `types/index.ts` to cleanly type NextAuth session without `any`.
- Configured `lint.test.ts` with a 60-second timeout to allow full ESLint scan across the entire frontend repo.

Refs Rashik977/bookpasal-tracker#15
