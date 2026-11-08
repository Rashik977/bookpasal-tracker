# Slice 02: Academic Book Listing Flow (`/sell/academic`)

## 1. Goal and Behaviour
Allow verified sellers to list academic textbooks through a dedicated, streamlined wizard (`/sell/academic`) that captures curriculum fields (`academic_class_id`, `academic_subject_id`, `curriculum_board`, `edition_year`, `academic_type`, `syllabus_type`, `markings_status`) using React Hook Form & CVA, accessible via an intuitive selection screen on `/sell`.

## 2. Why it is Vertical
Touches all layers:
- Database migration: adds foreign keys and student-centric columns to `books`.
- Backend validator & service: updates `bookCollectionvalidator.js` and `listingValidator.js` to validate academic payloads when `is_academic: true`, and updates `bookService.js` to persist all curriculum fields.
- Frontend UI: `/sell` choice screen (General vs Academic) and `/sell/academic` multi-step form with cascading Class -> Subject selectors, syllabus status, and clean photo upload.
- Automated tests: Backend integration test for academic book creation; frontend form unit tests.

## 3. Exact Files to Create / Modify

### `bookpasal_backend`:
- `migrations/20261108160000_add_academic_fields_to_books.js` (NEW migration)
- `src/validators/bookCollectionvalidator.js` (MODIFY: support academic fields in createBook schema)
- `src/services/bookService.js` (MODIFY: save academic fields in `createBook`)
- `tests/integration/createAcademicBook.test.js` (NEW test)

### `bookpasal_frontend`:
- `app/sell/page.tsx` (MODIFY: show choice between General and Academic book listing)
- `app/sell/academic/page.tsx` (NEW page: dedicated academic listing wizard)
- `app/sell/academic/components/AcademicStepDetails.tsx` (NEW component)
- `app/sell/academic/components/AcademicStepSyllabus.tsx` (NEW component)
- `app/sell/academic/types/academicSell.types.ts` (NEW types)
- `server/mutations/academicBookMutations.ts` (NEW mutation hook)
- `tests/components/AcademicSellForm.test.tsx` (NEW test)

## 4. First Failing Test to Write
- **File**: `bookpasal_backend/tests/integration/createAcademicBook.test.js`
- **Test Name**: `POST /api/books with is_academic=true successfully creates an academic textbook`
- **What it asserts**: Sends an authenticated POST request with `is_academic: true`, valid `academic_class_id`, `academic_subject_id`, `syllabus_type: "current_syllabus"`, and asserts `res.status === 201`, `res.body.data.is_academic === true`, and the academic fields match the payload.

## 5. Further Behaviours to TDD in Order
1. Assert `POST /api/books` fails with 400 when `is_academic: true` but `academic_class_id` is missing.
2. Assert `POST /api/books` accepts optional student fields (`markings_status`, `academic_type`, `edition_year`).
3. Frontend: Assert cascading Class selection fetches and populates relevant Subjects.

## 6. Commands to Run Tests & Full Suite
- Backend slice tests: `npm -C bookpasal_backend test -- tests/integration/createAcademicBook.test.js`
- Backend full suite: `npm -C bookpasal_backend test`
- Frontend slice tests: `npm -C bookpasal_frontend test -- tests/components/AcademicSellForm.test.tsx`
- Frontend typecheck & lint: `npm -C bookpasal_frontend run type-check && npm -C bookpasal_frontend run lint`

## 7. Browser Check (Mobile Viewport: 480px × 1050px)
1. Log in as a seller on mobile viewport (480×1050).
2. Navigate to `/sell`.
3. Tap "Academic & Textbooks".
4. Fill Level: `+2 High School`, Class: `Class 11 - Science`, Subject: `Physics`.
5. Select `Current Syllabus`, `Clean`, enter price and upload book photos.
6. Submit form and verify successful redirect/confirmation.
7. Capture screenshot to `evidence/slice-02-academic-sell.png`.

## 8. Done Criteria
- Migration applied cleanly.
- `POST /api/books` validates and saves academic textbooks.
- `/sell/academic` functions seamlessly with cascading dropdowns and responsive layout.
- All tests, lint, and typechecks pass.

## 9. Risks or Open Decisions
- None.

