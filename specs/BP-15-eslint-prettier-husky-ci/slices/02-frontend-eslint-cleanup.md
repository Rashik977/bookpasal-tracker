# Slice 2: Frontend Legacy ESLint Remediation & Clean Linting

## Goal & Behaviour
Eliminate all 48 pre-existing ESLint errors across the frontend repo, replace untyped `any` annotations with proper TypeScript interfaces matching backend response schemas, ignore generated PWA files, and achieve a 100% clean `npm run lint` run with 0 errors.

## Why It Is Vertical
It touches all layers of the frontend application:
- ESLint configuration (`eslint.config.mjs`).
- API Services & Types layer (`server/services/book.service.ts`, `server/services/question.service.ts`, `types/index.ts`).
- UI Components & Pages (`app/book/[id]/page.tsx`, `app/collection/[id]/page.tsx`, `app/(protected)/orders/page.tsx`, `app/(protected)/notifications/page.tsx`).
- Mobile-first browser verification across affected pages.

## Exact Files to Create / Modify
- Modify: `bookpasal_frontend/eslint.config.mjs` (ignore `public/**` and generated sw assets).
- Modify: `bookpasal_frontend/types/index.ts` (add missing response/payload types).
- Modify: `bookpasal_frontend/server/services/book.service.ts` (replace `any` with typed params/returns).
- Modify: `bookpasal_frontend/server/services/question.service.ts` (replace `any` with typed params/returns).
- Modify: `bookpasal_frontend/app/book/[id]/page.tsx` (fix unescaped HTML entities, replace `any` in callback parameters).
- Modify: `bookpasal_frontend/app/collection/[id]/page.tsx` (replace `any` with typed interfaces).
- Modify: `bookpasal_frontend/app/(protected)/orders/page.tsx` (fix synchronous `setState` in `useEffect`).
- Modify: `bookpasal_frontend/app/(protected)/notifications/page.tsx` (fix unescaped apostrophe).
- Create: `bookpasal_frontend/tests/lint.test.ts` (tests that ESLint runs and reports 0 errors).

## First Failing Test to Write
- File: `bookpasal_frontend/tests/lint.test.ts`
- Test: `"ESLint exits with code 0 across the entire frontend repo"`
- Assertion: Executes ESLint via Node `execSync` / API and asserts exit code is 0 with 0 errors.

## Further Behaviours to TDD / Implement in Order
1. Update `eslint.config.mjs` to add `public/**` to `globalIgnores`.
2. Update `server/services/book.service.ts` and `question.service.ts` with explicit type definitions for questions, answers, and book items.
3. Update `app/book/[id]/page.tsx` and `app/collection/[id]/page.tsx` to use the typed interfaces, and escape `"` as `&quot;`.
4. Fix `app/(protected)/orders/page.tsx` to eliminate synchronous `setState` within effect.
5. Fix `app/(protected)/notifications/page.tsx` unescaped `'` as `&apos;`.
6. Run `npm run lint` and verify 0 errors.
7. Run `npm test`, `npx tsc --noEmit`, and `npm run build` to confirm no regressions.

## Commands to Run
- `cd bookpasal_frontend; npm run lint`
- `cd bookpasal_frontend; npx tsc --noEmit`
- `cd bookpasal_frontend; npm test`
- `cd bookpasal_frontend; npm run build`

## Browser Check (Mobile Viewport: 375x667)
1. Start frontend dev server on port 3001 (or test build).
2. Open mobile browser emulator at 375x667.
3. Navigate to:
   - Homepage `/`
   - Book detail page `/book/[id]`
   - Collection detail page `/collection/[id]`
   - Orders page `/orders`
4. Confirm pages render smoothly without console errors or layout breaks.
5. Save mobile viewport screenshot to `evidence/fe-mobile-smoke.png`.

## Done Criteria
1. `npm run lint` completes with 0 errors.
2. `npx tsc --noEmit` completes with 0 errors.
3. `npm test` passes.
4. `npm run build` completes successfully.
5. Mobile viewport screenshot saved in `evidence/`.

## Risks & Open Decisions
None. All choices aligned with Option B and Option A from the interview.

