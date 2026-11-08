## Summary
Complete overhaul of the Education hub and academic sell flow to strictly align with BookPasal's brand identity, standard layout components, and mobile-first PWA experience. Replaces green accent styles with an ambient warm scholastic canvas (`bg-[#fcf9f2]`), integrates standard `HomeTopBar`, PWA install banner, search filter modal with academic filters, single pill level strip, academic collections/bundles feed, and a two-card choice UI on `/sell`.

## Slices & Changes
- **Slice 01 - Mode Switcher & Ambient Canvas**: Centered `[ 📚 General ] [ 🎓 Academic ]` switcher in `HomeTopBar` with smooth toggle transition, brand orange highlight, and subtle warm scholastic background `#fcf9f2` on `/education`.
- **Slice 02 - Sell Choice UI & Strict Form**: Overhauled `/sell` to remove automatic ISBN camera scanner on mount; added clean choice cards (`Literature & General` vs `Academic & Textbooks`). Created single-select autocomplete for Class/Stream with live search and custom class input. Strict `react-hook-form` validation with inline error messages under each field, mandatory subject, and Nepali B.S. edition year.
- **Slice 03 - Education Hub & Brand Single Pill Strip**: Integrated standard `HomeTopBar` (with logo, notifications, cart, profile) and PWA install banners. Single pill strip in brand orange (`All Levels`, `School`, `+2 High School`, `University / Bachelors`) with no emojis. Displayed academic collections/bundles section alongside textbook grid with standard pagination.
- **Slice 04 - Filter Modal Integration**: Connected search-adjacent `FilterModal` to pass academic-specific filters (Material Type, Syllabus Version, Markings Status) when in academic mode.
- **Slice 05 - BookCard & Academic Details Polish**: Defaulted `originalPrice` to empty string in `BookCard` to eliminate unwanted discount badges and strikethrough prices. Updated academic badge to neutral dark badge. Updated wishlist mutations to invalidate `["education"]` query key for instantaneous heart state refresh.

## Mobile Screenshots
| Screen / Feature | Viewport | Screenshot |
| :--- | :--- | :--- |
| Education Hub (Brand Header, Single Pill Strip, Bundles, Textbooks, PWA Banner) | Mobile (480x1050) | ![Education Hub](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/education_hub_mobile.png) |
| Sell Flow Choice UI (Literature vs Academic, No Auto Camera) | Mobile (480x1050) | ![Sell Choice UI](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/sell_selection_mobile.png) |
| Academic Sell Form (Cascading Selectors, Inline Errors, BS Year) | Mobile (480x1050) | ![Academic Sell Form](https://raw.githubusercontent.com/Rashik977/bookpasal-tracker/main/specs/BP-33-education-section/evidence/sell_academic_mobile.png) |

## Verification
- Tests: `npm test` -> PASS (8 test files, 16 tests passed)
- Build: `npm run build` -> PASS (Production build with Turbopack/Webpack succeeded, all routes valid)
- Format Check: `npm run format:check` -> PASS (0 errors)
- Lint: `npm run lint` -> PASS (0 errors, baseline warnings untouched)
- Mobile Browser Check: Verified at 480×1050 viewport with all 5 BottomNav items visible.

## How to Test
1. Start backend (`npm run dev` in `bookpasal_backend`) and frontend (`npm run dev` in `bookpasal_frontend`).
2. Navigate to `http://localhost:3000` in mobile viewport (480x1050). Tap `Academic` on the mode switcher -> Smoothly navigates to `/education`.
3. Verify BookPasal header, single orange pill strip, Academic Collections & Bundles carousel, and Academic Textbooks grid.
4. Tap wishlist heart on any textbook -> verify heart fills orange immediately.
5. Tap `Filter` button next to search bar -> verify filter modal includes Academic Filters (Material Type, Syllabus Version, Markings Status).
6. Navigate to `http://localhost:3000/sell` -> Verify no auto-camera scanner pops up. Tap `Academic & Textbooks` -> navigates to `/sell/academic`.
7. Test Class autocomplete search and custom class input. Verify Subject is mandatory and Edition Year accepts B.S. years.

## Decisions & Trade-offs
- Used standard `BookCard` component with `originalPrice` defaulted to `""` to preserve consistency between General and Education feeds without code duplication.
- Cached wishlist state updates against `["education"]` to ensure immediate reactive UI changes.

Refs Rashik977/bookpasal-tracker#33
