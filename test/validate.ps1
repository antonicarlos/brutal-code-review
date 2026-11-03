# ==============================================================================
# brutal-code-review Integrity & Smoke Test Suite (Windows PowerShell)
# Validates symlinks/files, rule books indexing, and repository sanity.
# ==============================================================================

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

Set-Location $RepoRoot

$Failed = 0
$CheckCount = 0

function Write-Pass($message) {
    Write-Host "[PASS] $message" -ForegroundColor Green
}

function Write-Fail($message) {
    Write-Host "[FAIL] $message" -ForegroundColor Red
    $script:Failed = 1
}

function Run-Check($description, [scriptblock]$check) {
    $script:CheckCount++
    try {
        $result = & $check
        if ($result -eq $true -or $null -eq $result) {
            Write-Pass $description
        } else {
            Write-Fail $description
        }
    } catch {
        Write-Fail "$description (Error: $_)"
    }
}

Write-Host "=== Running brutal-code-review sanity checks (Windows) ===" -ForegroundColor Cyan

# 1. Symlink or reference file validations
function Check-LinkOrTarget($filePath, $expectedTarget) {
    if (-not (Test-Path $filePath)) {
        return $false
    }
    $item = Get-Item -Path $filePath -Force
    if ($item.LinkType -eq "SymbolicLink") {
        return (Test-Path $item.Target)
    }
    # Fallback when Git cloned symlinks as text files (core.symlinks=false)
    $content = (Get-Content -Path $filePath -Raw).Trim()
    return ($content -like "*$expectedTarget*")
}

Run-Check "Link/Pointer .cursorrules resolves correctly" {
    Check-LinkOrTarget ".cursorrules" "SKILL.md"
}

Run-Check "Link/Pointer CLAUDE.md resolves correctly" {
    Check-LinkOrTarget "CLAUDE.md" "SKILL.md"
}

Run-Check "Link/Pointer .github/copilot-instructions.md resolves correctly" {
    Check-LinkOrTarget ".github/copilot-instructions.md" "SKILL.md"
}

# 2. Base files and knowledge structure existence
Run-Check "SKILL.md exists" { Test-Path "SKILL.md" }
Run-Check "KNOWLEDGE.md exists" { Test-Path "KNOWLEDGE.md" }
Run-Check "README.md exists" { Test-Path "README.md" }
Run-Check ".gitignore exists" { Test-Path ".gitignore" }
Run-Check "knowledge/global/KNOWLEDGE.md exists" { Test-Path "knowledge/global/KNOWLEDGE.md" }
Run-Check "knowledge/projects directory exists" { Test-Path "knowledge/projects" }
Run-Check "knowledge/projects/TEMPLATE.md exists" { Test-Path "knowledge/projects/TEMPLATE.md" }
Run-Check "SKILL.md contains DDL & Migration Scripts Exemption" {
    (Get-Content -Path "SKILL.md" -Raw) -match "DDL & Migration Scripts Exemption"
}
Run-Check "TEMPLATE.md defines Project Slug convention" {
    (Get-Content -Path "knowledge/projects/TEMPLATE.md" -Raw) -match "Project Slug"
}

# 3. Check for unwanted NTFS Zone.Identifier artifacts
Run-Check "No NTFS Zone.Identifier artifact files exist" {
    $zoneFiles = Get-ChildItem -Path . -Recurse -Filter "*Zone.Identifier*" -File -ErrorAction SilentlyContinue
    if ($null -ne $zoneFiles -and $zoneFiles.Count -gt 0) {
        Write-Host "Found $($zoneFiles.Count) Zone.Identifier files." -ForegroundColor Yellow
        return $false
    }
    return $true
}

# 4. Extract and validate book directories from SKILL.md index
Run-Check "All 14 rule books in SKILL.md exist physically with SKILL.md" {
    $skillContent = Get-Content -Path "SKILL.md" -Raw
    $matches = [regex]::Matches($skillContent, '\./agent-rules-books/([a-zA-Z0-9_-]+)/?')
    $bookDirs = $matches | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique

    if ($bookDirs.Count -lt 14) {
        Write-Host "Expected at least 14 books, found $($bookDirs.Count)." -ForegroundColor Yellow
        return $false
    }

    $missing = 0
    foreach ($b in $bookDirs) {
        $dirPath = Join-Path "agent-rules-books" $b
        $skillPath = Join-Path $dirPath "SKILL.md"
        if (-not (Test-Path $dirPath)) {
            Write-Host "Missing book directory: $dirPath" -ForegroundColor Yellow
            $missing++
        } elseif (-not (Test-Path $skillPath)) {
            Write-Host "Missing SKILL.md in: $dirPath" -ForegroundColor Yellow
            $missing++
        }
    }
    return ($missing -eq 0)
}

# 5. Check .gitignore rules
Run-Check ".gitignore contains .code-review/logs/ and Zone.Identifier" {
    $giContent = Get-Content -Path ".gitignore" -Raw
    return ($giContent -match '\.code-review/logs/' -and $giContent -match 'Zone\.Identifier')
}

Write-Host "=========================================================" -ForegroundColor Cyan
if ($Failed -eq 0) {
    Write-Host "All $CheckCount validation checks passed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Validation failed!" -ForegroundColor Red
    exit 1
}
