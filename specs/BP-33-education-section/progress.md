# BP-33: Education section - Progress

## Baseline
- Backend lint: passed (`npm run lint`, 0 errors, 0 warnings)
- Backend tests: passed (`npm test`, 2 test files, 5 tests passed)
- Frontend lint: passed (`npm run lint`, 0 errors, 41 pre-existing warnings recorded as baseline)
- Frontend tests: passed (`npm test`, 3 test files, 4 tests passed)
- Frontend typecheck: passed (`tsc -p bookpasal_frontend --noEmit`, 0 errors)
- Frontend build: passed (`npm run build`, Next.js build succeeded)

## Slices

| Slice | Name | Status | Description |
|---|---|---|---|
| 01 | `01-taxonomy-and-partitioning` | completed | Nepali curriculum taxonomy migration, seed, GET /api/education/taxonomy, search partitioning, and frontend Mode Switcher with animated theme shift |
| 02 | `02-academic-listing-flow` | completed | Dedicated `/sell/academic` listing wizard with cascading Class/Subject selectors and student attributes |
| 03 | `03-education-browse-hub` | completed | Dedicated `/education` Hub with Level tabs, Class & Subject chips, and clutter-free BookCard grid |
| 04 | `04-seo-dynamic-routes` | completed | Dynamic SEO routes `/education/[classSlug]/[[...subjectSlug]]` with dynamic metadata and deep linking |
| 05 | `05-academic-detail-and-recommendations` | completed | Academic details card on `/book/[id]`, curriculum breadcrumbs, and curriculum-aware related books |

## Slice 01 Evidence & Results
- **Backend Tests**: `npm test` -> 3 passed test files, 9 tests passed.
  - Integration test: `bookpasal_backend/tests/integration/educationTaxonomy.test.js` (4 tests passed).
- **Backend Lint & Format**: `npm run lint` & `npm run format:check` -> passed (0 errors).
- **Frontend Tests**: `npm test` -> 4 passed test files, 7 tests passed.
  - Component test: `bookpasal_frontend/tests/components/ModeSwitcher.test.tsx` (3 tests passed).
- **Frontend Typecheck & Build**: `tsc -p bookpasal_frontend --noEmit` & `npm run build` -> passed (0 errors).
- **Mobile Viewport Screenshot**: `evidence/slice-01-mode-switch.png` captured at 480px × 1050px with real seed data and verified using `read_file` (all 5 BottomNav items visible, ModeSwitcher centered and active, real books rendered).
- **Commits**:
  - Backend: `37cc812` ("BP-33 slice 01: Nepali curriculum taxonomy, partitioning, and GET /api/education/taxonomy")
  - Frontend: `78dcdaf` ("BP-33 slice 01: ModeSwitcher component, education types, queries, and services")

## Slice 02 Evidence & Results
- **Backend Tests**: `npm test` -> 4 passed test files, 12 tests passed.
  - Integration test: `bookpasal_backend/tests/integration/createAcademicBook.test.js` (3 tests passed).
- **Backend Lint & Format**: `npm run lint` & `npm run format:check` -> passed (0 errors).
- **Frontend Tests**: `npm test` -> 5 passed test files, 9 tests passed.
  - Component test: `bookpasal_frontend/tests/components/AcademicSellForm.test.tsx` (2 tests passed).
- **Frontend Typecheck & Build**: `tsc` & `npm run build` -> passed (Next.js generated `ƒ /sell/academic`, 0 errors).
- **Mobile Viewport Screenshot**: `evidence/slice-02-academic-sell.png` captured at 480px × 1050px and verified using `read_file` (3-step mobile wizard, curriculum level tabs, cascading selectors, all 5 BottomNav items visible).
- **Commits**:
  - Backend: `dd90cf0` ("BP-33 slice 02: Academic textbook validation and persistence")
  - Frontend: `77c431b` ("BP-33 slice 02: Dedicated /sell/academic wizard with cascading selectors")

## Slice 03 Evidence & Results
- **Backend Tests**: `npm test` -> 5 passed test files, 17 tests passed.
  - Integration test: `bookpasal_backend/tests/integration/educationBooks.test.js` (5 tests passed).
- **Backend Lint & Format**: `npm run lint` & `npm run format:check` -> passed (0 errors).
- **Frontend Tests**: `npm test` -> 6 passed test files, 11 tests passed.
  - Component test: `bookpasal_frontend/tests/components/EducationHub.test.tsx` (2 tests passed).
