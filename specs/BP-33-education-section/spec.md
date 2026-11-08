# BP-33: Education Section Specification

## 1. Goal
Provide a dedicated, clutter-free Academic & Education marketplace inside BookPasal for Nepali students and sellers. It features a complete Nepali curriculum taxonomy (School Grades 1–10, +2 High School, University/Bachelors), clean partitioning between general novels and academic textbooks, dedicated listing and browse flows, an animated Mode Switcher with a dynamic theme shift, and SEO-friendly curriculum pages.

---

## 2. User Stories
- **As a Student / Buyer**, I want to browse books strictly by my Level, Class, and Subject (e.g., Class 10 Math, Class 12 Science Physics) so that I can instantly find the exact textbook I need without wading through fiction novels.
- **As a Student / Buyer**, I want to clearly see the syllabus version (Current Syllabus vs Old Course) and marking status (Clean vs Pen notes) so that I don't need to ask the seller repetitive questions before buying.
- **As a Student / Seller**, I want a streamlined listing form (`/sell/academic`) that asks for Class, Subject, Board, and Syllabus Year instead of irrelevant novel genres or mandatory author names.
- **As a Regular Reader**, I want searching for "Physics" or "Fiction" on the main home search to not be flooded by grade-school curriculum textbooks, keeping my reading discovery clean.

---

## 3. Behaviours (Given / When / Then)

### 3.1 Taxonomy Retrieval & Theme Switch
- **Given** a user is on the Home page,
  **When** they view the header,
  **Then** they see a sleek Mode Switcher (`[ 📚 General ] [ 🎓 Academic ]`).
- **Given** the user taps `[ 🎓 Academic ]`,
  **When** the switch occurs,
  **Then** the page transitions smoothly to the Academic theme and loads the Education Hub (`/education`).
- **Given** the client requests `GET /api/education/taxonomy`,
  **When** the request succeeds,
  **Then** it returns the structured 3-tier hierarchy (`school`, `plus_two`, `bachelors`) with all classes and subjects.

### 3.2 Partitioned Search
- **Given** a user searches on the General Home top bar (`GET /api/books/search?q=...`),
  **When** results are returned,
  **Then** only books with `is_academic = false` are included.
- **Given** a user searches inside the Education section (`GET /api/education/books?q=...`),
  **When** results are returned,
  **Then** only books with `is_academic = true` are included.

### 3.3 Academic Listing
- **Given** an authenticated seller accesses `/sell`,
  **When** they choose "Academic & Textbooks",
  **Then** they are routed to `/sell/academic`.
- **Given** a seller on `/sell/academic` selects a Level (e.g. `+2 High School`),
  **When** Level is selected,
  **Then** the Class dropdown cascades to relevant classes (`Class 11 - Science`, `Class 12 - Management`, etc.).
- **Given** a Class is selected,
  **When** Subject dropdown is opened,
  **Then** only subjects for that class are shown, with an "Other / Custom" option.
- **Given** all required fields are filled (`title`, `academic_class_id`, `academic_subject_id`, `condition`, `price`, `images`),
  **When** the seller submits,
  **Then** the book is saved with `is_academic: true` and all curriculum metadata.

### 3.4 Education Browse & Filter
- **Given** a buyer visits `/education`,
  **When** the page renders,
  **Then** it displays Level tabs, Class chips, Subject chips, and a responsive grid of `BookCard` components.
- **Given** a buyer taps "Class 10" and "Science",
  **When** the filter updates,
  **Then** only Class 10 Science books are fetched and rendered.
- **Given** a buyer visits a direct URL `/education/class-10` or `/education/class-10/science`,
  **When** the page loads,
  **Then** the filters are automatically initialized and Next.js sets SEO title and meta tags.

### 3.5 Academic Book Details
- **Given** a user visits `/book/[id]` where `is_academic: true`,
  **When** the page renders,
  **Then** it displays an Academic Badge bar (Grade, Subject, Board, Syllabus version, Markings), academic breadcrumbs (`Home > Education > Class 10 > Science`), and recommends other books from that same grade/subject.

---

## 4. Data Model Changes

