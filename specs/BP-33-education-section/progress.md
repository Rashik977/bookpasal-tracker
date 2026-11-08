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

## Comprehensive Feedback Overhaul & Polish (Round 1 & Round 2)
- **Feedback Addressed**:
  - Maintained BookPasal identity: standard `HomeTopBar` (with logo, notifications, cart, profile), brand orange `#f97316`, PWA install banner, Push notification banner.
  - Replaced dark green tones with ambient warm scholastic canvas (`bg-[#fcf9f2]`) and fluid micro-transitions.
  - Fixed backend tests failing in CI by adding automatic seeding in `tests/setup.js` and individual test suite `beforeAll` hooks.
  - Partitioned collections: added `.whereNotExists` on `is_academic = true` books in `getFeaturedCollections()` and `searchCollections()` to strictly prevent academic collections from leaking into the general home tab or general search results.
  - Created `seed:load:academic` (`scripts/seed-load-academic.js`) seeding 60 academic books across School, +2, and University and 6 academic collections.
  - Fixed Level Pills placement & jumping: Moved level pills inside `HomeTopBar` directly under search with identical height, padding (`px-4 py-2`), brand orange active state, and right-edge gradient fade (`from-background to-transparent w-16`).
  - Overhauled `FilterModal` for Academic: Mirror categories with Curriculum Level pills, dynamically filtered Class/Stream and Subject selectors from taxonomy, Material Type, and Price Range; removed Syllabus Version and Markings Inside.
  - MUI-style Autocomplete for Class and Subject: Created `MuiAutocomplete` allowing typing and dropdown suggestions with instant selection or custom entry directly in the same text box without needing secondary inputs.
  - Two-Card Sell Selection Hub: Turned `/sell` into a dedicated 2-card landing screen (`Literature & General` -> `/sell/general` vs `Academic & Textbooks` -> `/sell/academic`), completely removing camera scanner auto-pop on mount.
  - Academic Collection Bundling: Implemented `AcademicBookAccordion` with multi-book accordion support and integrated `CollectionSection` on `/sell/academic`, allowing sellers to bundle 2+ academic books into an academic course bundle with discount and publishing atomically via `POST /api/listing`.
- **Commits**:
  - Backend:
    - `da936c7` ("BP-33: Fix test setup seeds and prevent academic collections from leaking into general feed")
    - `414a529` ("BP-33: Add seed-load-academic script for 60+ books and multiple academic collections")
  - Frontend:
    - `3fae532` ("BP-33: Complete rework of Education header, filters, MUI Autocomplete, and Sell hub with collection support")
- **Final Verification**:
  - Backend: `npm test` -> 7 test files, 26 tests passed (100% pass rate). `npm run lint` & `npm run format:check` -> passed (0 errors).
  - Frontend: `npm test` -> 8 test files, 16 tests passed (100% pass rate). `npm run build` -> passed (Next.js production build succeeded). `npm run format:check` & `npm run lint` -> passed (0 errors).
  - Mobile Browser Verification: Captured at 480×1050 viewport with all 5 BottomNav items visible and verified real seed data for `education_hub_mobile.png`, `sell_selection_mobile.png`, and `sell_academic_mobile.png`.

  - Replaced crowded pill rows with a single clean pill strip (`[ All Levels ]  [ School ]  [ +2 High School ]  [ University / Bachelors ]`) in brand orange with zero emojis.
  - Added Academic Collections & Bundles carousel alongside Academic Textbooks in the feed with standard pagination.
  - Connected search-adjacent `FilterModal` with academic filters (Material Type, Syllabus Version, Markings Status).
  - Overhauled `/sell`: eliminated auto-camera scanner popup on mount; introduced clean two-card choice UI (`Literature & General` vs `Academic & Textbooks`).
  - Added searchable single-select class autocomplete with custom class option. Added comprehensive Nepal syllabus seeds (all Grades 1–10, +2 streams, top 19 Bachelor/Master degrees, official CDC/NEB/TU subjects).
  - Enforced strict `react-hook-form` validation with inline error messages under fields, mandatory subject selection, BS edition year (`2081`), and removed negotiable price checkbox.
  - Fixed `BookCard`: defaulted `originalPrice = ""` eliminating unwanted discount badges and strikethrough prices; neutralized academic badges.
  - Fixed wishlist reactive update: added `queryClient.invalidateQueries({ queryKey: ["education"] })` for instantaneous heart fill state.
- **Overhaul Commits**:
  - Backend:
    - `a1195f3` ("BP-33 slice 5: academic collections integration and expanded curriculum taxonomy")
    - `3b0f143` ("BP-33: update test expectation for BS edition year in academic book details test")
  - Frontend:
    - `46075b8` ("BP-33 slice 6: complete frontend education hub and sell flow overhaul")
    - `459e2a1` ("BP-33: add is_locked to HomeCollectionItem type")
    - `36725da` ("BP-33: add notes to AcademicType union in frontend")
    - `1873730` ("BP-33: default originalPrice to empty string and re-style academicBadge in BookCard")
- **Final Verification**:
  - Backend: `npm test` -> 7 test files, 25 passed. `npm run lint` & `npm run format:check` -> 0 errors.
  - Frontend: `npm test` -> 8 test files, 16 passed. `npm run build` -> production build succeeded. `npm run lint` & `npm run format:check` -> 0 errors.
  - Mobile Browser Check: Verified at 480×1050 viewport with all 5 BottomNav items visible and real seed data.
- **PRs**:
  - Backend PR: https://github.com/prashantmgk/bookpasal_backend/pull/19
  - Frontend PR: https://github.com/prashantmgk/bookpasal_frontend/pull/18

## Status
status: overhaul complete, verified, PRs updated and ready for review
