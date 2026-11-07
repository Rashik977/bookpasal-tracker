# my-tickets.ps1
# PowerShell equivalent of my-tickets.sh for native Windows execution

$ProjectNumber = "2"
$Owner = "Rashik977"

try {
    $itemsJson = gh project item-list $ProjectNumber --owner $Owner --format json --limit 100
} catch {
    Write-Error "ERROR: GitHub CLI missing project scope or unauthenticated. Run: gh auth refresh -s project"
    exit 1
}

$data = $itemsJson | ConvertFrom-Json
$priorityOrder = @{
    "very high" = 1
    "high"      = 2
    "medium"    = 3
    "low"       = 4
}

$blockedCount = 0
$candidates = @()

foreach ($item in $data.items) {
    $assignees = $item.assignees
    $isAssigned = $false
    foreach ($a in $assignees) {
        if ($a -match "rashik") { $isAssigned = $true; break }
    }
    if (-not $isAssigned) { continue }

    $priority = "$($item.priority)".Trim()
    $status = "$($item.status)".Trim()
    $sp = if ($item.sP) { $item.sP } else { "-" }
    $issueNum = if ($item.content.number) { $item.content.number } else { "-" }
    $title = if ($item.content.title) { $item.content.title } else { "" }
    $url = if ($item.content.url) { $item.content.url } else { "" }

    if ($priority -match "blocking|blocked" -or $status -match "blocked") {
        $blockedCount++
        continue
    }

    if ($status -ne "Backlog") {
        continue
    }

    $pKey = $priority.ToLower()
    $pScore = if ($priorityOrder.ContainsKey($pKey)) { $priorityOrder[$pKey] } else { 99 }

    $candidates += [PSCustomObject]@{
        Number   = $issueNum
        Title    = $title
        Priority = if ($priority) { $priority } else { "None" }
        SP       = $sp
        Status   = $status
        URL      = $url
        PScore   = $pScore
    }
}

$sorted = $candidates | Sort-Object -Property PScore, Number

Write-Host ""
Write-Host "========================================================================================================="
Write-Host "                                 AVAILABLE TICKETS (ASSIGNED TO RASHIK)                                  "
Write-Host "========================================================================================================="
Write-Host ("{0,-9}{1,-12}{2,-5}{3,-12}{4,-52}{5}" -f "Issue #", "Priority", "SP", "Status", "Title", "URL")
Write-Host ("-" * 115)

foreach ($c in $sorted) {
    $shortTitle = if ($c.Title.Length -gt 49) { $c.Title.Substring(0, 46) + "..." } else { $c.Title }
    Write-Host ("#{0,-8}{1,-12}{2,-5}{3,-12}{4,-52}{5}" -f $c.Number, $c.Priority, $c.SP, $c.Status, $shortTitle, $c.URL)
}

Write-Host ("-" * 115)
Write-Host "Blocked/Blocking tickets assigned to Rashik: $blockedCount"
Write-Host ""
