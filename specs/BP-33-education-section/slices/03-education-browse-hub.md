# Slice 03: Education Browse Hub (`/education`) with Curriculum Filters

## 1. Goal and Behaviour
Deliver the dedicated Education Browse Hub (`/education`) with Level tabs (School, +2 High School, Bachelors/University), horizontal Class & Subject chips, academic keyword search, and a clutter-free `BookCard` grid displaying a subtle academic badge without overwhelming details.

## 2. Why it is Vertical
Touches all layers:
- Backend: Endpoint `GET /api/education/books` supporting level, class, subject, search query, and pagination filtering on `is_academic = true`.
- Frontend: Full `/education` page with interactive filter state, React Query integration, clean responsive BookCards, loading skeletons, and empty states.
- Automated tests: Integration test for academic book filtering; frontend page test for filter chip interactions.

## 3. Exact Files to Create / Modify

### `bookpasal_backend`:
- `src/controllers/educationController.js` (MODIFY: implement `getAcademicBooks`)
- `src/services/educationService.js` (MODIFY: query builder for academic books)
- `src/validators/educationValidator.js` (NEW validator for academic book query)
- `src/routes/educationRoutes.js` (MODIFY: add `GET /books` route)
- `tests/integration/educationBooks.test.js` (NEW test)

### `bookpasal_frontend`:
- `app/education/page.tsx` (NEW page: Education Browse Hub)
- `app/education/components/EducationHeader.tsx` (NEW component)
- `app/education/components/LevelTabs.tsx` (NEW component)
- `app/education/components/ClassSubjectChips.tsx` (NEW component)
- `features/listbooks/components/BookCard.tsx` (MODIFY: support subtle `academicBadge` prop)
- `server/queries/fetchEducation.ts` (MODIFY: add `useFetchAcademicBooks`)
- `tests/components/EducationHub.test.tsx` (NEW test)

## 4. First Failing Test to Write
- **File**: `bookpasal_backend/tests/integration/educationBooks.test.js`
- **Test Name**: `GET /api/education/books returns 200 with paginated academic books only`
- **What it asserts**: Sends a GET request to `/api/education/books`, asserts `res.status === 200`, and verifies every returned book has `is_academic === true`.

## 5. Further Behaviours to TDD in Order
1. Assert `GET /api/education/books?classId=...` filters books by class.
2. Assert `GET /api/education/books?subjectId=...` filters books by subject.
3. Frontend: Assert tapping a Class chip triggers query update with that class ID.

## 6. Commands to Run Tests & Full Suite
- Backend slice tests: `npm -C bookpasal_backend test -- tests/integration/educationBooks.test.js`
- Backend full suite: `npm -C bookpasal_backend test`
- Frontend slice tests: `npm -C bookpasal_frontend test -- tests/components/EducationHub.test.tsx`
- Frontend typecheck & lint: `npm -C bookpasal_frontend run type-check && npm -C bookpasal_frontend run lint`

## 7. Browser Check (Mobile Viewport: 480px × 1050px)
1. Open mobile browser at 480×1050 to `http://localhost:3000/education`.
2. Tap Level: `School (1-10)`.
3. Tap Class chip: `Class 10`.
4. Tap Subject chip: `Compulsory Mathematics`.
5. Verify BookCards display clean `Class 10` badges and correct prices in NPR.
6. Capture screenshot to `evidence/slice-03-education-hub.png`.

## 8. Done Criteria
- `GET /api/education/books` correctly filters by level, class, subject, and keyword.
- `/education` renders smoothly on mobile with fast interactive chip filtering.
- BookCards remain clean and legible.
- All tests, lint, and typechecks pass.

## 9. Risks or Open Decisions
- None.

