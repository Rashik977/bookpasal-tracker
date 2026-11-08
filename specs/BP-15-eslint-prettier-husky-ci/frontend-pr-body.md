## Summary
Remediates all 48 legacy ESLint errors, introduces Prettier code formatting, Husky git hooks (`pre-commit` and `pre-push`), self-hosted fonts for deterministic offline/CI builds, and GitHub Actions CI workflow for `bookpasal_frontend`.

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
  - Migrated Google Fonts loader from `next/font/google` to `next/font/local` using self-hosted `.woff2` files in `public/fonts/` (`Outfit.woff2`, `DMSans.woff2`) to resolve upstream Next.js loader crash in CI runners.

## Mobile Screenshots (Full-Page with Real Data)
<!-- Captured with mobile viewport (390px width) with backend active and real data rendered -->
| Screen / Feature | Viewport | Screenshot |
| :--- | :--- | :--- |
| **Home Page** (Best Offers, Top Collections, New Arrivals) | Mobile (390x2200) | ![Home Mobile](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-15-eslint-prettier-husky-ci/evidence/fe-mobile-home.png) |
| **Book Detail** (The Great Gatsby, Tags, Cart/Buy, Q&A) | Mobile (390x1500) | ![Book Detail Mobile](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-15-eslint-prettier-husky-ci/evidence/fe-mobile-book.png) |
| **Collection Detail** (Classic Fiction Bundle, Price, Items, Q&A) | Mobile (390x1500) | ![Collection Detail Mobile](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-15-eslint-prettier-husky-ci/evidence/fe-mobile-collection.png) |
| **Book Detail - Locked** (Atomic Habits with Collection Lock Badge) | Mobile (390x1500) | ![Locked Book Detail Mobile](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-15-eslint-prettier-husky-ci/evidence/fe-mobile-book-locked.png) |

## Verification
- GitHub Actions CI: **PASS** (Job `Lint, Format, Typecheck, Test & Build` in 1m 11s)
- Vitest Tests: `npm test` -> **PASS** (4 passed across 3 test files)
- ESLint: `npm run lint` -> **PASS** (0 errors, 41 legacy warnings)
- Formatting: `npm run format:check` -> **PASS** (100% compliant)
- Typecheck: `npx tsc --noEmit` -> **PASS**
- Next.js Production Build: `npm run build` -> **PASS** (All 15 routes compiled and static pages generated successfully)
*(Baseline note: 41 pre-existing legacy frontend lint warnings left untouched per policy).*

## How to Test
1. Check out `bp-15-eslint-prettier-husky-ci` in `bookpasal_frontend`.
2. Run `npm run lint` -> verify 0 errors.
3. Run `npm run format:check` -> verify clean formatting.
4. Run `npm test` -> verify 4 tests pass.
5. Run `npm run build` -> verify clean production build with local font bundle.
6. Stage a file and commit -> verify Husky runs Prettier and ESLint via `lint-staged`.
7. Attempt a push -> verify Husky pre-push hook runs tests and protects target branches.

## Decisions & Trade-offs
- Migrated fonts to `next/font/local` using downloaded Google Fonts `.woff2` binaries: avoids runtime network dependency during CI build step, making builds completely deterministic, offline-ready, and faster.
- Preserved 41 legacy warnings (e.g. `<img>` tags on remote Cloudinary URLs, unused imports in untouched files) per baseline rule.
- Created reusable `AuthUser` type in `types/index.ts` to cleanly type NextAuth session without `any`.
- Configured `lint.test.ts` with a 60-second timeout to allow full ESLint scan across the entire frontend repo.

Refs Rashik977/bookpasal-tracker#15
