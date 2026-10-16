param (
    [string]$ProjectPath = ".",
    [string]$ProjectName = "",
    [string]$InitialEpic = "01-core-foundation"
)

$targetPath = (Resolve-Path $ProjectPath).Path
if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    $ProjectName = (Get-Item $targetPath).Name
}

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host " KHOI TAO KHUNG QUAN TRI DAC TA DU AN: $ProjectName" -ForegroundColor Cyan
Write-Host " Duong dan: $targetPath" -ForegroundColor Gray
Write-Host "=================================================================" -ForegroundColor Cyan

$specsDir = Join-Path $targetPath "docs\specs"
$featuresDir = Join-Path $specsDir "features"
$initialEpicDir = Join-Path $featuresDir $InitialEpic

$dirs = @($specsDir, $featuresDir, $initialEpicDir)
foreach ($d in $dirs) {
    if (!(Test-Path $d)) {
        New-Item -ItemType Directory -Path $d -Force | Out-Null
        Write-Host "Da tao thu muc: $d" -ForegroundColor Green
    }
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$templatesDir = Join-Path (Split-Path -Parent $scriptDir) "templates"
$today = Get-Date -Format "yyyy-MM-dd"

# 1. ROADMAP.md
$roadmapTarget = Join-Path $specsDir "ROADMAP.md"
if (!(Test-Path $roadmapTarget)) {
    $tFile = Join-Path $templatesDir "ROADMAP_TEMPLATE.md"
    if (Test-Path $tFile) {
        $txt = Get-Content -Path $tFile -Raw -Encoding UTF8
        $txt = $txt.Replace("[TÊN DỰ ÁN]", $ProjectName.ToUpper()).Replace("YYYY-MM-DD", $today)
        Set-Content -Path $roadmapTarget -Value $txt -Encoding UTF8
        Write-Host "Da khoi tao ROADMAP.md" -ForegroundColor Green
    }
}

# 2. ARCHITECTURE.md
$archTarget = Join-Path $specsDir "ARCHITECTURE.md"
if (!(Test-Path $archTarget)) {
    $tFile = Join-Path $templatesDir "ARCHITECTURE_TEMPLATE.md"
    if (Test-Path $tFile) {
        $txt = Get-Content -Path $tFile -Raw -Encoding UTF8
        $txt = $txt.Replace("[TÊN DỰ ÁN]", $ProjectName.ToUpper()).Replace("YYYY-MM-DD", $today)
        Set-Content -Path $archTarget -Value $txt -Encoding UTF8
        Write-Host "Da khoi tao ARCHITECTURE.md" -ForegroundColor Green
    }
}

# 3. SPEC.md
$specTarget = Join-Path $initialEpicDir "SPEC.md"
if (!(Test-Path $specTarget)) {
    $tFile = Join-Path $templatesDir "FEATURE_SPEC_TEMPLATE.md"
    if (Test-Path $tFile) {
        $txt = Get-Content -Path $tFile -Raw -Encoding UTF8
        $txt = $txt.Replace("[Tên tính năng ngắn gọn, rõ ràng]", $InitialEpic).Replace("EPIC-XX", "EPIC-01").Replace("YYYY-MM-DD", $today)
        Set-Content -Path $specTarget -Value $txt -Encoding UTF8
        Write-Host "Da tao SPEC.md cho $InitialEpic" -ForegroundColor Green
    }
}

# 4. TASKS.md
$tasksTarget = Join-Path $initialEpicDir "TASKS.md"
if (!(Test-Path $tasksTarget)) {
    $tFile = Join-Path $templatesDir "TASKS_TEMPLATE.md"
    if (Test-Path $tFile) {
        $txt = Get-Content -Path $tFile -Raw -Encoding UTF8
        $txt = $txt.Replace("[Tên tính năng]", $InitialEpic).Replace("EPIC-XX", "EPIC-01").Replace("YYYY-MM-DD", $today)
        Set-Content -Path $tasksTarget -Value $txt -Encoding UTF8
        Write-Host "Da tao TASKS.md cho $InitialEpic" -ForegroundColor Green
    }
}

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "KHOI TAO THANH CONG HE THONG DAC TA docs/specs/ !" -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Cyan
