# BP-33: Decisions

| # | Date | Decision | Rationale | Alternatives Considered |
|---|------|----------|-----------|-------------------------|
| 1 | 2026-11-08 | 3-tier Nepali curriculum taxonomy: Level/Stream, Class/Semester, Subject | Reflects real Nepal student lifecycle (School 1-10, +2 NEB, University/Bachelors like IOE/CSIT/BBA/BBS) | Flat tags or free-text inputs |
| 2 | 2026-11-08 | Separate sell & browse flows for Academic books from regular novels | Academic books have unique attributes (Board, Grade, Subject, Edition/Curriculum Year) and buyers search strictly by curriculum, not author/fiction genre | Mixing academic books into general fiction listing forms and search |
| 3 | 2026-11-08 | Dedicated `/sell/academic` route with curriculum-specific step wizard | Gives students a dedicated, tailored form (Level -> Grade -> Subject -> Board/Edition) without novel clutter | Single polymorphic `/sell` with dynamic toggles |
| 4 | 2026-11-08 | Normalized `academic_classes` and `academic_subjects` tables + FKs on `books` | Enables fast taxonomy caching, clean cascading UI, and SEO slugs without free-text mess, backwards compatible | Flat string columns on `books` table |
| 5 | 2026-11-08 | Strict search partitioning via `is_academic` | General search only returns `is_academic: false` books so novels/literature aren't cluttered with textbooks; `/education` hub has dedicated academic search & filters | Combined mixed search results with badge filters |
| 6 | 2026-11-08 | Minimalist, fluid Mode Toggle with dynamic identity & theme shift | Smooth animated toggle between General (warm parchment/amber) and Academic (deep scholastic navy/emerald/gold tone) without giant cards or feed clutter | Heavy hero banners or separate disjointed apps |
| 7 | 2026-11-08 | Clutter-free Academic BookCard | Sleek, single subtle badge (e.g. `Class 10` or `Class 12 Science`) preserving clean visual hierarchy | Multiple text blocks and noisy tags |
| 8 | 2026-11-08 | Student-centric academic attributes: `academic_type` (Textbook, Guide, Question Bank), `syllabus_type` (Current Syllabus, Old Course), `markings_status` (Clean, Pencil, Pen/Highlighted) | Directly answers Nepal students' top purchase criteria without messaging back-and-forth | Generic condition text description only |
| 9 | 2026-11-08 | Strict architectural pattern preservation (CVA, react-hook-form, TanStack Query, Joi, Knex) | Follows existing code conventions in both repos without introducing foreign idioms or boilerplate | Reinventing form or styling patterns |
| 10 | 2026-11-08 | In-scope vs Out-of-scope perimeter locked | Prevents scope creep (bulk institutional orders and PDF downloads deferred) while delivering full consumer educational marketplace | Unbounded feature additions |









