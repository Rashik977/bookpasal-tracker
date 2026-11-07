# Issue Tracker: Local Files

Issues, specs, and slices for BookPasal live as markdown files under `bookpasal-tracker/specs/`.

## Conventions

- Do NOT create GitHub issues or update GitHub project boards automatically. Rashik manages the GitHub board by hand.
- Per-ticket directory: `bookpasal-tracker/specs/BP-<issue#>-<slug>/`
- Each ticket folder contains:
  - `ticket.md`: Copy of the issue description from GitHub/tracker
  - `spec.md`: The approved specification (Given/When/Then, behavior, contracts)
  - `slices/NN-<name>.md`: Vertical slice execution plans
  - `progress.md`: Index of slices and current status
  - `decisions.md`: Log of autonomous engineering decisions
  - `questions.md`: Log of blocker questions
  - `evidence/`: Verification test outputs and mobile-view screenshots
- Triage labels: Not needed.

## When a skill says "publish to the issue tracker"

Write the markdown specification / tickets directly under `bookpasal-tracker/specs/BP-<issue#>-<slug>/`.

## When a skill says "fetch the relevant ticket"

Read from `bookpasal-tracker/specs/BP-<issue#>-<slug>/` or view via `gh issue view <issue#> --repo Rashik977/bookpasal-tracker`.