### 4.1 New Table: `academic_classes`
| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PRIMARY KEY, default uuid_generate_v4() | Class identifier |
| `level` | VARCHAR(50) | NOT NULL, INDEX | 'school', 'plus_two', 'bachelors' |
| `name` | VARCHAR(100) | NOT NULL | e.g. "Class 10", "Class 12 - Science" |
| `slug` | VARCHAR(100) | NOT NULL, UNIQUE, INDEX | e.g. "class-10", "class-12-science" |
| `display_order` | INT | NOT NULL DEFAULT 0 | Sorting order |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Audit timestamp |

### 4.2 New Table: `academic_subjects`
| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PRIMARY KEY, default uuid_generate_v4() | Subject identifier |
| `class_id` | UUID | NOT NULL, REFERENCES academic_classes(id) ON DELETE CASCADE, INDEX | Parent class |
| `name` | VARCHAR(100) | NOT NULL | e.g. "Compulsory Mathematics" |
| `slug` | VARCHAR(100) | NOT NULL, INDEX | e.g. "compulsory-mathematics" |
| `display_order` | INT | NOT NULL DEFAULT 0 | Sorting order |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Audit timestamp |

### 4.3 Table Alteration: `books`
| Column | Type | Constraints | Default | Description |
|---|---|---|---|---|
| `is_academic` | BOOLEAN | NOT NULL, INDEX | `false` | Distinguishes academic textbooks from novels |
| `academic_class_id` | UUID | NULLABLE, REFERENCES academic_classes(id), INDEX | `NULL` | Grade/Class foreign key |
| `academic_subject_id` | UUID | NULLABLE, REFERENCES academic_subjects(id), INDEX | `NULL` | Subject foreign key |
| `curriculum_board` | VARCHAR(100) | NULLABLE | `NULL` | e.g. "CDC", "NEB", "TU", "Other" |
| `edition_year` | VARCHAR(50) | NULLABLE | `NULL` | e.g. "2080 / 2023" |
| `academic_type` | VARCHAR(50) | NULLABLE | `NULL` | 'textbook', 'guide', 'question_bank' |
| `syllabus_type` | VARCHAR(50) | NULLABLE | `NULL` | 'current_syllabus', 'old_course' |
| `markings_status` | VARCHAR(50) | NULLABLE | `NULL` | 'clean', 'pencil', 'pen_notes' |

---

## 5. API Contracts

### 5.1 `GET /api/education/taxonomy`
- **Auth**: Public (`optionalAuth`)
- **Query**: None (or optional `?level=school`)
- **Response 200**:
```json
{
  "success": true,
  "message": "Education taxonomy fetched successfully",
  "data": [
    {
      "id": "uuid",
      "level": "school",
      "name": "Class 10",
      "slug": "class-10",
      "display_order": 10,
      "subjects": [
        {
          "id": "uuid",
          "name": "Compulsory Mathematics",
          "slug": "compulsory-mathematics",
          "display_order": 1
        }
      ]
    }
  ]
}
```

### 5.2 `GET /api/education/books`
- **Auth**: Public (`optionalAuth`)
- **Query Parameters**:
  - `q`: string (optional search term)
  - `level`: string (optional: `school`, `plus_two`, `bachelors`)
  - `classId` / `classSlug`: string (optional)
  - `subjectId` / `subjectSlug`: string (optional)
  - `academicType`: string (optional: `textbook`, `guide`, `question_bank`)
  - `syllabusType`: string (optional: `current_syllabus`, `old_course`)
  - `page`: integer (default 1)
  - `limit`: integer (default 15)
- **Response 200**:
```json
{
  "success": true,
  "message": "Academic books fetched successfully",
  "data": {
    "books": [
      {
        "id": "uuid",
        "title": "Compulsory Mathematics Class 10",
        "price": 250,
        "is_academic": true,
        "class_name": "Class 10",
        "subject_name": "Compulsory Mathematics",
        "curriculum_board": "CDC Nepal",
        "syllabus_type": "current_syllabus",
        "markings_status": "clean",
        "image_urls": ["https://..."]
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 15,
      "total": 42,
      "totalPages": 3
    }
  }
}
```