- **Frontend Typecheck & Build**: `npm run build` -> passed (Next.js generated `ƒ /education`, 0 errors).
- **Mobile Viewport Screenshot**: `evidence/slice-03-education-hub.png` captured at 480px × 1050px with real seed data and verified using `read_file` (all 5 BottomNav items visible, ModeSwitcher centered with Academic active, real textbooks displayed with emerald green curriculum badges and NPR prices).
- **Commits**:
  - Backend: `87709bd` ("BP-33 slice 03: Education academic books filtering API")
  - Frontend: `370cff0` ("BP-33 slice 03: Dedicated /education browse hub with curriculum filters")

## Slice 04 Evidence & Results
- **Backend Tests**: `npm test` -> 6 passed test files, 21 tests passed.
  - Integration test: `bookpasal_backend/tests/integration/educationSlugs.test.js` (4 tests passed).
- **Backend Lint & Format**: `npm run lint` & `npm run format:check` -> passed (0 errors).
- **Frontend Tests**: `npm test` -> 7 passed test files, 13 tests passed.
  - Unit test: `bookpasal_frontend/tests/components/EducationSEO.test.tsx` (2 tests passed).
- **Frontend Typecheck & Build**: `npm run build` -> passed (Next.js generated `ƒ /education/[classSlug]` and `ƒ /education/[classSlug]/[subjectSlug]`, 0 errors).
- **Mobile Viewport Screenshot**: `evidence/slice-04-seo-route.png` captured at 480px × 1050px with real data and verified using `read_file` (all 5 BottomNav items visible, breadcrumb navigation `Home > Education > Class 10 (SEE)`, hero card, matching Class 10 books).
- **Commits**:
  - Backend: `74e72c9` ("BP-33 slice 04: Curriculum class and subject slug resolution API")
  - Frontend: `4a899ad` ("BP-33 slice 04: Dynamic SEO curriculum routes with breadcrumbs and subject filters")

## Slice 05 Evidence & Results
- **Backend Tests**: `npm test` -> 7 passed test files, 23 tests passed.
  - Integration test: `bookpasal_backend/tests/integration/academicBookDetails.test.js` (2 tests passed).
- **Backend Lint & Format**: `npm run lint` & `npm run format:check` -> passed (0 errors).
- **Frontend Tests**: `npm test` -> 8 passed test files, 15 tests passed.
  - Component test: `bookpasal_frontend/tests/components/AcademicBookDetail.test.tsx` (2 tests passed).
- **Frontend Typecheck & Build**: `npm run build` -> passed (0 errors).
- **Mobile Viewport Screenshot**: `evidence/slice-05-academic-detail.png` captured at 480px × 1050px with real data and verified using `read_file` (all 5 BottomNav items visible, academic breadcrumb `Home > Education > Class 10 > Compulsory Mathematics`, cover carousel, academic tags, `Curriculum & Academic Details` card, related textbooks).
- **Commits**:
  - Backend: `b8cf85b` ("BP-33 slice 05: Academic book details and curriculum-aware recommendations")
  - Frontend: `4c92421` ("BP-33 slice 05: AcademicDetailsCard, curriculum breadcrumbs, and related textbooks")

## Independent Review & Fixes
- **Two-Axis Review Execution**: Spawned parallel Standards and Spec review subagents in fresh context.
- **Standards Findings & Fixes**:
  - Encapsulated raw `db("books")` queries in `bookService.getRelatedBooks` directly into `educationModal.getRelatedAcademicBooks` with full `currentUserId` wishlist support.
- **Spec Findings & Fixes**:
  - Implemented graceful fallback on non-existent class/subject slugs in `educationModal.getAcademicBooks` without error or empty results (verified via TDD integration test).
  - Added "Other / Custom" option and custom subject input in `AcademicStepDetails` with TDD component test.
  - Added warning pill indicator for `old_course` syllabus in `AcademicDetailsCard` with TDD component test.
  - Enforced `useAuthGuard` protection on `/sell/academic` form submission and selling CTA.
- **Review Fix Commits**:
  - Backend: `ac1d5f9` ("BP-33 review fix: Encapsulate related books query in educationModal and handle graceful slug fallback")
  - Frontend: `24cafca` ("BP-33 review fix: Support custom subject entry, auth guard selling flow, and old course warning pill")
- **Final Verification**:
  - Backend: `npm test` -> 7 test files, 24 passed (0 failures). `npm run lint` & `npm run format:check` -> passed.
  - Frontend: `npm test` -> 8 test files, 17 passed (0 failures). `npx tsc --noEmit` -> passed (0 errors). `npm run build` -> passed.

## Status
status: reviewed and verified, ready for PRs
