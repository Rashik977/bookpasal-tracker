---
name: bp-build
description: Autonomously implement an approved BookPasal ticket slice by slice with strict TDD and browser verification, with no questions unless there is a real blocker. Use when he says "bp-build" or "build it" after bp-start approval.
---
# bp-build

Autonomous phase. Rashik has already answered everything in bp-start. Do not ask him questions except for the real blockers listed below. Do not wait for confirmation between slices.

## Preconditions
- Find the ticket folder whose progress.md says "status: approved". If none, stop and tell him to run bp-start.
- For each repo the slices touch (`bookpasal_backend` and/or `bookpasal_frontend`), make sure the working tree is clean, fetch, and create branch `bp-<n>-<slug>` from the up-to-date base branch (`dev` for backend, `develop` for frontend). Never work directly on main/default/dev/develop.
- Confirm the baseline: run test, lint, typecheck and build in each touched repo and record the baseline in progress.md (failures that existed before you started, such as existing frontend lint warnings/errors, are not yours to fix, but report them).

## Loop: for each slice in order
1. Re-read spec.md, the slice file and progress.md (do not rely on memory). Mark the slice in-progress.
2. TDD (use the tdd skill): for each behaviour in the slice: write ONE failing test via the public interface; run it; confirm it fails for the right reason; write the minimum code to pass; run it; refactor while green. Repeat for the next behaviour. Never write all tests first and never write production code without a failing test.
3. Run the slice's tests until green.
4. Browser verification (UI-affecting slices): use Antigravity's browser tool (`/browser`) to start the app locally and follow the slice's "Browser check" steps.
   - MANDATORY: ALL browser verification MUST run in mobile viewport dimensions (e.g., 375x667, 390x844). Never test or capture desktop screenshots as proof of UI completeness.
   - Save screenshots to the ticket's evidence/ folder named `slice-NN-*`. If the browser tool is not available in the current environment, say so in progress.md, do not pretend, and fall back to API-level checks plus clear manual steps for Rashik.
5. Run the full test suite, lint, typecheck and build in EVERY touched repo. All must pass (apart from recorded baseline failures).
6. Commit in each touched repo with `git -C <repo>`: "BP-<n> slice <k>: <behaviour>". Never push in this phase.
7. Update progress.md: slice status, exact commands run and their results, evidence paths, deviations. Log every decision you made on your own in decisions.md (what, why, alternatives).
Then continue to the next slice immediately.

## Anti-failure rules (Gemini 3.8 Flash)
- Never claim success without running the command and reading its output. Quote the command and result.
- Do not run the same failing command more than twice without changing something. If you notice yourself repeating, stop and re-read the spec and slice.
- If your context gets long, re-read the three state files and continue from progress.md rather than relying on conversation memory.

## Real blockers: the ONLY reasons to stop and ask Rashik
1. An irreversible or destructive action (dropping/overwriting data, force push, anything touching a non-local environment).
2. A missing credential, API key or third-party account that has not been provided.
3. The spec contradicts the real code in a way that would change user-visible behaviour.
4. A test or build still fails after 3 genuinely different fix attempts.
5. Two consecutive quota/429/resource-exhausted errors: stop immediately; do not retry in a loop.
When blocked: write the question in questions.md (one question, your recommended answer, consequence of each option), mark the slice blocked in progress.md, and ask Rashik in a short phone-friendly message. If other slices do not depend on the blocked one, continue with them; otherwise stop.

## When all slices are done
Set progress.md to "status: built, awaiting bp-finish" and tell Rashik to run bp-finish. Do not push and do not open PRs.

