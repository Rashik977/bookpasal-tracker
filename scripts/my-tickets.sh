#!/usr/bin/env bash
set -e

# my-tickets.sh
# Prints assigned tickets for Rashik977 from the "Book pasal features" GitHub Project
# filtered by available-to-start status and not Blocked.

PROJECT_NUMBER="${BOOKPASAL_PROJECT_NUM:-}"
STATUS_AVAILABLE="${STATUS_AVAILABLE:-Todo,Ready,Backlog}"

# Check for gh auth project scope
if ! gh project list --owner Rashik977 >/dev/null 2>&1; then
  echo "ERROR: GitHub CLI missing project scope. Please run: gh auth refresh -s project" >&2
  exit 1
fi

if [ -z "$PROJECT_NUMBER" ]; then
  # Dynamically discover "Book pasal features" project number if not passed
  PROJECT_NUMBER=$(gh project list --owner Rashik977 --format json --jq '.projects[] | select(.title | test("Book pasal features|Features"; "i")) | .number' 2>/dev/null || true)
  if [ -z "$PROJECT_NUMBER" ]; then
    # Fallback using node
    PROJECT_NUMBER=$(gh project list --owner Rashik977 --format json | node -e '
      const fs = require("fs");
      const input = JSON.parse(fs.readFileSync(0, "utf-8"));
      const prj = input.projects.find(p => /book pasal features|features/i.test(p.title));
      if (prj) console.log(prj.number);
    ' 2>/dev/null || true)
  fi
fi

if [ -z "$PROJECT_NUMBER" ]; then
  echo "ERROR: Could not locate 'Book pasal features' project. Check gh auth status." >&2
  exit 1
fi

ITEMS_JSON=$(gh project item-list "$PROJECT_NUMBER" --owner Rashik977 --format json --limit 100)

# Process and format using node (or jq if preferred)
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
  const fields = item;
  
  // Extract fields
  const assignees = item.assignees || (content.assignees ? content.assignees.map(a => a.login) : []);
  const isAssignedToRashik = assignees.some(a => /rashik/i.test(a));
  
  if (!isAssignedToRashik) continue;

  const priority = (item["Priority"] || item.priority || "").trim();
  const status = (item["Status"] || item.status || "").trim();
  const sp = item["SP"] || item.sp || "-";
  const issueNum = content.number || item.number || "-";
  const title = content.title || item.title || "";
  const url = content.url || item.url || "";

  if (priority.toLowerCase() === "blocked" || status.toLowerCase() === "blocked") {
    blockedCount++;
    continue;
  }

  // Status filtering: ignore Done / In Progress when looking for available to start
  if (/done|closed|in progress/i.test(status)) {
    continue;
  }

  const pScore = priorityOrder[priority.toLowerCase()] || 99;
  candidates.push({
    number: issueNum,
    title,
    priority: priority || "None",
    sp,
    status: status || "Open",
    url,
    pScore
  });
}

// Sort by Priority score ascending, then by lower issue number
candidates.sort((a, b) => {
  if (a.pScore !== b.pScore) return a.pScore - b.pScore;
  return Number(a.number) - Number(b.number);
});

console.log("");
console.log("=========================================================================================");
console.log("                        AVAILABLE TICKETS (ASSIGNED TO RASHIK)                          ");
console.log("=========================================================================================");
console.log(
  "Issue #".padEnd(9) +
  "Priority".padEnd(12) +
  "SP".padEnd(5) +
  "Status".padEnd(15) +
  "Title".padEnd(45) +
  "URL"
);
console.log("-".repeat(110));

for (const c of candidates) {
  const shortTitle = c.title.length > 42 ? c.title.substring(0, 39) + "..." : c.title;
  console.log(
    `#${c.number}`.padEnd(9) +
    c.priority.padEnd(12) +
    String(c.sp).padEnd(5) +
    c.status.padEnd(15) +
    shortTitle.padEnd(45) +
    c.url
  );
}

console.log("-".repeat(110));
console.log(`Blocked tickets assigned to Rashik: ${blockedCount}`);
console.log("");
' "$ITEMS_JSON"
