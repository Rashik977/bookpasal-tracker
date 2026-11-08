# BP-33 Education Section: Complete Rework Plan & Specification

## 1. Root Cause Analysis & Lessons Learned

### Where We Went Wrong
1. **Fracturing BookPasal Identity ("Green Mini-App Syndrome")**:
   Instead of viewing the Academic section as a filtered lens on BookPasal's core marketplace, we created a separate green-accented sub-app with custom headers (`EducationHeader`), isolated navigation, and custom green colors (`#1b4332`, `bg-green`). This violated BookPasal's core brand identity (BookPasal orange/amber `#e07a5f`, terra `#c85a32`).
2. **Missing Core Shell Infrastructure**:
   By replacing `HomeTopBar` with `EducationHeader`, global shell components (`PWAInstallBanner`, `PushNotificationBanner`, cart badge, profile avatar menu, and `FilterModal`) disappeared or behaved inconsistently.
3. **Disregarding Existing Codebase Patterns in Sell Flow**:
   In `app/sell/page.tsx`, the codebase had a mature, well-tested pattern using `react-hook-form`, inline validation errors under each field (`<Input error={errors.xxx?.message} />`), multi-book accordions, and collection bundling (`CollectionSection`). For `/sell/academic`, we wrote a bespoke `useState` wizard with a banner error at the top, ignoring the existing pattern and completely dropping Collections.
4. **Immediate Camera Popup on Sell Page**:
   `scannerOpenForKey` was initialized to `0`, causing the barcode camera to aggressively hijack the user's screen upon clicking Sell before they even decided what they wanted to sell.
5. **Feed & Cache Isolation**:
   Using isolated query keys (`["education", "books"]`) broke cache invalidation for the wishlist toggle, preventing hearts from updating optimistically and cleanly across the app.
6. **Curriculum Incompleteness & Cluttered UI**:
   - School classes arbitrarily started at Class 8 instead of covering Grade 1 through 10.
   - University classes were limited to only 3 items without search or autocomplete.
   - Class and subject chips were dumped horizontally under the search bar, forcing mobile users to swipe excessively instead of using the search-adjacent `FilterModal`.

---

## 2. Detailed Itemized Scope of Changes

### 2.1 Brand Identity, Unified Header, and Colors (Feedback #1, #2, #10)
- **Unified Header**: Replace `EducationHeader` with standard `HomeTopBar`. The BookPasal logo, cart, notifications, profile avatar, and search bar must remain completely intact.
- **Brand Color Alignment**: Eradicate all arbitrary green styling (`bg-[#1b4332]`, `border-emerald-*`, `text-emerald-*`, etc.). All active pills, buttons, badges, and focus rings revert to BookPasal brand orange/amber (`primary: #e07a5f`, `terra: #c85a32`, warm neutral borders).
- **Subtle Academic Ambient Theme Shift**:
  - The toggle switches smoothly with a refined micro-animation (spring/scale pill slide).
  - When in Academic mode, the app background transitions subtly into a warm, refined scholastic parchment tone (ambient background shift), leaving BookPasal orange accents and typography intact.
  - No jarring dark green themes.

### 2.2 Global Banners & Popups Integration (Feedback #3)
- Ensure `<PWAInstallBanner />` and `<PushNotificationBanner />` are present at the top of the Academic view, exactly like the General home page.

### 2.3 Filter Layout & De-cluttering (Feedback #4, #6)
- **Single Primary Pill Strip on Page**:
  - Display exactly one clean row of level pills: `All Levels`, `School`, `+2 High School`, `University / Bachelors`.
  - Styled with brand orange (`border-primary bg-primary text-white` when active).
  - Remove all emojis (`📚`, `🎓`, etc.) from pill labels for a professional, clean look.
- **Deep Filters in `FilterModal`**:
  - Remove the endless horizontal scrolling Class and Subject chips from the home view.
  - Move Class, Subject, Academic Material Type (`Textbook`, `Guide`, `Question Bank`), and Syllabus Version (`Current Syllabus`, `Old Course`) into the `FilterModal` accessed via the filter icon next to the search bar.

### 2.4 Remove Sell Pill in Browse View (Feedback #5)
- Remove the "+ Sell" button from the browse view header and banners.

### 2.5 Scalability, Feeds, Pagination, and COLLECTIONS (Feedback #7)
- Remove the redundant `"Showing X books of Y"` text.
- **Include Academic Collections**: Academic sellers sell semester bundles, subject sets, and grade sets (e.g. "Class 10 Complete CDC Textbook Bundle", "BBA 1st Sem Set").
- Follow `app/page.tsx` feed pattern:
  - When searching/filtering: Display Books Grid + Collections Grid + `<Pagination />`.
  - When browsing: Display horizontal scroll sections or clean paginated grid with both academic books and academic collections.
- Wire with shared or unified query hooks so caching and pagination behave identically to the general home page.

### 2.6 Book Cards Consistency & Wishlist Fix (Feedback #8)
- **Wishlist Sync**: Ensure wishlist mutations invalidate the active query keys so toggling the heart immediately refreshes the card state.
- **Card Simplification**: Remove percentage discount badges and bottom price strike-throughs on individual academic book cards; match the clean structure of `BookCard`.
- **Card Height**: Maintain standard responsive height matching `BookCard` without breaking existing general feed cards.

