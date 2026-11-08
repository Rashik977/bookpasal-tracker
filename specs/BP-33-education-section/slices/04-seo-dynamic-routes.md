# Slice 04: SEO-Friendly Dynamic Curriculum Routes

## 1. Goal and Behaviour
Provide SEO-optimized dynamic Next.js routes (`/education/[classSlug]` and `/education/[classSlug]/[subjectSlug]`) that render pre-filtered curriculum textbooks, generate rich dynamic metadata (Page Title, OpenGraph, Description), and support deep linking for student queries from Google.

## 2. Why it is Vertical
Touches all layers:
- Backend: `GET /api/education/books` supports `classSlug` and `subjectSlug` directly for slug-based resolution.
- Frontend: Next.js App Router dynamic pages `app/education/[classSlug]/page.tsx` and `app/education/[classSlug]/[subjectSlug]/page.tsx` with dynamic `generateMetadata()`.
- Automated tests: Backend slug-query integration test; frontend route metadata unit test.

## 3. Exact Files to Create / Modify

### `bookpasal_backend`:
- `src/services/educationService.js` (MODIFY: support resolving by classSlug & subjectSlug)
- `tests/integration/educationSlugs.test.js` (NEW test)

### `bookpasal_frontend`:
- `app/education/[classSlug]/page.tsx` (NEW route)
- `app/education/[classSlug]/[subjectSlug]/page.tsx` (NEW route)
- `tests/components/EducationSEO.test.tsx` (NEW test)

## 4. First Failing Test to Write
- **File**: `bookpasal_backend/tests/integration/educationSlugs.test.js`
- **Test Name**: `GET /api/education/books?classSlug=class-10 filters by slug correctly`
- **What it asserts**: Sends GET `/api/education/books?classSlug=class-10` and asserts all returned books belong to Class 10.

## 5. Further Behaviours to TDD in Order
1. Assert `GET /api/education/books?classSlug=class-10&subjectSlug=compulsory-mathematics` filters by both slugs.
2. Frontend: Assert `generateMetadata` produces title containing class and subject names (e.g. "Class 10 Compulsory Mathematics Books | BookPasal").

## 6. Commands to Run Tests & Full Suite
- Backend slice tests: `npm -C bookpasal_backend test -- tests/integration/educationSlugs.test.js`
- Backend full suite: `npm -C bookpasal_backend test`
- Frontend slice tests: `npm -C bookpasal_frontend test -- tests/components/EducationSEO.test.tsx`
- Frontend typecheck & lint: `npm -C bookpasal_frontend run type-check && npm -C bookpasal_frontend run lint`

## 7. Browser Check (Mobile Viewport: 480px × 1050px)
1. Navigate directly to `http://localhost:3000/education/class-10` in mobile viewport.
2. Verify Class 10 chip is pre-selected and relevant textbooks render immediately.
3. Check document head title matches "Class 10 Books & Textbooks - BookPasal".
4. Capture screenshot to `evidence/slice-04-seo-route.png`.

## 8. Done Criteria
- Dynamic routes resolve and render properly.
- Deep links work directly from cold page load.
- Dynamic Next.js metadata is generated.
- All tests, lint, and typechecks pass.

## 9. Risks or Open Decisions
- None.

