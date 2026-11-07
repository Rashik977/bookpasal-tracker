#!/usr/bin/env bash
set -e

# my-tickets.sh
# Prints assigned tickets for Rashik977 from the "Book pasal features" GitHub Project (Project #2)
# filtered by Backlog status and not Blocked/Blocking.

PROJECT_NUMBER="2"
OWNER="Rashik977"

# Check for gh auth
if ! gh project list --owner "$OWNER" >/dev/null 2>&1; then
  echo "ERROR: GitHub CLI missing project scope or unauthenticated. Run: gh auth refresh -s project" >&2
  exit 1
fi

ITEMS_JSON=$(gh project item-list "$PROJECT_NUMBER" --owner "$OWNER" --format json --limit 100)

node -e '
const fs = require("fs");
const data = JSON.parse(process.argv[1]);

const priorityOrder = {
  "very high": 1,
  "high": 2,
  "medium": 3,
  "low": 4
};

const items = data.items || [];
let blockedCount = 0;
const candidates = [];

for (const item of items) {
  const content = item.content || {};
  
  // Assignee check
  const assignees = item.assignees || [];
  const isAssignedToRashik = assignees.some(a => /rashik/i.test(a));
  if (!isAssignedToRashik) continue;

  const priority = (item.priority || item.Priority || "").trim();
  const status = (item.status || item.Status || "").trim();
  const sp = item.sP ?? item.SP ?? "-";
  const issueNum = content.number ?? item.number ?? "-";
  const title = content.title ?? item.title ?? "";
  const url = content.url ?? item.url ?? "";

  // Check if ticket is blocked
  if (priority.toLowerCase() === "blocking" || priority.toLowerCase() === "blocked" || status.toLowerCase() === "blocked") {
    blockedCount++;
    continue;
  }

  // Only tickets in "Backlog" status are available to start
  if (status.toLowerCase() !== "backlog") {
    continue;
  }

  const pScore = priorityOrder[priority.toLowerCase()] || 99;
  candidates.push({
    number: issueNum,
    title,
    priority: priority || "None",
    sp,
    status,
    url,
    pScore
  });
}

// Sort by Priority score ascending (Very High -> High -> Medium -> Low), then by lower issue number
candidates.sort((a, b) => {
  if (a.pScore !== b.pScore) return a.pScore - b.pScore;
  return Number(a.number) - Number(b.number);
});

console.log("");
console.log("=========================================================================================================");
console.log("                                 AVAILABLE TICKETS (ASSIGNED TO RASHIK)                                  ");
console.log("=========================================================================================================");
console.log(
  "Issue #".padEnd(9) +
  "Priority".padEnd(12) +
  "SP".padEnd(5) +
  "Status".padEnd(12) +
  "Title".padEnd(52) +
  "URL"
);
console.log("-".repeat(115));

for (const c of candidates) {
  const shortTitle = c.title.length > 49 ? c.title.substring(0, 46) + "..." : c.title;
  console.log(
    `#${c.number}`.padEnd(9) +
    c.priority.padEnd(12) +
    String(c.sp).padEnd(5) +
    c.status.padEnd(12) +
    shortTitle.padEnd(52) +
    c.url
  );
}

console.log("-".repeat(115));
console.log(`Blocked/Blocking tickets assigned to Rashik: ${blockedCount}`);
console.log("");
' "$ITEMS_JSON"
