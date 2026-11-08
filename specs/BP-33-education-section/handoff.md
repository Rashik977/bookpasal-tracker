# BP-33: Education Section - Handoff Summary

- **Ticket**: [Issue #33: Education section](https://github.com/Rashik977/bookpasal-tracker/issues/33)
- **Status**: Ready for Review & Manual Verification (PRs Open)
- **Backend PR**: [prashantmgk/bookpasal_backend#19](https://github.com/prashantmgk/bookpasal_backend/pull/19) (`dev` ← `bp-33-education-section`)
- **Frontend PR**: [prashantmgk/bookpasal_frontend#18](https://github.com/prashantmgk/bookpasal_frontend/pull/18) (`develop` ← `bp-33-education-section`)

---

## 1. What Was Built
A dedicated, clutter-free Academic & Education marketplace inside BookPasal for Nepali students and sellers:
1. **Curriculum Taxonomy & Data Partitioning**: Complete 3-tier hierarchy (`school` Grades 1-10 / SEE, `plus_two` Grades 11-12 Science/Management/Humanities/Law, `bachelors` TU/IOE/CSIT/BBA) with strict search partitioning (`is_academic: false` on general search; `is_academic: true` on education browse).
2. **Animated Mode Switcher & Theme Shift**: Minimalist toggle in `HomeTopBar` transitioning smoothly between warm literary tones (`General`) and scholastic navy/emerald tones (`Academic`).
3. **Dedicated Listing Wizard (`/sell/academic`)**: 3-step listing flow with cascading Level -> Class -> Subject selectors, "Other / Custom" manual subject fallback, syllabus version (`current_syllabus` vs `old_course`), and markings status (`clean`, `pencil`, `pen_notes`).
4. **Education Browse Hub (`/education`)**: Level tabs, horizontal scroll Class and Subject filter chips, and responsive `BookCard` grid with single subtle curriculum badges.
5. **SEO Dynamic Routes (`/education/[classSlug]/[[...subjectSlug]]`)**: Dynamic class and subject metadata, deep linking, and automated breadcrumbs.
6. **Academic Book Details (`/book/[id]`)**: `AcademicDetailsCard` displaying verified academic metadata, an alert warning pill for discontinued courses, and curriculum-aware related textbook recommendations.

---

## 2. Per-Slice Breakdown & Review Outcomes

| Slice / Step | Highlights | BE Commits | FE Commits |
|---|---|---|---|
| **Slice 01** | Taxonomy migration, seed, `GET /api/education/taxonomy`, search partitioning, `ModeSwitcher` | `37cc812` | `78dcdaf` |
| **Slice 02** | Academic book persistence schema, `/sell/academic` 3-step listing wizard | `dd90cf0` | `77c431b` |
| **Slice 03** | `GET /api/education/books` filtering API, `/education` browse hub with Level/Class/Subject chips | `87709bd` | `370cff0` |
| **Slice 04** | Slug resolution API, `/education/[classSlug]/[subjectSlug]` SEO pages | `74e72c9` | `4a899ad` |
| **Slice 05** | Academic taxonomy joins on `/book/[id]`, `AcademicDetailsCard`, curriculum recommendations | `b8cf85b` | `4c92421` |
| **Review Fixes** | Moved related query to `educationModal`, graceful slug fallback, custom subject input, `old_course` warning pill, `useAuthGuard` protection | `ac1d5f9` | `24cafca` |

---

## 3. Automated Verification Summary

- **Backend**:
  - Tests: `npm test` -> **PASS (7 test files, 24 passed)**
  - Lint: `npm run lint` -> **PASS (0 errors, 0 warnings)**
  - Format: `npm run format:check` -> **PASS (Prettier verified)**
- **Frontend**:
  - Tests: `npm test` -> **PASS (8 test files, 17 passed)**
  - Typecheck: `npx tsc --noEmit` -> **PASS (0 errors)**
  - Build: `npm run build` -> **PASS (Next.js production build succeeded)**
  - Lint: `npm run lint` -> **PASS (0 errors; baseline pre-existing warnings preserved)**
- **Mobile Viewport Evidence (480px × 1050px)**:
  - `evidence/slice-01-mode-switch.png`: Mode switcher active in Home header with 5 bottom nav items intact.
  - `evidence/slice-02-academic-sell.png`: Dedicated 3-step listing wizard with cascading selectors.
  - `evidence/slice-03-education-hub.png`: Education browse hub with Level tabs and textbook grid.
  - `evidence/slice-04-seo-route.png`: SEO dynamic route (`/education/class-10`) with breadcrumb navigation.
  - `evidence/slice-05-academic-detail.png`: Academic detail card, tags, and curriculum-aware recommendations.

---

## 4. Manual Test Checklist for Rashik (Mobile Viewport: 480px)

1. **Header Mode Switch**:
   - Open `http://localhost:3000/` at 480px width.
   - Tap `[ 🎓 Academic ]` in the top bar: verify smooth theme shift and navigation to `/education`.
   - Tap `[ 📚 General ]`: verify instant return to the literature home view.
2. **Curriculum Browsing**:
   - On `/education`, tap the `+2 High School` tab: verify classes update to Class 11 and Class 12 streams.
   - Tap `Class 10 (SEE)` -> `Science & Technology`: verify textbooks update with real seed data.
   - Verify all 5 BottomNav items (`Home`, `Wishlist`, `Sell`, `Orders`, `Profile`) remain fully visible and clickable without horizontal clipping.
3. **Dedicated Sell Flow**:
   - Tap `Sell` on the bottom nav, then tap the green banner `Sell Academic ->`.
   - Verify unauthenticated users are prompted with `AuthModal`.
   - Once logged in, select `School` -> `Class 10 (SEE)` -> `Other / Custom Subject`: verify custom subject input appears.
   - Fill in price, condition, upload a photo, and publish: verify redirect to `/education` with the new listing.
4. **Academic Book Detail**:
   - Click on any textbook (e.g. *Compulsory Mathematics Class 10*):
   - Verify breadcrumb path: `Home > Education > Class 10 (SEE) > Compulsory Mathematics`.
   - Verify `Curriculum & Academic Details` card displays Level, Class, Subject, Board, Syllabus, and Markings.
   - If syllabus is `Old Course`, verify the warning pill `Old Course / Discontinued Syllabus` appears.
   - Check the `Related Academic Textbooks` section: verify it only recommends books from the same curriculum.
5. **Partitioning**:
   - Return to General Home (`/`) and search for a keyword: verify textbooks do not appear in general fiction/novel search results.

---

## 5. Architectural Decisions & Trade-offs
- **Normalized Tables (Decision #4)**: Split into `academic_classes` and `academic_subjects` with foreign keys on `books` instead of free-text tags to ensure relational integrity, taxonomy caching, and SEO slug resolution.
- **Strict Partitioning (Decision #5)**: Used `is_academic` boolean index on `books` to cleanly bifurcate academic discovery from general book browsing.
- **Dedicated Flow (Decision #3)**: Provided `/sell/academic` rather than adding dozens of conditional fields to the general sell accordion.
- **Graceful Slug Fallbacks**: Backend query builder gracefully ignores non-existent or deleted class/subject slugs instead of returning empty 404s.

---

## 6. Risks & Notes for Production
- **Database Migrations**: When deploying to production, run `npx knex migrate:latest` followed by `npx knex seed:run` (specifically `02_seed_academic_curriculum.js`) to seed the CDC, NEB, and TU taxonomy.
- **PR Merge Discipline**: PRs are drafted and waiting for your review. Never auto-merge; perform final review on GitHub:
  - [Backend PR #19](https://github.com/prashantmgk/bookpasal_backend/pull/19)
  - [Frontend PR #18](https://github.com/prashantmgk/bookpasal_frontend/pull/18)
