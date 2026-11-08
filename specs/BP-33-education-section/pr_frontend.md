## Summary
Complete overhaul of the Education hub and academic sell flow to strictly align with BookPasal's brand identity, standard layout components, and mobile-first PWA experience. Replaces green accent styles with an ambient warm scholastic canvas (`bg-[#fcf9f2]`), integrates standard `HomeTopBar`, PWA install banner, search filter modal with dynamic academic filters, level pills inside top bar directly below search with right-edge fade, academic collections/bundles feed, two-card choice UI on `/sell`, and academic collection bundling.

## Slices & Changes
- **Slice 01 - Mode Switcher & Ambient Canvas**: Centered `[ 📚 General ] [ 🎓 Academic ]` switcher in `HomeTopBar` with smooth toggle transition, brand orange highlight, and subtle warm scholastic background `#fcf9f2` on `/education`.
- **Slice 02 - Sell Choice UI & Strict Form**: Overhauled `/sell` to remove automatic ISBN camera scanner on mount; added clean choice cards (`Literature & General` vs `Academic & Textbooks`). Created MUI-style autocomplete for Class and Subject with live search and custom entry directly in the same input. Strict `react-hook-form` validation with inline error messages under each field, mandatory subject, and Nepali B.S. edition year.
- **Slice 03 - Education Hub & Brand Single Pill Strip**: Integrated standard `HomeTopBar` (with logo, notifications, cart, profile) and PWA install banners. Single pill strip in brand orange (`All Levels`, `School`, `+2 High School`, `University / Bachelors`) with no emojis placed directly beneath search in the sticky header with right-edge fade. Displayed academic collections/bundles section alongside textbook grid with standard pagination.
- **Slice 04 - Filter Modal Integration**: Overhauled search-adjacent `FilterModal` to dynamically populate Curriculum Level, Class/Stream (filtered by Level), Subject (filtered by Class), Material Type, and Price Range.
- **Slice 05 - BookCard & Academic Details Polish**: Defaulted `originalPrice` to empty string in `BookCard` to eliminate unwanted discount badges and strikethrough prices. Updated academic badge to neutral dark badge. Updated wishlist mutations to invalidate `["education"]` query key for instantaneous heart state refresh.
- **Sell Hub & Academic Collection Bundling**: Transferred general sell flow to `/sell/general`, and enhanced `/sell/academic` with multi-book accordion support and `CollectionSection` so sellers can bundle 2+ academic books into an academic course bundle with a discount (10–50%) published atomically via `POST /api/listing`.

## Mobile Screenshots (480px × 1050px)
| Screen / Feature | Viewport | Screenshot |
| :--- | :--- | :--- |
| **Education Hub** (Brand Header, Level Pills Under Search with Fade, Bundles, Textbooks, PWA Banner) | Mobile (480x1050) | ![Education Hub](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_hub_mobile.png) |
| **Academic Filter Modal** (Curriculum Level, Dynamic Class & Subject, Material Type, Price Range) | Mobile (480x1050) | ![Academic Filter Modal](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_filter_mobile.png) |
| **Curriculum Class View & Breadcrumbs** (`Home > Education > Class 10 (SEE)`, Hero Card, Real Book Grid) | Mobile (480x1050) | ![Class Breadcrumbs](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_class_breadcrumbs_mobile.png) |
| **Curriculum Subject View & Breadcrumbs** (`Home > Education > Class 10 (SEE) > Compulsory Mathematics`) | Mobile (480x1050) | ![Subject Breadcrumbs](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_subject_breadcrumbs_mobile.png) |
| **Academic Book Detail** (Breadcrumbs, Cover Carousel, Condition, Academic Details Card) | Mobile (480x1050) | ![Academic Book Detail](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_book_detail_mobile.png) |
| **Academic Collection / Bundle Detail** (Course Bundle Details, Bundle Price, Included Books) | Mobile (480x1050) | ![Academic Collection Detail](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_collection_detail_mobile.png) |
| **Sell Landing Hub** (Choice Cards: Literature vs Academic, No Camera Auto-Popup) | Mobile (480x1050) | ![Sell Choice UI](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/sell_selection_mobile.png) |
| **Academic Sell Wizard** (MUI Autocomplete Class & Subject, BS Year, Multi-Book & Collection Bundling) | Mobile (480x1050) | ![Academic Sell Wizard](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/sell_academic_mobile.png) |
| **General Sell Flow** (Multi-Book Accordion, Optional General Collection Bundling) | Mobile (480x1050) | ![General Sell Flow](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/sell_general_mobile.png) |

## Verification
- Tests: `npm test` -> PASS (8 test files, 16 tests passed - 100% pass rate)
- Build: `npm run build` -> PASS (Production build succeeded, all static & dynamic routes valid)
- Format Check: `npm run format:check` -> PASS (0 errors)
- Lint: `npm run lint` -> PASS (0 errors, baseline warnings untouched)
- Mobile Browser Check: Verified all screens at 480×1050 viewport with all 5 BottomNav items visible and real database seed data.

## How to Test
1. Start backend (`npm run dev` in `bookpasal_backend`) and frontend (`npm run dev` in `bookpasal_frontend`).
2. Navigate to `http://localhost:3000` in mobile viewport (480x1050). Tap `Academic` on the mode switcher -> Smoothly navigates to `/education`.
3. Verify BookPasal header, level pills directly under search, Academic Collections & Bundles carousel, and Academic Textbooks grid.
4. Tap wishlist heart on any textbook -> verify heart fills orange immediately.
5. Tap `Filter` button next to search bar -> verify filter modal includes dynamic Academic Filters (Curriculum Level, Class, Subject, Material Type, Price Range).
6. Tap on a textbook or collection card -> verify breadcrumb navigation and Academic Details card.
7. Navigate to `http://localhost:3000/sell` -> Verify no auto-camera scanner pops up. Tap `Academic & Textbooks` -> navigates to `/sell/academic`.
8. Test Class & Subject MUI autocomplete: search or type custom. Test adding another book and checking the optional collection bundling checkbox.

## Decisions & Trade-offs
- Used standard `BookCard` component with `originalPrice` defaulted to `""` to preserve consistency between General and Education feeds without code duplication.
- Cached wishlist state updates against `["education"]` to ensure immediate reactive UI changes.
- Embedded level pills directly within `HomeTopBar` to ensure zero vertical layout shift across screen modes.

Refs Rashik977/bookpasal-tracker#33
