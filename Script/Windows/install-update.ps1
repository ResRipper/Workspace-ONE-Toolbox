# Offline Windows update package can be found on:
# https://www.catalog.update.microsoft.com
# Or WSUS server

$url = ""
$kb = ""
$wkdir = "C:\tmp\"

Start-Transcript -Path $wkdir+"update.log"

# Download msu file
Invoke-WebRequest $url -OutFile $wkdir+"update.msu"
# Install
Start-Process -FilePath "wusa.exe" `
    -ArgumentList $wkdir+"update.msu", /quiet, /norestart, log `
    -NoNewWindow -Wait

# Clean-up
if ((wmic qfe list | findstr.exe $kb) -ne "") {
    Remove-Item $wkdir+"update.msu"
}

Stop-Transcript