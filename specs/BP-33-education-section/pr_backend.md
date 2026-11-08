## Summary
Introduces the backend curriculum taxonomy, academic book partitioning, dedicated academic book creation, academic collections bundle aggregation, and comprehensive Nepal school, +2, and university syllabi seeds.

## Slices & Changes
- **Slice 01 - Taxonomy & Partitioning**: Added PostgreSQL migration for `academic_classes`, `academic_subjects`, and academic book flags (`is_academic`, `class_id`, `subject_id`, `curriculum_board`, `edition_year`, `academic_type`, `syllabus_type`, `markings_status`). Added `GET /api/education/taxonomy` and partitioned general book search/feed queries to exclude academic books.
- **Slice 02 - Academic Book Listing Flow**: Implemented `POST /api/education/books` with validation for academic curriculum attributes, auto-setting `is_academic = true` and `category_id = 'education'`.
- **Slice 03 - Education Browse & Feed**: Implemented `GET /api/education/books` supporting level, class, subject, material type, syllabus version, and markings filters with pagination.
- **Slice 04 - SEO & Slug Resolution**: Implemented `GET /api/education/resolve/:classSlug` and `GET /api/education/resolve/:classSlug/:subjectSlug` returning IDs, names, and metadata for dynamic curriculum routes.
- **Slice 05 - Academic Details & Collections**: Extended `GET /api/books/:id` with taxonomy joins and curriculum-restricted related books (`/api/books/:id/related`). Extended `GET /api/education/books` to include academic bundles (`collections`) alongside books with pagination.
- **Overhaul & Feedback Polish**: Seeded complete Grade 1–10 classes, +2 streams, and top 19 Bachelor/Master degrees with official CDC/NEB/TU subjects; added SEE complete set collection seed; pure BS edition year validation (`2081`).

## Verification
- Tests: `npm test` -> PASS (7 test files, 25 tests passed)
- Lint: `npm run lint` -> PASS (0 errors, 0 warnings)
- Format Check: `npm run format:check` -> PASS (0 errors)

## How to Test
1. Run `npm run seed:dev` to ensure development database has the full curriculum taxonomy and test books.
2. Query `GET /api/education/taxonomy` -> Verify 3 curriculum levels (school, plus_two, bachelors), all grades 1–10, +2 streams, and bachelor degrees with subjects.
3. Query `GET /api/education/books` -> Verify `{ books, collections, pagination }` structure with academic collections returned.
4. Query `GET /api/books/66666666-6666-4666-8666-666666666601` -> Verify academic details and BS edition year `2081`.

## Decisions & Trade-offs
- Reused core `books` and `collections` tables without creating parallel tables or breaking changes to existing models.
- Collections in education feed return locked/unlocked state and bundle book cover arrays matching the existing BookPasal feed schema.

Refs Rashik977/bookpasal-tracker#33
