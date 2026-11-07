<!-- 
  BookPasal Pull Request Template
  Used by bp-finish and developers for all Frontend and Backend PRs.
-->

## 📌 Summary
<!-- High-level description of what this PR introduces and the problem it solves -->
[Brief description of the changes]

**Tracker Reference:** Refs Rashik977/bookpasal-tracker#[ISSUE_NUMBER]

---

## 📱 Mobile-First PWA Evidence & Screenshots
<!-- 
  CRITICAL: BookPasal is strictly a mobile-first PWA. 
  All screenshots must be taken in mobile viewport dimensions (375x667, 390x844).
  Screenshots from evidence/ are automatically attached.
-->
| Screen / Feature | Viewport | Mobile Screenshot |
| :--- | :--- | :--- |
| [Feature Name] | Mobile (390x844) | ![Mobile View](path/to/evidence/slice-01.png) |

---

## 🧱 Vertical Slices & Changes Made
<!-- Breakdown of the thin vertical paths implemented -->
- **Slice 01: [Slice Name]**
  - *Backend*: [Models/Migrations/Routes/Services touched]
  - *Frontend*: [Components/Pages/Services touched]
  - *Behavior*: [Demonstrable user or system behavior]
- **Slice 02: [Slice Name]**
  - ...

---

## 🧪 Automated Verification & Evidence
<!-- Hard evidence of tests, typechecks, and builds executed -->

### Test Suite Execution
```bash
# Exact test command executed (e.g. npm test)
[Paste command output showing passing tests]
```

### Typecheck & Build
```bash
# Frontend: npx tsc --noEmit && npm run build
# Backend: node checks
[Paste build confirmation output]
```

---

## 🔍 How to Test Manually (Reviewer Checklist)
<!-- Step-by-step reproduction steps for Rashik / Prashant to test on a mobile device/browser -->
1. **Setup**: [e.g. Ensure local Postgres test DB / docker is running]
2. **Step 1**: Open app in mobile view (or on phone): `http://localhost:3000/[route]`
3. **Step 2**: [Perform action, e.g. click button, submit form]
4. **Expected Result**: [What should be seen or asserted]

---

## ⚖️ Architectural Decisions & Trade-offs
<!-- Decisions made autonomously by the agent or agreed upon during bp-start -->
- **Decision 1**: [Rationale and alternatives considered from decisions.md]

---

## ✅ Quality Checklist
- [x] **Strict TDD**: Failing test written first via public interface, then minimal implementation.
- [x] **Zero-Mock DB**: Backend tested against real local `bookpasal_test` PostgreSQL.
- [x] **Mobile Viewport**: Verified in mobile dimensions, touch targets checked.
- [x] **Clean Commits**: One commit per slice (`BP-<n> slice <k>: <behaviour>`).
- [x] **Collaborator Respect**: Targeted against `dev` (BE) or `develop` (FE); draft/ready for manual merge only.
