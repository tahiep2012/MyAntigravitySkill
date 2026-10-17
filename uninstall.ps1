# ==============================================================================
# ANTIGRAVITY SKILLS SUITE - UNINSTALLER SCRIPT (v2.0.0)
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$targetBase = Join-Path $env:USERPROFILE ".gemini\config\skills"

Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "   ANTIGRAVITY SKILLS SUITE - TRINH GO CAI DAT 11 SKILLS TOAN CUC               " -ForegroundColor Red
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""

$skillsToRemove = @(
    "explicit-confirmation-gate",
    "qa-verification",
    "modular-architecture",
    "spec-driven-development",
    "ui-design-system",
    "antislop",
    "antislop-ui",
    "antislop-code",
    "antislop-copywriting",
    "antislop-human",
    "antislop-layoutmobile"
)

$confirm = Read-Host "Ban co chac chan muon go bo toan bo 11 skill nay khoi Antigravity khong? [Y/N]"
if ($confirm.Trim().ToUpper() -ne "Y") {
    Write-Host "Da huy thao tac." -ForegroundColor Cyan
    Exit 0
}

foreach ($s in $skillsToRemove) {
    $p = Join-Path $targetBase $s
    if (Test-Path -Path $p) {
        Remove-Item -Path $p -Recurse -Force
        Write-Host "Da xoa: $s" -ForegroundColor DarkGray
    }
}

Write-Host "Da go bo hoan tat!" -ForegroundColor Green
Write-Host ""
