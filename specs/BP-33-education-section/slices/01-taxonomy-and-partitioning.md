# Slice 01: Education Taxonomy Foundation & Strict Partitioning

## 1. Goal and Behaviour
Establish the core database tables (`academic_classes`, `academic_subjects`) seeded with the Nepali curriculum, add `is_academic` to `books`, expose `GET /api/education/taxonomy`, partition general search/home feeds to exclude academic books (`is_academic: false`), and create the frontend animated Mode Switcher with a dynamic theme transition between General and Academic.

## 2. Why it is Vertical
Touches all layers:
- Database migration & seed: creates tables, adds `is_academic` flag to `books`, and seeds Nepali curriculum classes/subjects.
- Backend API: routes, controllers, and services for `GET /api/education/taxonomy`, plus updating `bookModal.js` search and home methods to partition by `is_academic: false`.
- Frontend UI: Mode Switcher in `HomeTopBar.tsx` with smooth CSS transition shifting page identity from General to Academic theme, consuming the taxonomy endpoint via TanStack Query.
- Automated tests: Integration test in backend and component test in frontend.

## 3. Exact Files to Create / Modify

### `bookpasal_backend`:
- `migrations/20261108150000_create_academic_taxonomy_tables.js` (NEW migration)
- `seeds/dev/02_seed_academic_curriculum.js` (NEW seed)
- `src/routes/educationRoutes.js` (NEW route)
- `src/controllers/educationController.js` (NEW controller)
- `src/services/educationService.js` (NEW service)
- `src/models/educationModal.js` (NEW model)
- `src/models/bookModal.js` (MODIFY: partition `search` & `getFeaturedBooks` to `is_academic: false`)
- `src/app.js` (MODIFY: mount `/api/education` router)
- `tests/integration/educationTaxonomy.test.js` (NEW test)

### `bookpasal_frontend`:
- `types/education.ts` (NEW types for taxonomy and academic books)
- `server/queries/fetchEducation.ts` (NEW query hook for `useFetchTaxonomy`)
- `components/ModeSwitcher.tsx` (NEW component)
- `components/HomeTopBar.tsx` (MODIFY: integrate ModeSwitcher and theme shift)
- `tests/components/ModeSwitcher.test.tsx` (NEW test)

## 4. First Failing Test to Write
- **File**: `bookpasal_backend/tests/integration/educationTaxonomy.test.js`
- **Test Name**: `GET /api/education/taxonomy returns 200 with structured curriculum hierarchy`
- **What it asserts**: Sends a GET request to `/api/education/taxonomy` and asserts `res.status === 200`, `res.body.success === true`, and `res.body.data` contains classes with `level`, `name`, `slug`, and `subjects` array.

## 5. Further Behaviours to TDD in Order
1. Assert `GET /api/education/taxonomy?level=school` filters classes by level.
2. Assert `GET /api/books/search` does NOT return books where `is_academic: true`.
3. Frontend: Assert `ModeSwitcher` toggles state and calls navigation or theme setter.

## 6. Commands to Run Tests & Full Suite
- Backend slice tests: `npm -C bookpasal_backend test -- tests/integration/educationTaxonomy.test.js`
- Backend full suite: `npm -C bookpasal_backend test`
- Backend lint: `npm -C bookpasal_backend run lint`
- Frontend slice tests: `npm -C bookpasal_frontend test -- tests/components/ModeSwitcher.test.tsx`
- Frontend typecheck & lint: `npm -C bookpasal_frontend run type-check && npm -C bookpasal_frontend run lint`

## 7. Browser Check (Mobile Viewport: 480px × 1050px)
1. Launch backend and frontend with real seed data.
2. Open mobile browser at 480×1050 to `http://localhost:3000`.
3. Verify `ModeSwitcher` pill is visible at the top without clipping any header elements.
4. Tap `Academic`: observe smooth color/theme shift and transition into academic state.
5. Capture screenshot to `evidence/slice-01-mode-switch.png`.

## 8. Done Criteria
- Migration runs cleanly up and down.
- Seed populates Nepali curriculum (Classes 1–10, +2, Bachelors).
- `GET /api/education/taxonomy` responds with 200 and formatted tree.
- General search ignores academic books.
- Mode switcher renders and animates smoothly on 480px mobile viewport.
- All tests, lint, and typechecks pass.

## 9. Risks or Open Decisions
- None.

