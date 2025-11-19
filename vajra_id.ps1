# get_vajra_machine_id.ps1


$u = (Get-CimInstance Win32_ComputerSystemProduct).UUID
$v = (cmd /c "vol C:" | Select-String "Serial Number is").ToString().Split()[-1]

# Compute SHA-256 hash and take first 12 uppercase hex chars
$h = [System.BitConverter]::ToString(
        [System.Security.Cryptography.SHA256]::Create().ComputeHash(
            [System.Text.Encoding]::UTF8.GetBytes("$u$v")
        )
     ).Replace("-", "")

$machineID = $h.Substring(0,12).ToUpper()

Write-Host ""
Write-Host "===== Vajra Machine ID ====="
Write-Host $machineID -ForegroundColor Cyan
Write-Host ""
Write-Host "Copy and paste this ID into the activation form."
Write-Host ""
Pause
