# Slice 1: Backend Code Quality & Automation Pipeline (ESLint + Prettier + Husky + CI)

## Goal & Behaviour
Configure modern ESLint (Flat Config v9), Prettier, Husky (`pre-commit` via `lint-staged`, `pre-push` via `npm test`), and a GitHub Actions CI workflow in `bookpasal_backend`. Ensure all backend files pass linting and formatting, git hooks prevent unformatted commits and failing pushes, and CI validates the build on pull requests to `dev`.

## Why It Is Vertical
It touches all engineering automation layers for backend:
- Package dependencies (`eslint`, `@eslint/js`, `eslint-config-prettier`, `prettier`, `husky`, `lint-staged`).
- Configuration files (`eslint.config.js`, `.prettierrc`, `.prettierignore`, `.husky/pre-commit`, `.husky/pre-push`).
- Git integration (Husky hooks).
- Cloud CI workflow (`.github/workflows/ci.yml`).
- Verification against real backend code and local test database.

## Exact Files to Create / Modify
- Modify: `bookpasal_backend/package.json` (add scripts: `lint`, `lint:fix`, `format`, `format:check`, `prepare`; devDependencies: `eslint`, `@eslint/js`, `eslint-config-prettier`, `prettier`, `husky`, `lint-staged`).
- Create: `bookpasal_backend/eslint.config.js`
- Create: `bookpasal_backend/.prettierrc`
- Create: `bookpasal_backend/.prettierignore`
- Create: `bookpasal_backend/.husky/pre-commit`
- Create: `bookpasal_backend/.husky/pre-push`
- Create: `bookpasal_backend/.github/workflows/ci.yml`
- Test file: `bookpasal_backend/tests/smoke.test.js` (add verification assertion for tooling/health)

## First Failing Test to Write
- File: `bookpasal_backend/tests/pipeline.test.js`
- Test: `"package scripts include lint, format:check, and test"`
- Assertion: Asserts that `npm run lint` and `npm run format:check` scripts exist and execute with exit code 0 against backend code.

## Further Behaviours to TDD / Implement in Order
1. Install devDependencies (`eslint`, `@eslint/js`, `eslint-config-prettier`, `prettier`, `husky`, `lint-staged`).
2. Create `eslint.config.js` targeting Node.js ESM (`src/**/*.js`, `tests/**/*.js`, `scripts/**/*.js`) with proper globals (process, console, Buffer).
3. Create `.prettierrc` (`semi: true`, `singleQuote: false`, `trailingComma: "es5"`, `tabWidth: 2`) and `.prettierignore`.
4. Run `npm run format` and `npm run lint:fix` to ensure all existing backend code is cleanly formatted and lint-compliant.
5. Setup Husky: initialize `.husky/pre-commit` running `npx lint-staged` and `.husky/pre-push` running `npm test`.
6. Configure `lint-staged` in `package.json` to run `prettier --write` and `eslint --fix` on `*.js`.
7. Create `.github/workflows/ci.yml` for backend:
   - Triggers on push and pull request to `dev`.
   - Runs on `ubuntu-latest`.
   - Service container: `postgres:15` with credentials `POSTGRES_USER: postgres`, `POSTGRES_PASSWORD: postgres`, `POSTGRES_DB: bookpasal_test`.
   - Steps: Checkout, setup Node 24, `npm ci`, `npm run format:check`, `npm run lint`, `npm run db:test:reset`, `npm test`.

## Commands to Run
- `cd bookpasal_backend; npm run format:check`
- `cd bookpasal_backend; npm run lint`
- `cd bookpasal_backend; npm test`

## Browser Check
N/A (Backend infrastructure slice). Verify backend server starts and `/` or smoke endpoint responds:
- Command: `npm test` runs all supertest requests successfully.

## Done Criteria
1. `npm run lint` passes with 0 errors and 0 warnings.
2. `npm run format:check` passes with all files formatted.
3. `npm test` runs and all tests pass against local PostgreSQL test database.
4. `.husky/` hooks are executable and installed.
5. `.github/workflows/ci.yml` is valid YAML and correctly configured.

## Risks & Open Decisions
None. Handled purely in `bookpasal_backend`.

