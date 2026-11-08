# Slice 05: Academic Detail View & Curriculum Recommendations

## 1. Goal and Behaviour
Enhance the Book Detail page (`/book/[id]`) so that academic textbooks display a clean Academic Details card (Class, Subject, Board, Syllabus version, Markings status) with academic breadcrumbs, and restrict "Related Books" recommendations to other textbooks from the same curriculum rather than fiction/novels.

## 2. Why it is Vertical
Touches all layers:
- Backend: Update `bookService.getBookById` to return academic joined fields (`class_name`, `class_slug`, `subject_name`, `subject_slug`, `curriculum_board`, `syllabus_type`, `markings_status`), and update `bookService.getRelatedBooks` to recommend same class/subject academic books when `is_academic = true`.
- Frontend: Update `app/book/[id]/page.tsx` with `AcademicDetailsCard`, curriculum breadcrumb, and curriculum-aware related books section.
- Automated tests: Backend integration test for related academic books; frontend component test for academic details display.

## 3. Exact Files to Create / Modify

### `bookpasal_backend`:
- `src/models/bookModal.js` (MODIFY: include academic joins in `getBookWithDetails` and curriculum matching in `getRelatedBooks`)
- `src/services/bookService.js` (MODIFY: pass academic criteria to related books)
- `tests/integration/academicBookDetails.test.js` (NEW test)

### `bookpasal_frontend`:
- `app/book/[id]/page.tsx` (MODIFY: render AcademicDetailsCard & breadcrumbs when `is_academic === true`)
- `app/book/[id]/components/AcademicDetailsCard.tsx` (NEW component)
- `tests/components/AcademicBookDetail.test.tsx` (NEW test)

## 4. First Failing Test to Write
- **File**: `bookpasal_backend/tests/integration/academicBookDetails.test.js`
- **Test Name**: `GET /api/books/:id returns full academic taxonomy and student fields`
- **What it asserts**: Requests an academic book by ID and asserts `res.body.data.is_academic === true`, `res.body.data.class_name` is present, `res.body.data.subject_name` is present, and `syllabus_type` is present.

## 5. Further Behaviours to TDD in Order
1. Assert `GET /api/books/:id/related` for an academic book only returns academic books from the same class or subject.
2. Frontend: Assert `AcademicDetailsCard` renders Syllabus status ("Current Syllabus") and Markings status ("Clean / No Markings").

## 6. Commands to Run Tests & Full Suite
- Backend slice tests: `npm -C bookpasal_backend test -- tests/integration/academicBookDetails.test.js`
- Backend full suite: `npm -C bookpasal_backend test`
- Frontend slice tests: `npm -C bookpasal_frontend test -- tests/components/AcademicBookDetail.test.tsx`
- Frontend typecheck & lint: `npm -C bookpasal_frontend run type-check && npm -C bookpasal_frontend run lint`

## 7. Browser Check (Mobile Viewport: 480px × 1050px)
1. Open mobile browser at 480×1050 to `/book/[academicBookId]`.
2. Verify academic breadcrumb: `Home > Education > Class 10 > Science`.
3. Verify Academic Details Card displays cleanly without clutter.
4. Verify related books show other Class 10 textbooks.
5. Capture screenshot to `evidence/slice-05-academic-detail.png`.

## 8. Done Criteria
- Academic book details display all curriculum info and student purchase indicators.
- Related books only recommend relevant academic books.
- Mobile layout is clean, legible, and uncluttered.
- All tests, lint, and typechecks pass.

## 9. Risks or Open Decisions
- None.

