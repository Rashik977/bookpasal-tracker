---
name: bp-start
description: Start the next BookPasal ticket. Picks the highest-priority ticket assigned to Rashik, explores the code, interviews him one question at a time, writes the spec and vertical slices, and gets his approval. Use when he says "bp-start", "next ticket" or "start ticket".
---
# bp-start

Interactive phase. This is the only phase where you ask Rashik questions. Do NOT write production code or create branches in the FE/BE repos.

## 1. Pick
1. Run `bash bookpasal-tracker/scripts/my-tickets.sh`. Show the top 3 (number, title, priority, SP, status) and how many of his tickets are Blocked (count only). Take #1 unless he names another or changes selection.
2. Read the issue fully (`gh issue view <n> --repo Rashik977/bookpasal-tracker --comments`).
3. Create `bookpasal-tracker/specs/BP-<n>-<slug>/` and write ticket.md (a copy of the issue). Create empty progress.md, decisions.md, questions.md and an evidence/ folder.

## 2. Explore before asking
Read the relevant code in BOTH repos (`bookpasal_backend` and `bookpasal_frontend`: routes, controllers, services, models/migrations, pages, components, API client, auth and role handling, existing tests). Also read `bookpasal-tracker/docs/` for glossary and ADRs. Your questions must be informed by the code, never ask what the code or ticket already answers.

## 3. Interview (use the grill-with-docs skill's approach)
- ONE question at a time. For each question give your recommended answer and a one-line reason, so Rashik can reply "yes" or correct you.
- Keep going until every branch of the decision tree is resolved. Cover, where relevant: exact user-visible behaviour per role (buyer, seller, admin, guest); data model and migrations; API contracts and validation; permissions and auth; loading, empty and error states; mobile and responsive behaviour (BookPasal is strictly a mobile-first PWA); edge cases and failure modes; Nepal context (NPR, phone formats, addresses, low bandwidth); what is explicitly OUT of scope; how each behaviour should be tested; anything that needs a third-party account or credential (flag it now so it is not a surprise mid-build).
- If he says "you decide", record it as an Autonomy decision.
- When new domain terms or hard-to-reverse decisions come up, update `bookpasal-tracker/docs/` (glossary / ADR) inline.

## 4. Write spec.md (this replaces a separate PRD; do not create a PRD file or GitHub issue)
Sections: Goal; User stories; Behaviours (Given/When/Then, each testable); Data model changes; API contracts; UI behaviour (loading/empty/error/mobile viewport); Permissions; Edge cases; Out of scope; Test strategy per layer; Manual test checklist for Rashik; Autonomy contract (decisions the build agent may take alone, and what counts as a real blocker, including the standard five from AGENTS.md/bp-build).

## 5. Slice (use the to-tickets vertical-slice approach, saved as local files)
Write `bookpasal-tracker/specs/BP-<n>-<slug>/slices/NN-<name>.md`. Rules:
- Each slice is a thin, complete, demonstrable path through every layer it needs for ONE behaviour. Slice 1 is the tracer bullet: the smallest end-to-end path that proves the architecture works.
- NEVER create horizontal slices (all models, all endpoints, all UI).
- A migration belongs to the first slice that needs it, not to a separate "database slice".
- Order slices so each builds on a working previous one; each should be small enough to finish and verify in one sitting.
Each slice file contains: Goal and behaviour; Why it is vertical (layers touched); EXACT files to create/modify in each repo (`bookpasal_backend`, `bookpasal_frontend`, found by exploring, not guessed); the FIRST failing test to write (file path, test name, what it asserts); further behaviours to TDD in order; commands to run the slice's tests and the full suite in each repo; Browser check (numbered steps to perform in a MOBILE VIEWPORT and what to see); Done criteria; Risks or open decisions.
Write progress.md as an index: slice list with status (pending/in-progress/done/blocked), plus "status: awaiting approval".

## 6. Approve
Show Rashik a compact table of slices (number, behaviour, layers, estimated size) and the spec's Autonomy contract. Ask him to approve or change it. On approval set progress.md to "status: approved" and tell him: set the thinking level to Low or Medium if possible, then run bp-build. Do not start building.

