---
name: bp-finish
description: Finish a built BookPasal ticket. Runs a fresh-context code review, fixes real issues, pushes the ticket branches, opens Pull Requests and writes the handoff summary. Use when he says "bp-finish" after bp-build.
---
# bp-finish

## 1. Independent review
Review each touched repo's diff (branch vs its base: `dev` for `bookpasal_backend`, `develop` for `bookpasal_frontend`) in FRESH CONTEXT. Use a separate subagent or a new conversation that reads only spec.md, the slice files and the diff, so it is not biased by the build session. Use the code-review skill's two axes: (a) Standards: does it follow the repo's conventions, is it simple, are there obvious bugs, security issues, N+1 queries, missing validation or auth checks; (b) Spec: does it implement exactly what spec.md says, nothing missing and nothing extra.
Fix real issues with the same TDD discipline (failing test first for any bug), then rerun the full test, lint, typecheck and build in every touched repo. Record the review outcome in progress.md. Do not gold-plate.

## 2. Pull Requests (MANDATORY — The Agent MUST Create Them)
The user hates creating PRs manually. You must always push and open the Pull Requests yourself:
For each touched repo:
1. Push branch `bp-<n>-<slug>` to origin: `git -C <repo> push -u origin bp-<n>-<slug>`.
2. Open the Pull Request using GitHub CLI:
   - Structure: MUST strictly follow `docs/pull_request_template.md` (Summary, Slices & Changes, Mobile Screenshots, Verification summary, How to Test, Decisions & Trade-offs, and Tracker Ref). Keep it clean, professional, and concise without emojis or raw terminal test output dumps.
   - Screenshots: Attach or embed all mobile screenshots from `bookpasal-tracker/specs/BP-<n>-<slug>/evidence/`. Standard mobile dimensions are **480x1050** to ensure all 5 BottomNav items (Home, Wishlist, Sell, Orders, Profile) and header controls are fully visible. Never include screenshots showing loading skeletons or truncated nav bars.
   - Commands:
     - For `bookpasal_backend`: `gh pr create --base dev --title "[BP-<n>] <ticket title>" --body-file <path-to-populated-template> [--attach <evidence-image>]`
     - For `bookpasal_frontend`: `gh pr create --base develop --title "[BP-<n>] <ticket title>" --body-file <path-to-populated-template> [--attach <evidence-image>]`
3. PR Body contents:
   - Populate every section from `docs/pull_request_template.md`.
   - Ensure the tracker link uses `"Refs Rashik977/bookpasal-tracker#<n>"` (never "Closes", as tickets are closed manually).
4. PR Integrity Verification:
   - Run `gh pr view <pr#> --json additions,deletions,commits` immediately after creating each PR.
   - Verify that all slice commits and expected additions/deletions are present. If a PR shows 0 additions or is missing expected commits, STOP immediately and resolve — never present a PR as ready if it does not contain the full diff of all ticket slices.
5. NEVER merge the PRs. Rashik (or Prashant) reviews and merges them.

## 3. Handoff summary
Write `specs/BP-<n>-<slug>/handoff.md` and show Rashik: what was built, per-slice results, the manual test checklist for Rashik (concrete steps and expected results on mobile viewport), decisions the agent made, risks and anything suspicious, and the live PR links. Commit the specs folder in `bookpasal-tracker` locally (do not push the tracker unless Rashik says so).
