# Script Kiem Tra Tinh Doc Lap Giua Cac Module Trong Du An (Verify Modularity)
param (
    [string]$SrcPath = "src"
)

Write-Host "[*] Dang kiem tra tinh doc lap cac module trong: $SrcPath ..." -ForegroundColor Cyan

$modulesDir = Join-Path $SrcPath "modules"
if (!(Test-Path $modulesDir)) {
    Write-Host "[!] Khong tim thay thu muc modules tai $modulesDir" -ForegroundColor Yellow
    exit 0
}

$modules = Get-ChildItem -Path $modulesDir -Directory
Write-Host "[+] Phat hien $($modules.Count) module nghiep vu: $($modules.Name -join ', ')" -ForegroundColor Gray

$violationCount = 0

foreach ($mod in $modules) {
    $modName = $mod.Name
    $files = Get-ChildItem -Path $mod.FullName -Recurse -Include *.ts, *.tsx

    foreach ($file in $files) {
        $content = Get-Content -Path $file.FullName -Raw
        
        foreach ($otherMod in $modules) {
            if ($otherMod.Name -ne $modName) {
                $badPattern1 = "\.\./$($otherMod.Name)/components"
                $badPattern2 = "\.\./$($otherMod.Name)/hooks"
                
                if ($content -match $badPattern1 -or $content -match $badPattern2) {
                    Write-Host "[-] VI PHAM CO LAP: File '$($file.Name)' dang import truc tiep noi bo cua module '$($otherMod.Name)'!" -ForegroundColor Red
                    $violationCount++
                }
            }
        }
    }
}

if ($violationCount -eq 0) {
    Write-Host "[OK] XUAT SAC! Toan bo $($modules.Count) module deu dat chuan co lap 100%, khong co import cheo noi bo." -ForegroundColor Green
} else {
    Write-Host "[!] Phat hien $violationCount diem vi pham tinh dong goi. Vui long tach ra module rieng hoac dung Event Bus." -ForegroundColor Yellow
}