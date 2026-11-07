# Spec: BP-15 BE & FE ESLint + Prettier + Husky with Test Setup and CI in GitHub

## 1. Goal
Establish consistent code quality, automated formatting, pre-commit/pre-push hooks, and automated GitHub Actions CI pipelines across both `bookpasal_backend` and `bookpasal_frontend`, eliminating technical debt by resolving all pre-existing frontend ESLint errors and ensuring unformatted or failing code cannot be committed or merged.

---

## 2. User Stories / Developer Stories
- **As a developer (Rashik & Prashant)**, I want consistent code formatting (Prettier) and code quality standards (ESLint) enforced automatically across backend and frontend so our code style stays clean and uniform.
- **As a developer**, I want `pre-commit` to format and lint staged files via `lint-staged` so commits are quick and error-free.
- **As a developer**, I want `pre-push` to run the test suite locally so broken tests are never pushed to GitHub.
- **As a developer**, I want GitHub Actions CI to run tests, linters, typechecks, and builds on pull requests to `dev` (backend) and `develop` (frontend) so regressions are caught before merging.
- **As a user of BookPasal**, I want no regressions in existing pages (book details, collection, orders, notifications, cart, checkout) when frontend typing and lint issues are cleaned up.

---

## 3. Behaviours (Given / When / Then)

### Behaviour 1: Backend Lint & Format
- **Given** modern ESM backend code in `bookpasal_backend`,
- **When** `npm run lint` or `npm run format:check` is executed,
- **Then** ESLint (Flat Config v9) and Prettier check all backend JavaScript files and report zero errors.

### Behaviour 2: Backend Husky Git Hooks & CI
- **Given** a staged backend file with bad formatting,
- **When** `git commit` is invoked,
- **Then** `lint-staged` automatically formats the file with Prettier and checks it with ESLint before completing the commit.
- **Given** failing backend tests,
- **When** `git push` is invoked,
- **Then** `pre-push` runs `npm test` and aborts the push if tests fail.
- **Given** a Pull Request targeting `dev`,
- **When** GitHub Actions triggers,
- **Then** it starts a PostgreSQL service container, runs test DB setup/migrations, runs Vitest tests, ESLint, and Prettier checks.

### Behaviour 3: Frontend Legacy ESLint Remediation & Clean Linting
- **Given** the frontend codebase with 48 legacy ESLint errors and 153 warnings,
- **When** `npm run lint` is executed after fixes,
- **Then** ESLint passes with 0 errors:
  - `public/**` generated PWA service worker files are excluded from linting.
  - `@typescript-eslint/no-explicit-any` usages in `book.service.ts`, `question.service.ts`, `book/[id]`, and `collection/[id]` are replaced with concrete TypeScript interfaces.
  - Unescaped entity errors in JSX are resolved with standard HTML entities or proper quotes.
  - Synchronous `setState` in `useEffect` in `app/(protected)/orders/page.tsx` is fixed.

### Behaviour 4: Frontend Prettier, Husky Hooks & CI
- **Given** frontend TypeScript/React code,
- **When** `npm run format:check` or `npm run lint` is run,
- **Then** Prettier and ESLint pass cleanly.
- **Given** a staged frontend file,
- **When** `git commit` is invoked,
- **Then** `lint-staged` formats and lints the file.
- **Given** a pull request targeting `develop`,
- **When** GitHub Actions CI runs,
- **Then** it verifies `npm test`, `npx tsc --noEmit`, `npm run build`, `npm run lint`, and `npm run format:check`.

---

## 4. Data Model Changes
None. (This is an engineering tooling and code quality ticket).

---

## 5. API Contracts
None. (Existing API endpoints remain identical).

---

## 6. UI Behaviour (Mobile-First PWA)
- No visual or functional regressions to any UI screen.
- Mobile viewport smoke verification on:
  - Homepage (`/`)
  - Book details (`/book/[id]`)
  - Collection details (`/collection/[id]`)
  - Orders page (`/orders`)
- Verify responsive layout, install banner, push notification banner, and touch navigation remain intact at 375x667 / 390x844 viewports.

---

## 7. Permissions & Auth
No permission changes. Existing JWT and NextAuth auth flows remain unaffected.

---

## 8. Edge Cases & Failure Modes
- Generated PWA service worker files (`public/sw.js`, `public/worker-*.js`): Must be excluded in `.prettierignore` and `eslint.config.mjs` `globalIgnores` so builds don't produce dirty lint warnings.
- Backend CI Postgres: CI workflow must wait for Postgres health check on port 5432 before running `npm run db:test:reset` and `npm test`.
- Windows vs Linux line endings: Prettier configuration must enforce `endOfLine: "auto"` or `"lf"` cleanly across OS environments.
- Husky in multi-repo directory: Husky will be installed inside each individual repo (`bookpasal_backend` and `bookpasal_frontend`), ensuring normal repository git hooks function independently.

---

## 9. Out of Scope
- Rewriting or redesigning frontend pages.
- Migrating backend JavaScript to TypeScript (backend remains plain ESM JavaScript).
- Modifying business logic in orders, cart, or books beyond fixing lint syntax and typing.

---

## 10. Test Strategy Per Layer
- **Backend**:
  - Smoke tests with Vitest and Supertest (`npm test`).
  - Linter test (`npm run lint`).
  - Formatter check (`npm run format:check`).
  - Pre-commit hook simulation testing.
- **Frontend**:
  - Smoke tests with Vitest and React Testing Library (`npm test`).
  - TypeScript compiler typecheck (`npx tsc --noEmit`).
  - Production build verification (`npm run build`).
  - Linter test (`npm run lint` with 0 errors).
  - Formatter check (`npm run format:check`).
  - Mobile viewport browser verification (evidence screenshots).

---

## 11. Manual Test Checklist for Rashik
1. Clone / checkout backend branch: run `npm test`, `npm run lint`, `npm run format:check`.
2. Try a local commit in backend with bad formatting: verify Prettier automatically formats on commit.
3. Clone / checkout frontend branch: run `npm test`, `npx tsc --noEmit`, `npm run build`, `npm run lint`. Verify 0 lint errors.
4. Open the web app on mobile viewport (375x667): verify `/book/1`, `/collection/1`, and `/orders` load and render normally without React hydration errors.

---

## 12. Autonomy Contract
The build agent may make the following decisions autonomously:
- Exact Prettier formatting configuration (semi: true, singleQuote: false, tabWidth: 2, trailingComma: "es5").
- TypeScript interface definitions for existing untyped API payloads in frontend services.
- GitHub Actions CI workflow action versions (e.g. `actions/checkout@v4`, `actions/setup-node@v4`).

Real blockers that require stopping and asking Rashik:
1. Two consecutive quota / 429 errors.
2. Destructive file operations outside the workspace.
3. Requests requiring non-local credentials or secret environment variables.
4. Git merge conflicts with upstream base branches.
5. Inability to run commands due to system harness or platform failures.

