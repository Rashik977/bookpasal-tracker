# Slice 3: Frontend Prettier, Husky Hooks & GitHub Actions CI Pipeline

## Goal & Behaviour
Configure Prettier, Husky (`pre-commit` via `lint-staged`, `pre-push` via `npm test`), and a GitHub Actions CI workflow in `bookpasal_frontend`. Ensure all frontend files pass formatting checks, git hooks enforce quality locally, and CI runs linting, formatting, typechecking, tests, and build on pull requests targeting `develop`.

## Why It Is Vertical
It touches all frontend developer workflow and CI automation layers:
- Configuration (`.prettierrc`, `.prettierignore`, `.husky/pre-commit`, `.husky/pre-push`, `lint-staged`).
- Package scripts in `package.json` (`format`, `format:check`, `prepare`).
- Local git hooks lifecycle.
- Remote CI pipeline (`.github/workflows/ci.yml`).

## Exact Files to Create / Modify
- Modify: `bookpasal_frontend/package.json` (add scripts: `format`, `format:check`, `prepare`; devDependencies: `prettier`, `eslint-config-prettier`, `husky`, `lint-staged`).
- Create: `bookpasal_frontend/.prettierrc`
- Create: `bookpasal_frontend/.prettierignore`
- Create: `bookpasal_frontend/.husky/pre-commit`
- Create: `bookpasal_frontend/.husky/pre-push`
- Create: `bookpasal_frontend/.github/workflows/ci.yml`
- Modify: `bookpasal_frontend/eslint.config.mjs` (ensure Prettier rules don't conflict).

## First Failing Test to Write
- File: `bookpasal_frontend/tests/pipeline.test.ts`
- Test: `"package scripts include format, format:check, lint, and test"`
- Assertion: Asserts that formatting scripts exist and `npm run format:check` executes with exit code 0.

## Further Behaviours to TDD / Implement in Order
1. Install devDependencies (`prettier`, `eslint-config-prettier`, `husky`, `lint-staged`).
2. Add `.prettierrc` matching project standards (`semi: true`, `singleQuote: false`, `tabWidth: 2`, `trailingComma: "es5"`) and `.prettierignore` (ignoring `.next`, `node_modules`, `public/**`).
3. Run `npm run format` across the frontend repo and verify with `npm run format:check`.
4. Configure Husky hooks:
   - `.husky/pre-commit`: runs `npx lint-staged`.
   - `.husky/pre-push`: runs `npm test`.
5. Configure `lint-staged` in `package.json` for `*.{ts,tsx,js,jsx,json,css}`.
6. Create `.github/workflows/ci.yml`:
   - Triggers on push and pull request to `develop`.
   - Runs on `ubuntu-latest`.
   - Steps: Checkout, setup Node 24, `npm ci`, `npm run format:check`, `npm run lint`, `npx tsc --noEmit`, `npm test`, `npm run build`.
7. Verify all checks pass simultaneously.

## Commands to Run
- `cd bookpasal_frontend; npm run format:check`
- `cd bookpasal_frontend; npm run lint`
- `cd bookpasal_frontend; npx tsc --noEmit`
- `cd bookpasal_frontend; npm test`
- `cd bookpasal_frontend; npm run build`

## Browser Check (Mobile Viewport: 375x667)
- Run mobile smoke test to verify all client bundles and styles are correctly loaded after prettier formatting:
  - Homepage `/`
  - Mobile bottom navigation and headers
- Save screenshot to `evidence/fe-pipeline-mobile-check.png`.

## Done Criteria
1. `npm run format:check` passes with 0 formatting errors.
2. `npm run lint` passes with 0 errors.
3. `npm test` passes.
4. `npm run build` succeeds cleanly.
5. Husky hooks installed and executable.
6. `.github/workflows/ci.yml` is valid and ready.

## Risks & Open Decisions
None. All choices aligned with approved spec and interview decisions.

