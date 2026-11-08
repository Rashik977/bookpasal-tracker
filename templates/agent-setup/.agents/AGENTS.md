# BookPasal: rules for every session

## Project
BookPasal is a marketplace for buying and selling books in Nepal (used and new, mostly academic and student books). Frontend: Next.js (TypeScript). Backend: Node/Express (plain JavaScript). Database: PostgreSQL. Two developers: Rashik (the user, GitHub Rashik977) and his friend (prashantmgk), who owns the FE and BE repos; Rashik is a collaborator. The product is close to release.

## Mobile-First PWA Mandate
- BookPasal is strictly a mobile-first Progressive Web App (PWA). The desktop experience is currently secondary / unpolished.
- CRITICAL FOR TESTING & SCREENSHOTS: ALL browser tests, verification, and PR evidence MUST run in mobile viewport dimensions. The standard mobile viewport for BookPasal is **width: 480px, height: 1000-1050px** (e.g. `--window-size=480,1050`). At narrower viewports (<450px) in headless browsers, desktop scrollbars cause the 5-item BottomNav (Home, Wishlist, Sell, Orders, Profile) and header actions to clip horizontally. Always use width 480px and verify all 5 bottom nav items are visible.
- REAL DATA & DELAY MANDATE: Screenshots MUST display real data (never loading spinners, skeletons, or blank mock states). Run the backend with seed data, connect the frontend, and allow 4-6 seconds delay for React Query and images to settle before capturing.
- Never test or capture desktop screenshots as proof of UI completeness. Treat and test BookPasal as a mobile application.

## Layout
- This folder contains the FE repo (`bookpasal_frontend`), the BE repo (`bookpasal_backend`) and `bookpasal-tracker/` (Rashik's personal repo: specs, scripts, domain docs). This folder itself is not a git repo. Use `git -C <repo>` for every git command and keep commits, branches and PRs separate per repo.
- Base branches: BE uses `dev`; FE uses `develop`. Always branch from and target these branches, not main.
- NEVER commit agent files (.agents, AGENTS.md, specs) into the FE or BE repos.
- Tickets live in the GitHub Project "Book pasal features" (owner Rashik977; tracker repo Rashik977/bookpasal-tracker). Fields: Status, Priority (Blocked, Very High, High, Medium, Low), SP, Assignee. Rashik moves tickets on the board himself; never edit the board.
- Per-ticket docs: bookpasal-tracker/specs/BP-<issue#>-<slug>/ containing ticket.md, spec.md, slices/NN-<name>.md, progress.md, decisions.md, questions.md, evidence/.
- Domain glossary and ADRs: bookpasal-tracker/docs/.

## Workflow (one ticket at a time)
1. bp-start: pick top ticket, explore code, interview Rashik one question at a time, write spec.md and vertical slices, get approval. This is the only phase where questions are expected.
2. bp-build: fully autonomous TDD, slice by slice. No questions except real blockers (see bp-build).
3. bp-finish: fresh-context review, draft PRs, handoff summary. Rashik does the final review and manual testing.
Bug fixes found in review follow the same discipline: write a failing test that reproduces it first, then fix.

## Non-negotiable engineering rules
- VERTICAL SLICES ONLY. Each slice is a thin working path through all layers it needs (migration, backend, frontend, tests) for one behaviour, demonstrable on its own. Never do horizontal work ("all models", "all routes", "all UI").
- STRICT TDD. For each behaviour: write ONE failing test through the public interface, run it, confirm it fails for the right reason, write the minimum code to pass, then refactor. Never write all tests first. Test behaviour, not implementation details. Use the tdd skill.
- Tests use a real local PostgreSQL test database (name ends in _test, e.g. bookpasal_test). Never mock the database.
- Follow each repo's existing conventions. Do not refactor, reformat or rename unrelated code. Prefer small, maintainable solutions over clever ones.
- New dependencies only if truly needed, free and well maintained; log each in decisions.md.
- Nepal context where relevant: NPR currency, Nepali phone numbers and addresses, low-bandwidth and mobile-first users.

## Verification (Gemini 3.8 Flash needs hard evidence)
- A slice is done only when: its tests pass, the full test suite, lint, typecheck and build pass in every touched repo, and (for UI) the browser check passed with a mobile-viewport screenshot saved in evidence/. Quote the actual command and the result; never claim success without running it.
- Baseline rule: Unrelated pre-existing failures (such as legacy frontend lint warnings/errors) are logged as baseline and not unsolicitedly fixed.
- Do not run the same failing command more than twice without changing something. After 3 different failed fixes, stop and record it in questions.md.
- If a command cannot be run in this environment, say so plainly instead of assuming it works.

## Context discipline
- Your context is limited and degrades. At the start of every slice re-read spec.md, the slice file and progress.md. Persist state in files (progress.md, decisions.md), not in memory.
- Write results to files, not only to the terminal.
- Keep chat replies short and concrete.

## Git and safety
- Branch per ticket in each touched repo: bp-<issue#>-<slug>, created from the up-to-date base branch (`dev` for backend, `develop` for frontend). One commit per slice: "BP-<n> slice <k>: <behaviour>".
- PULL REQUEST MANDATE: The agent MUST create the Pull Requests (`gh pr create`) for both Frontend (`develop`) and Backend (`dev`) upon completing tickets or chores, strictly following `docs/pull_request_template.md` (summary, slices, mobile screenshots, test evidence, how to test, decisions). Never leave work only in local branches or ask Rashik to open PRs manually — Rashik hates creating PRs.
- MERGE RULE: NEVER merge PRs automatically, and NEVER push directly to main/default/dev/develop. Only Rashik (or Prashant) performs the final review and merges PRs.
- BARE PUSH PROHIBITION: Never run bare `git push`. Always specify remote and ticket branch explicitly: `git -C <repo> push -u origin bp-<issue#>-<slug>`. Direct push to `main`, `dev`, and `develop` is strictly blocked at the git hook level in `.husky/pre-push`.
- PR INTEGRITY VERIFICATION: After creating PRs, verify with `gh pr view` that all commits and diff additions/deletions are present. If a PR has missing commits or zero changes, immediately investigate and report.
- NEVER force push.
- NEVER read or print real .env files or secrets. Local database only. Refuse anything that targets a non-local environment.
- No destructive commands outside the repos. No global installs without telling Rashik.

## Quota safety
- If you hit two consecutive quota/429/resource-exhausted errors, stop and report. Never loop.

## Communication
When you must ask Rashik something, make it short and answerable from a phone: one question, your recommended answer, and the consequence of each option.

## Agent skills
### Issue tracker
Local markdown files under `bookpasal-tracker/specs/`. See `docs/agents/issue-tracker.md`.
### Domain docs
Glossary and ADRs under `bookpasal-tracker/docs/`. See `docs/agents/domain.md`.
