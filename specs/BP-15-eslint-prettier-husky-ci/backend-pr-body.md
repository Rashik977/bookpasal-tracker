## Summary
Introduces ESLint 9 (Flat Config), Prettier code formatting, Husky git hooks (`pre-commit` and `pre-push`), and GitHub Actions CI workflow for `bookpasal_backend`.

## Slices & Changes
- **Slice 01 - Backend ESLint, Prettier, Husky, and CI**:
  - Configured `eslint.config.js` (Flat Config) for Node.js CommonJS environment, importing `@eslint/js` recommendations and Prettier config.
  - Added `.prettierrc` and `.prettierignore` with standardized formatting rules.
  - Set up Husky (`prepare`, `.husky/pre-commit` running `lint-staged`, `.husky/pre-push` running `npm test`).
  - Added GitHub Actions workflow `.github/workflows/ci.yml` verifying lint, format, and test on pushes and PRs targeting `dev`.
  - Added `tests/pipeline.test.js` validating format and lint commands programmatically.
  - Ensured executable file permissions (`100755`) on husky hooks.

## Verification
- Tests: `npm test` -> PASS (5 passed across 2 test files)
- Lint: `npm run lint` -> PASS (0 errors, 0 warnings)
- Format: `npm run format:check` -> PASS (All matched files use Prettier code style)

## How to Test
1. Check out `bp-15-eslint-prettier-husky-ci` in `bookpasal_backend`.
2. Run `npm run lint` -> exits cleanly with 0 errors.
3. Run `npm run format:check` -> exits cleanly.
4. Run `npm test` -> 5 tests pass.
5. Attempt a commit with staged JS files -> Husky pre-commit hook runs `lint-staged` automatically.

## Decisions & Trade-offs
- Set `"no-useless-catch": "off"` in `eslint.config.js` to preserve existing backend controller and model error handling conventions without invasive changes.
- Test files are excluded from strict `no-unused-vars` to accommodate harness scaffolding.

Refs Rashik977/bookpasal-tracker#15
