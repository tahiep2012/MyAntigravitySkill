# ==============================================================================
# ANTIGRAVITY SKILLS SUITE - ONE-CLICK INSTALLER TOOL
# Tu dong cai dat cac Skill chuan muc vao Google Antigravity tren moi may tinh.
# ==============================================================================

param(
    [switch]$CoreOnly,
    [switch]$All,
    [switch]$Force
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Antigravity Skills Suite Installer"

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "   ANTIGRAVITY SKILLS SUITE - CONG CU CAI DAT TU DONG CHO MAY TINH MOI         " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Xac dinh duong dan nguon va dich
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$targetBase = Join-Path $env:USERPROFILE ".gemini\config\skills"

Write-Host "Thu muc nguon (Installer Source): " -NoNewline -ForegroundColor Gray
Write-Host $scriptDir -ForegroundColor White
Write-Host "Thu muc dich (Antigravity Target): " -NoNewline -ForegroundColor Gray
Write-Host $targetBase -ForegroundColor Green
Write-Host ""

# 2. Dinh nghia danh sach cac Skill
$coreSkills = @(
    @{ Name = "explicit-confirmation-gate"; Desc = "Cong kiem soat hanh vi (Xac nhan ro rang truoc khi sua code)" },
    @{ Name = "qa-verification";            Desc = "Cong kiem dinh chat luong 5 tang (Pass 100% test truoc khi build)" },
    @{ Name = "modular-architecture";       Desc = "Kien truc module hoa chong ky sinh va bao ve zero-regression" }
)

$extendedSkills = @(
    @{ Name = "spec-driven-development";    Desc = "Phat trien theo dac ta va mo neo dia cung chong quen ke hoach" },
    @{ Name = "ui-design-system";           Desc = "He thong chuan hoa giao dien UI/UX va Design Tokens hien dai" }
)

# 3. Lua chon che do cai dat
$selectedSkills = @()

if ($CoreOnly) {
    $selectedSkills = $coreSkills
    Write-Host "Che do: Cai dat 3 Skill cot loi (Core Only)" -ForegroundColor Yellow
} elseif ($All) {
    $selectedSkills = $coreSkills + $extendedSkills
    Write-Host "Che do: Cai dat toan bo 5 Skill (Full Suite)" -ForegroundColor Yellow
} else {
    Write-Host "Vui long chon bo ky nang muon cai dat vao Antigravity:" -ForegroundColor White
    Write-Host "  [1] Cai dat 3 Skill cot loi (explicit-confirmation-gate, qa-verification, modular-architecture)" -ForegroundColor Cyan
    Write-Host "  [2] Cai dat tron bo DAY DU 5 Skill (Khuyen nghi)" -ForegroundColor Green
    Write-Host "  [Q] Huy bo va thoat" -ForegroundColor Red
    Write-Host ""
    $choice = Read-Host "Nhap lua chon cua ban [1/2/Q] (Mac dinh: 2)"
    if ([string]::IsNullOrWhiteSpace($choice)) { $choice = "2" }

    switch ($choice.Trim().ToUpper()) {
        "1" { $selectedSkills = $coreSkills }
        "2" { $selectedSkills = $coreSkills + $extendedSkills }
        "Q" {
            Write-Host "Da huy thao tac cai dat." -ForegroundColor Yellow
            Exit 0
        }
        Default { $selectedSkills = $coreSkills + $extendedSkills }
    }
}

Write-Host ""
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Gray
Write-Host "Bat dau tien trinh cai dat..." -ForegroundColor Cyan

# 4. Tao thu muc dich neu chua co
if (-not (Test-Path -Path $targetBase)) {
    Write-Host "Khoi tao thu muc dich: $targetBase" -ForegroundColor Gray
    New-Item -ItemType Directory -Path $targetBase -Force | Out-Null
}

# 5. Sao chep tung Skill vao thu muc Antigravity
$successCount = 0
$failCount = 0

foreach ($skill in $selectedSkills) {
    $skillName = $skill.Name
    $skillDesc = $skill.Desc
    $srcPath = Join-Path $scriptDir $skillName
    $dstPath = Join-Path $targetBase $skillName

    if (-not (Test-Path -Path $srcPath)) {
        Write-Host "[BO QUA] Khong tim thay thu muc nguon: $skillName" -ForegroundColor Red
        $failCount++
        continue
    }

    Write-Host "Dang cai dat [$skillName]..." -ForegroundColor White
    Write-Host "   Giai thich: $skillDesc" -ForegroundColor DarkGray

    try {
        if (-not (Test-Path -Path $dstPath)) {
            New-Item -ItemType Directory -Path $dstPath -Force | Out-Null
        }

        Copy-Item -Path "$srcPath\*" -Destination $dstPath -Recurse -Force

        $skillMd = Join-Path $dstPath "SKILL.md"
        if (Test-Path -Path $skillMd) {
            Write-Host "   [OK] Cai dat thanh cong!" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "   [CANH BAO] Thieu file SKILL.md sau khi copy!" -ForegroundColor Yellow
            $failCount++
        }
    } catch {
        Write-Host "   [LOI] Sao chep that bai: $_" -ForegroundColor Red
        $failCount++
    }
}

Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Gray
Write-Host ""

# 6. Tong ket
$totalSelected = $selectedSkills.Count
if ($failCount -eq 0) {
    Write-Host "CHUC MUNG: CAI DAT THANH CONG $successCount/$totalSelected SKILLS VAO ANTIGRAVITY!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Cach kiem tra va kich hoat ngay:" -ForegroundColor White
    Write-Host "   1. Mo lai hoac mo cua so chat moi trong Antigravity IDE." -ForegroundColor Gray
    Write-Host "   2. Go hoi: Hien tai em co nhung skill nao?" -ForegroundColor Gray
    Write-Host "   3. Cac skill vua cai dat se hien thi ngay trong danh sach Global Skills." -ForegroundColor Gray
} else {
    Write-Host "Hoan tat voi canh bao: $successCount thanh cong, $failCount loi." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
