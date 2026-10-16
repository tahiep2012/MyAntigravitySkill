# Script Kiem Tra Tinh Chuan Hoa Giao Dien (Audit UI Consistency)
param (
    [string]$SrcPath = "src"
)

Write-Host "[*] Dang quet kiem tra tinh chuan hoa UI/UX trong: $SrcPath ..." -ForegroundColor Cyan

$files = Get-ChildItem -Path $SrcPath -Recurse -Include *.tsx, *.jsx

$rawButtons = 0
$rawInputs = 0
$hexColors = 0

foreach ($file in $files) {
    # Skip ui component definition folder itself
    if ($file.FullName -match "components\\ui") { continue }

    $lines = Get-Content -Path $file.FullName
    $lineNum = 0

    foreach ($line in $lines) {
        $lineNum++
        
        # Check raw button tag with custom styles
        if ($line -match "<button\s+[^>]*className=") {
            $rawButtons++
        }

        # Check raw input tag with custom styles
        if ($line -match "<input\s+[^>]*className=" -and $line -notmatch 'type="checkbox"' -and $line -notmatch 'type="radio"') {
            $rawInputs++
        }

        # Check hardcoded hex colors
        if ($line -match "#[0-9a-fA-F]{6}" -and $line -notmatch "tailwind\.config") {
            $hexColors++
        }
    }
}

Write-Host "`n--- KET QUA QUET TIEU CHUAN UI/UX ---" -ForegroundColor Yellow
Write-Host "  - The <button> tu do: $rawButtons" -ForegroundColor Gray
Write-Host "  - The <input> tu do: $rawInputs" -ForegroundColor Gray
Write-Host "  - Ma mau HEX hardcoded: $hexColors" -ForegroundColor Gray

if ($rawButtons -eq 0 -and $rawInputs -eq 0 -and $hexColors -eq 0) {
    Write-Host "`n[OK] XUAT SAC! Du an dat tieu chuan Design System 100%!" -ForegroundColor Green
} else {
    Write-Host "`n[i] Khuyen nghi: Chuyen dan cac the <button> va <input> sang su dung @/components/ui de dam bao tinh nhat quan tuyet doi." -ForegroundColor Cyan
}