### 5.3 Updates to `POST /api/books` & `POST /api/listing`
- Joi validation schema extended:
  - If `is_academic: true`:
    - `academic_class_id`: Joi.string().uuid().required()
    - `academic_subject_id`: Joi.string().uuid().optional().allow(null)
    - `curriculum_board`: Joi.string().max(100).optional().allow("", null)
    - `edition_year`: Joi.string().max(50).optional().allow("", null)
    - `academic_type`: Joi.string().valid("textbook", "guide", "question_bank").optional()
    - `syllabus_type`: Joi.string().valid("current_syllabus", "old_course").optional()
    - `markings_status`: Joi.string().valid("clean", "pencil", "pen_notes").optional()
    - `genre`: optional (defaults to "Academic & Textbooks")
  - If `is_academic: false` (or undefined):
    - Continues existing behavior requiring standard `genre`.

---

## 6. UI Behaviour & Mobile Viewport Mandate
- **Viewport**: Strictly verified at **480px × 1050px** on mobile.
- **Mode Switcher**: Sleek segmented toggle in `HomeTopBar` with smooth theme transition.
- **Loading State**: Subtle Skeleton cards for `BookCard` matching existing `BookCardSkeleton`.
- **Empty State**: Clear, friendly message: *"No books listed yet for Class 10 Science. Be the first student to sell one!"* with a direct CTA to `/sell/academic`.
- **Error State**: Graceful retry banner in case of network drops.

---

## 7. Permissions & Auth
- **Browsing & Search**: Public for all guests and authenticated users.
- **Selling (`/sell`, `/sell/academic`)**: Protected route; unauthenticated users prompted with `AuthModal`.
- **Cart & Ordering**: Handled through standard existing order pipeline.

---

## 8. Edge Cases
- **Deleted or Non-existent Class/Subject**: Gracefully fall back to all academic books without throwing 404 or crashing UI.
- **Custom / Unlisted Subject**: Seller can enter subject manually if not found in pre-seeded list.
- **Old Course / Discontinued Syllabus**: Clearly flagged with a warning pill so buyers know it's not the new curriculum.
- **Mobile horizontal scroll**: Class and Subject chips smoothly scroll horizontally without breaking screen width or causing overflow.

---

## 9. Out of Scope
- School syllabus PDF readers / syllabus document viewer.
- School/college partnership bulk checkout or institutional accounts.
- BottomNav layout alterations (5-item bar stays unchanged).

---

## 10. Test Strategy
- **Backend Integration Tests**: Real local PostgreSQL (`bookpasal_test`). Tests for:
  - Seeding and fetching taxonomy (`GET /api/education/taxonomy`).
  - Filtering books by curriculum (`GET /api/education/books`).
  - Validating and creating academic books (`POST /api/books`).
  - Strict partitioning of general search (`is_academic: false`).
- **Frontend Component / Unit Tests**:
  - Mode Switcher theme shift and taxonomy query.
  - Form validation for `/sell/academic` cascading dropdowns.
  - Education Hub filter chips and dynamic SEO routes.
- **Browser Mobile Verification**:
  - Headless browser verification at 480×1050 with real backend data, saving screenshots to `evidence/`.

---

## 11. Manual Test Checklist for Rashik
1. Open Home page at 480px width: verify `Mode Switcher` is visible and cleanly styled.
2. Toggle to "Academic": verify smooth visual theme shift and navigation to Education Hub.
3. Verify Class & Subject chips filter textbooks with real data.
4. Navigate to `/sell`: verify selection between General Book and Academic Book.
5. In `/sell/academic`, verify selecting a Level populates relevant Classes and Subjects.
6. Submit an academic book listing and verify it appears in the Education Hub.
7. Click the created academic book: verify academic badges (Class, Subject, Syllabus, Markings) and related academic recommendations.
8. Go back to General Home: verify the academic book is NOT mixed into general fiction searches.

---

## 12. Autonomy Contract
The build agent may autonomously decide:
1. Exact styling classes and CSS transitions adhering to BookPasal's design tokens and theme.
2. Seed curriculum subject lists for standard Nepali grades (CDC Grades 1–10, +2 NEB Science/Management, TU Bachelor courses).
3. Query parameter naming conventions matching existing TanStack query keys.

What counts as a real blocker requiring Rashik's input:
1. Database migration conflicts that cannot be cleanly applied to existing tables.
2. Breaking API changes affecting existing production routes.
3. Third-party API failures requiring secret credentials.
4. Unresolvable schema ambiguities not covered in this spec.
5. Three consecutive failed fixes on the same test/build command.

