# SETUP PROMPT FOR PRASHANT'S ANTIGRAVITY AGENT

> **Instructions for Prashant (`prashantmgk`):**
> Copy and paste the entire block below into your **Antigravity IDE** chat prompt. Your Antigravity agent will read it and autonomously set up your workspace to match Rashik's exact workflow.

---

```markdown
# TASK: Setup Prashant's BookPasal Agentic Workflow

You are Antigravity. This is a ONE-TIME SETUP task. Do NOT start work on any BookPasal ticket yet. Read all instructions, execute the steps in order, verify against hard evidence, and give me the completion report at the end.

You are pair-programming with Prashant (GitHub: prashantmgk). Prashant OWNS the BookPasal frontend and backend repositories (`prashantmgk/bookpasal_frontend` and `prashantmgk/bookpasal_backend`). Rashik (`Rashik977`) is his collaborator. The goal is to set up Prashant's local machine with the EXACT same agentic workflow (`bp-start` -> `bp-build` -> `bp-finish`) that Rashik uses.

---

## 1. Core Project Principles & Mandates

1. **Mobile-First PWA Mandate**: 
   BookPasal is strictly a mobile-first Progressive Web App. The desktop experience is currently unpolished and secondary. ALL UI testing, browser verifications, and visual assertions MUST run in mobile viewport dimensions. The standard mobile viewport for BookPasal is **width: 480px, height: 1000-1050px** (e.g., `--window-size=480,1050`). At narrower widths (<450px) in headless browsers, desktop scrollbars cause the 5-item BottomNav (Home, Wishlist, Sell, Orders, Profile) and header actions to clip horizontally. Screenshots must always use real data (never loading skeletons or spinners) and allow 4-6 seconds delay for React Query to settle. Never test or capture desktop screenshots as proof of completeness.
2. **Multi-Repo Architecture**:
   The current working folder is a parent folder containing three sibling repositories:
   - `bookpasal_backend/` (Node.js ESM, Express, Knex, PostgreSQL. Base branch: `dev`)
   - `bookpasal_frontend/` (Next.js 16, React 19, TypeScript, Tailwind. Base branch: `develop`)
   - `bookpasal-tracker/` (Rashik977/bookpasal-tracker: specs, vertical slices, ADRs, glossary)
   The parent folder is NOT a git repo. Always execute git commands with `git -C <repo>`.
3. **PULL REQUEST MANDATE**:
   Prashant and Rashik hate creating Pull Requests manually. When work is completed, the agent MUST push the branch and open the Pull Request using GitHub CLI (`gh pr create`), strictly following `docs/pull_request_template.md`. The agent NEVER merges PRs. Only Prashant or Rashik reviews and merges PRs.
4. **Strict TDD & Zero-Mock Database**:
   Vertical slices only. Each slice is a thin end-to-end path through all layers it needs. Tests hit a real local PostgreSQL database (`bookpasal_test`), never mocks.

---

## 2. Setup Execution Steps (Do in this order)

### Step 1: Verify GitHub CLI Authentication
1. Run `gh auth status`.
2. Check if the authenticated account has the `project` scope.
3. If missing the `project` scope, STOP and ask Prashant to run:
   ```bash
   gh auth refresh -s project
   ```
4. Confirm `gh project list --owner Rashik977` returns Project #2 (`Book pasal features`).

### Step 2: Copy Agent Skills & Rules from Tracker
Rashik has bundled the exact configuration, custom skills (`bp-start`, `bp-build`, `bp-finish`), Matt Pocock's skills, and rules inside `bookpasal-tracker/templates/agent-setup/`.
Execute the following to copy them into the workspace root:
- Copy `.agents/` folder:
  `Copy-Item -Recurse -Force "bookpasal-tracker/templates/agent-setup/.agents" .`
- Copy `AGENTS.md`:
  `Copy-Item -Force "bookpasal-tracker/templates/agent-setup/AGENTS.md" .`
- Copy `docs/` folder:
  `Copy-Item -Recurse -Force "bookpasal-tracker/templates/agent-setup/docs" .`
Verify that `AGENTS.md` exists at the root and character count is under 12,000.

### Step 3: Local PostgreSQL Test Database
1. Check if the PostgreSQL Docker container is running:
   ```bash
   docker ps --filter "name=bookpasal_db"
   ```
   If not running, start it:
   ```bash
   cd bookpasal_backend
   npm run db:up
   cd ..
   ```
2. Ensure the dedicated test database `bookpasal_test` exists inside the container:
   ```bash
   docker exec -i bookpasal_db psql -U postgres -c "CREATE DATABASE bookpasal_test;"
   ```
   *(If it already exists, proceed silently).*

### Step 4: Test Harnesses (Backend & Frontend)
Rashik has already built, tested, and opened Pull Requests for the test harnesses:
- **Backend PR**: https://github.com/prashantmgk/bookpasal_backend/pull/17 (`chore/test-harness` -> `dev`)
- **Frontend PR**: https://github.com/prashantmgk/bookpasal_frontend/pull/16 (`chore/test-harness` -> `develop`)

In `bookpasal_backend`:
1. Fetch and checkout branch `chore/test-harness`:
   ```bash
   git -C bookpasal_backend fetch origin chore/test-harness
   git -C bookpasal_backend checkout chore/test-harness
   ```
2. Install dependencies:
   ```bash
   npm --prefix bookpasal_backend install
   ```
3. Run test suite:
   ```bash
   npm --prefix bookpasal_backend test
   ```
   Verify 2/2 tests pass against `bookpasal_test`.

In `bookpasal_frontend`:
1. Fetch and checkout branch `chore/test-harness`:
   ```bash
   git -C bookpasal_frontend fetch origin chore/test-harness
   git -C bookpasal_frontend checkout chore/test-harness
   ```
2. Install dependencies:
   ```bash
   npm --prefix bookpasal_frontend install
   ```
3. Run test suite:
   ```bash
   npm --prefix bookpasal_frontend test
   ```
   Verify smoke test passes.

*(Prashant can merge both PRs #16 and #17 on GitHub into `dev` and `develop` whenever he is ready).*

### Step 5: Verify Ticket Scripts
Run the ticket filter script for Prashant:
```powershell
powershell -ExecutionPolicy Bypass -File bookpasal-tracker/scripts/my-tickets.ps1
```
*(Or in Git Bash: `bash bookpasal-tracker/scripts/my-tickets.sh`)*.
Verify that it auto-detects `prashantmgk`, filters for tickets in `Backlog` status, excludes `Blocking`/`Blocked`, and prints the top assigned tickets (e.g. #16, #22, #27).

---

## 3. Completion Report

Provide Prashant with a concise summary:
1. Confirmation that `.agents/`, `AGENTS.md`, and `docs/` are in place.
2. Result of `npm test` in backend (hitting `bookpasal_test`) and frontend.
3. The top 3 tickets assigned to Prashant in `Backlog` printed by `my-tickets.ps1`.
4. Exact trigger phrases:
   - `bp-start`: To pick ticket, explore code, interview Prashant, and create vertical slices.
   - `bp-build`: To autonomously implement slices with strict TDD and mobile browser checks.
   - `bp-finish`: To run dual-axis review and automatically open clean Pull Requests using `docs/pull_request_template.md`.
```

