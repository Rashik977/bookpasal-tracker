# Notification System Architecture

This document explains the end-to-end notification system in Book Pasal. It is designed to give any engineer a complete understanding of how our in-app notifications and OS-level Push Notifications (PWA) are wired up, including the environment configuration, frontend polling, and potential edge cases.

---

## 1. Overview & The `web-push` Package

Book Pasal implements a dual-layer notification system:
1. **In-App Notifications**: Stored in our database (PostgreSQL via Knex) and viewed via the notification bell dropdown and the dedicated `/notifications` page.
2. **OS-Level Push Notifications**: Delivered directly to the user's device (desktop or mobile) via the browser's Push API, even if the web app is closed.

### What is `web-push`?
To send an OS-level push notification to a browser, we use the `web-push` npm package in the backend. 
When a browser subscribes to push notifications, it gives us an `endpoint` URL (belonging to Google FCM, Mozilla Autopush, Apple APNs, etc.) and a set of encryption keys. The `web-push` package handles encrypting the notification payload (title, message, and URL) and securely POSTing it to that endpoint. It abstracts away the complex cryptography and HTTP requests required to talk to these third-party push services.

---

## 2. VAPID & Environment Variables

### What is VAPID?
VAPID stands for **Voluntary Application Server Identification**. It is an open standard that uses a public/private key pair to identify your Node.js backend to the browser push services (like Google FCM). It prevents anyone else from sending push notifications to your users' devices, and it removes the need to register for API keys with Google or Apple.

### Environment Variables
You need three environment variables for VAPID to work:
- `VAPID_SUBJECT`: Usually a `mailto:your-email@domain.com` or your website URL. This is so push services can contact you if there are issues.
- `VAPID_PUBLIC_KEY`: The public half of the key pair.
- `VAPID_PRIVATE_KEY`: The private half of the key pair (never expose this).

The frontend needs access to the public key to generate the subscription. In Next.js, this is exposed as `NEXT_PUBLIC_VAPID_PUBLIC_KEY`.

### Creating Keys for Production
To generate your own VAPID keys for production, open your terminal and run:
```bash
npx web-push generate-vapid-keys
```
This command will output a new public and private key. 
1. Copy the **Public Key** to both your backend `.env` (`VAPID_PUBLIC_KEY`) and your frontend `.env` (`NEXT_PUBLIC_VAPID_PUBLIC_KEY`).
2. Copy the **Private Key** ONLY to your backend `.env` (`VAPID_PRIVATE_KEY`).
3. Set your `VAPID_SUBJECT` to a support email in your backend `.env`.

---

## 3. Frontend: PWA, Service Worker, and Auth Sync

Our frontend is a Next.js Progressive Web App (PWA). Push notifications require a **Service Worker** (`sw.js`) to run in the background and listen for incoming `push` events from the OS.

### How it is wired up:
1. **`PushNotificationProvider.tsx`**: This component wraps our app. It checks if the browser supports push notifications (`"serviceWorker" in navigator`).
2. **NextAuth Integration**: The provider hooks into `useSession()`. If the user is authenticated and has granted Notification permissions, it automatically requests a subscription from the browser's `pushManager` using the `NEXT_PUBLIC_VAPID_PUBLIC_KEY`.
3. **API Sync**: Once the browser yields the subscription object (endpoint and keys), the provider sends a `POST` request to `/api/notifications/subscribe` to save it in the database against the user's ID.
4. **Session Storage Optimization**: To avoid hammering the backend on every page reload, the provider writes a flag (`push_synced_${userEmail}`) to `sessionStorage` once the sync succeeds. 

---

## 4. Polling & In-App Data Fetching

While Web Push handles OS-level alerts, the UI itself (the bell badge and the list) needs to stay updated. We use TanStack React Query for this in `server/queries/notification.ts`.

### How Polling is happening:
Instead of a complex and expensive WebSocket connection, we use **Short Polling** to fetch unread counts and new notifications.

### Performance & Cost Optimizations:
- **`enabled: isAuthenticated`**: The query completely shuts off if the user is not logged in. Anonymous users (the vast majority of web traffic) trigger 0 API calls.
- **`refetchInterval: 60000`**: The app pings the server every 1 minute.
- **`refetchIntervalInBackground: false`**: This is a critical cost-saver. If the user switches to a different browser tab or minimizes the browser, polling immediately stops.
- **`staleTime: 30000`**: If a user navigates rapidly between pages, React Query won't refetch the notifications because the data is considered "fresh" for 30 seconds.

---

## 5. Assessment, Costs, and Risks

### Cost Impact (Hosting)
- **Web Push (OS Notifications)**: $0. Using VAPID and `web-push` bypasses the need for third-party SaaS providers like Pusher or OneSignal. It is completely free.
- **Database (PostgreSQL)**: Notifications are stored permanently. Over time, millions of notifications will consume disk space. 
  - *Recommendation*: Implement a cron job or background worker to delete `is_read = true` notifications older than 60 days.
- **Polling Compute**: Because we use `refetchIntervalInBackground: false`, users who leave the tab open for days won't rack up thousands of useless API requests. This keeps Railway compute/bandwidth costs extremely low.

### Known Edge Cases & Risks
1. **Baked-in Web Push URLs**: 
   - When the backend fires a push notification, the `url` payload is permanently baked into the OS notification. 
   - *Risk*: If we change our frontend routing architecture (e.g., changing `/orders/sales/[id]` to `/orders?tab=sales`), any OS notifications currently sitting in the user's system tray will trigger a 404 when clicked. In-app notifications do not suffer from this as their links are generated dynamically on the frontend.
2. **Stale Subscriptions**: 
   - Users can revoke push permissions via their OS or browser settings. When this happens, our database still holds the subscription. 
   - *Mitigation*: The `notificationService.js` catches `404` and `410` HTTP errors from Google/Apple when a push fails, and automatically deletes the dead subscription from the database.
3. **VAPID Key Rotation**:
   - If you ever lose your VAPID Private Key or decide to change your Public Key, **all existing user push subscriptions will be instantly invalidated**. You should never change your VAPID keys unless absolutely necessary (e.g., they were leaked).
