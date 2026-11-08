# BP-33: Questions & Answers

### Q1: Education Taxonomy & Curriculum Scope
- **Question**: What levels/grades and subject structure should we support for the Nepali curriculum?
- **Answer**: 3-tier hierarchy: School (Class 1-10 / SEE), +2 High School (Class 11-12 Science/Management/Humanities/Law), University/Bachelor (TU/KU/PU: IOE Engineering, BSc CSIT, BCA, BBA/BBS, Medical). In addition, separate the selling and viewing flow of academic books so they don't get mixed up with regular novel/fiction listings.

### Q2: Academic Listing (Seller) Experience
- **Question**: How should sellers select the academic flow when listing, and how should the form adapt?
- **Answer**: Dedicated academic selling section/route (`/sell/academic`) with tailored fields: Level/Stream, Class/Semester, Subject, Board/Curriculum, and Syllabus/Edition Year, rather than novel genres or mandatory authors.

### Q3: Database Model & Taxonomy Architecture
- **Question**: How should the academic taxonomy and book relationships be structured in the database?
- **Answer**: Normalized tables `academic_classes` and `academic_subjects` with `is_academic`, `academic_class_id`, `academic_subject_id`, `curriculum_board`, and `edition_year` added to `books`.

### Q4: Education Browse Pages & URL Routing
- **Question**: How should buyers discover and browse academic books, and what should the URL structure look like for SEO?
- **Answer**: Prominent "Education" banner/pill on Home; dedicated `/education` hub with Level tabs (School, +2, University) and Class/Subject chips; SEO-friendly dynamic routes (`/education`, `/education/[classSlug]`, `/education/[classSlug]/[subjectSlug]`) with rich metadata, reusing the shared `BookCard` grid.

### Q5: Clean Separation of Search, Listing & Details (Partitioning)
- **Question**: How will the clean separation between General Books and Academic Books work across Search, Browsing, and Listing?
- **Answer**: 
  - Partitioning on `is_academic`: Home search and browse only fetch `is_academic: false` books to keep novels clean.
  - Dedicated `/education` hub has its own search and filters querying `is_academic: true`.
  - Dedicated `/sell/academic` listing wizard specifically tailored for textbooks.
  - Book detail page displays academic badges, breadcrumb, and related textbooks from the same curriculum.

### Q6: Student-Centric Listing Details (Nepal Context UX)
- **Question**: Should we include academic-specific attributes for book type, syllabus, and marking status?
- **Answer**: Yes. Include:
  - `academic_type`: Textbook, Guide / Solution Manual, Model Questions / Question Bank
  - `syllabus_type`: Current Syllabus (New Course), Old Course
  - `markings_status`: Clean / No Markings, Pencil Underlined, Pen Notes / Highlighted

### Q7: Visual Identity & Clutter-Free UX
- **Question**: How should the transition between General and Academic be styled without cluttering the UI?
- **Answer**:
  - No giant cards on Home.
  - A sleek, animated toggle in the top bar that smoothly shifts the visual theme and identity of the page between General (warm bookish parchment) and Academic (scholastic palette with smooth CSS transition).
  - Keep `BookCard` clean: a single subtle pill badge (e.g. `Class 10` or `Class 12`) without clutter.
  - Sell flow split cleanly into two flows preserving existing patterns (CVA, react-hook-form, TanStack Query, Joi, Knex).

### Q8: Boundaries & Scope Clarification
- **Question**: Are the proposed in-scope and explicitly out-of-scope items approved?
- **Answer**: Yes. In-scope covers database migrations, seed data for Nepali curriculum, backend taxonomy & search endpoints, frontend animated mode switcher with theme transition, dedicated `/education` hub + SEO dynamic routes, streamlined `/sell/academic` form, and academic book details. Out-of-scope covers PDF downloads, institutional school portals, and bottom nav changes.










