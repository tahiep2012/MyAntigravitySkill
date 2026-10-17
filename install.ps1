# ==============================================================================
# ANTIGRAVITY SKILLS SUITE - ONE-CLICK INSTALLER TOOL (v2.0.0)
# Tu dong cai dat 11 Skill chuan muc vao Google Antigravity tren moi may tinh.
# ==============================================================================

param(
    [switch]$CoreOnly,
    [switch]$AntiSlopOnly,
    [switch]$All,
    [switch]$Force
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Antigravity Skills Suite Installer"

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "   ANTIGRAVITY SKILLS SUITE - CONG CU CAI DAT TU DONG 11 SKILLS                 " -ForegroundColor Yellow
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
$architecturalSkills = @(
    @{ Name = "explicit-confirmation-gate"; Desc = "Cong kiem soat hanh vi (Xac nhan ro rang truoc khi sua code)" },
    @{ Name = "qa-verification";            Desc = "Cong kiem dinh chat luong 5 tang (Pass 100% test truoc khi build)" },
    @{ Name = "modular-architecture";       Desc = "Kien truc module hoa chong ky sinh va bao ve zero-regression" },
    @{ Name = "spec-driven-development";    Desc = "Phat trien theo dac ta va mo neo dia cung chong quen ke hoach" },
    @{ Name = "ui-design-system";           Desc = "He thong chuan hoa giao dien UI/UX va dac ta truoc khi code" }
)

$antislopSkills = @(
    @{ Name = "antislop";                   Desc = "Bo loc loi Anti-Slop: Loai bo thiet ke rap khuon va mac dinh cua AI" },
    @{ Name = "antislop-ui";                Desc = "Tham my UI cao cap: Loai bo mau neon, glow va card lo lung vo nghia" },
    @{ Name = "antislop-code";              Desc = "Ve sinh comment code: Don sach comment rac ma khong sua logic code" },
    @{ Name = "antislop-copywriting";       Desc = "Van phong tu nhien: Loai bo cac sao ngu buzzwords kinh dien cua AI" },
    @{ Name = "antislop-human";             Desc = "Toi uu cho nguoi dung thuc (WCAG contrast check, keyboard focus, states)" },
    @{ Name = "antislop-layoutmobile";      Desc = "Bo cuc da man hinh di dong (Responsive, chong tran ngang, tap target)" }
)

# 3. Lua chon che do cai dat
$selectedSkills = @()

if ($CoreOnly) {
    $selectedSkills = $architecturalSkills
    Write-Host "Che do: Cai dat Bo 5 Tru Cot Kien Truc (The Five Pillars)" -ForegroundColor Yellow
} elseif ($AntiSlopOnly) {
    $selectedSkills = $antislopSkills
    Write-Host "Che do: Cai dat Bo 6 Ky Nang Anti-Slop (Anti-Slop Suite)" -ForegroundColor Yellow
} elseif ($All) {
    $selectedSkills = $architecturalSkills + $antislopSkills
    Write-Host "Che do: Cai dat TRON BO 11 SKILLS (Full 11-Skills Suite)" -ForegroundColor Yellow
} else {
    Write-Host "Vui long chon bo ky nang muon cai dat vao Antigravity:" -ForegroundColor White
    Write-Host "  [1] Cai dat Bo 5 Tru Cot Kien Truc (The Five Pillars)" -ForegroundColor Cyan
    Write-Host "  [2] Cai dat Bo 6 Ky Nang Anti-Slop (Anti-Slop Suite)" -ForegroundColor Cyan
    Write-Host "  [3] Cai dat TRON BO TOAN DIEN 11 SKILLS (Khuyen nghi cho moi may tinh)" -ForegroundColor Green
    Write-Host "  [Q] Huy bo va thoat" -ForegroundColor Red
    Write-Host ""
    $choice = Read-Host "Nhap lua chon cua ban [1/2/3/Q] (Mac dinh: 3)"
    if ([string]::IsNullOrWhiteSpace($choice)) { $choice = "3" }

    switch ($choice.Trim().ToUpper()) {
        "1" { $selectedSkills = $architecturalSkills }
        "2" { $selectedSkills = $antislopSkills }
        "3" { $selectedSkills = $architecturalSkills + $antislopSkills }
        "Q" {
            Write-Host "Da huy thao tac cai dat." -ForegroundColor Yellow
            Exit 0
        }
        Default { $selectedSkills = $architecturalSkills + $antislopSkills }
    }
}

Write-Host ""
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Gray
Write-Host "Bat dau tien trinh cai dat $($selectedSkills.Count) Skill..." -ForegroundColor Cyan

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
    Write-Host "   3. Toan bo 11 skill se hien thi ngay trong danh sach Global Skills." -ForegroundColor Gray
} else {
    Write-Host "Hoan tat voi canh bao: $successCount thanh cong, $failCount loi." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