### 2.7 Sell Flow Overhaul & Collections Support (Feedback #9)
- **Entry Choice UI (No Auto-Scanner)**:
  - When opening `/sell`, do NOT open the camera/scanner immediately (`scannerOpenForKey: null`).
  - Present a clean, welcoming choice card:
    - **General Books** (Novels, Non-fiction, Self-help, Literature) -> opens ISBN scanner / standard novel details.
    - **Academic & Textbooks** (School, +2, University curricula) -> opens academic book form.
- **Full Collections Support**:
  - Allow adding multiple academic books and bundling them into a Collection (locked/unlocked, discount rate %, collection name/description) using the existing `CollectionSection` component.
- **Strict `react-hook-form` Pattern**:
  - Completely replace the monolithic `useState` bag with `react-hook-form`.
  - Display validation error messages *directly beneath each input* using `<Input error={errors.xxx?.message} />`.
- **Form Fields Refinement**:
  - **Curriculum Level**: Smaller, compact pills (`School`, `+2 High School`, `University / Bachelors`).
  - **Class**: Labelled simply **"Class"**.
    - Implement an autocomplete single-select with search and a clear option for user custom entry.
    - School: Include ALL grades (Class 1 to Class 10 / SEE).
    - +2 High School: Class 11 & 12 streams (Science, Management, Humanities, Law, Education).
    - University / Bachelors: Top 15+ programs in Nepal (TU, KU, PU): BSc CSIT, BCA, BIT, BBA, BBS, BBM, BHM, BE Civil, BE Computer, BE Electrical, MBBS, BDS, B.Pharm, BSc Nursing, BA, B.Ed, BSc General, MBS, MBA, plus user custom entry.
  - **Subject**:
    - Classes 1–8: Compulsory English, Compulsory Nepali, Compulsory Mathematics, Science & Technology, Social Studies, Health & Physical Education, Moral Education / Local Subject.
    - Classes 9–10: Compulsory English, Nepali, Math, Science & Technology, Social Studies, Opt Math, Computer Science, Economics, Accountancy.
    - +2: Physics, Chemistry, Biology, Mathematics, English, Nepali, Computer Science, Accountancy, Economics, Business Studies, etc.
    - University: Common foundational subjects + free-text manual entry.
    - **Subject is strictly REQUIRED**: If user selects "Other / Custom", they MUST provide the custom subject name.
  - **Edition / Year**: Strictly in Bikram Sambat (e.g. `2081`), no English year slashes.
  - **Syllabus Version**: Full unabbreviated text for "Old Course / Previous Syllabus" without "or ..." truncation.
  - **Price**: Remove the "Price Negotiable" checkbox.

### 2.8 Book Details Page & Breadcrumbs (Feedback #10)
- Update `/book/[id]` `AcademicDetailsCard` and breadcrumbs: replace all green shades with BookPasal brand orange/amber accents, subtle neutral borders, and clean alert badges.

---

## 3. Step-by-Step Implementation Roadmap

1. **Step 1: Database Seed & Model Alignment**
   - Update `seeds/dev/02_seed_academic_curriculum.js` to seed full Class 1 to 10 classes and subjects, +2 streams, and top 15+ Bachelor/Master programs.
   - Run seed and verify with backend tests.
2. **Step 2: Unified Frontend Shell & Header on `/education`**
   - Replace `EducationHeader` with `HomeTopBar` in `app/education/page.tsx` and dynamic routes.
   - Add `<PWAInstallBanner />` and `<PushNotificationBanner />`.
   - Update `ModeSwitcher` to use brand orange (`bg-primary`) and smooth animation without `bg-green`.
   - Add subtle ambient background shift when mode is academic.
3. **Step 3: Filter System Overhaul**
   - On the page: single pill strip for Levels (`All Levels`, `School`, `+2 High School`, `University / Bachelors`) with brand orange styling and no emojis.
   - Integrate Class, Subject, Academic Type, and Syllabus filters into `FilterModal`.
4. **Step 4: Feeds, Collections & Wishlist Cache Sync**
   - Add academic collections support in backend (`is_academic` on collections or collections containing academic books).
   - Render Academic Books and Academic Collections sections in `app/education/page.tsx` matching `app/page.tsx`.
   - Invalidate education query keys on wishlist toggle so hearts update instantly.
5. **Step 5: Sell Flow Redesign (`app/sell`)**
   - Remove auto-scanner popup on initial mount (`scannerOpenForKey: null`).
   - Add initial choice UI: General vs Academic.
   - Refactor Academic sell form into `react-hook-form` with inline error messages under each input.
   - Implement Class autocomplete search with custom manual entry.
   - Implement Subject selector with compulsory/CDC presets and mandatory custom entry fallback.
   - Re-integrate `CollectionSection` so sellers can bundle academic books.
   - Remove "Price Negotiable" checkbox and clean up Edition Year placeholder (`2081`).
6. **Step 6: Book Details & Breadcrumbs Polish**
   - Clean up `AcademicDetailsCard` to use brand orange and neutral styling.
   - Verify mobile viewport at 480px × 1050px.
7. **Step 7: Verification & Evidence**
   - Run test suite, lint, format, typecheck, build, and capture new mobile screenshots.

