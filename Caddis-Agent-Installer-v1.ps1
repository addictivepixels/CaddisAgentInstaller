# This will force PowerShell to use TLS 1.2 just in case TLS 1.0 or 1.1 is active, and we know how bad that is :)
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

#Setup temp folders just in-case
New-Item -Path 'C:\temp' -ItemType Directory -force
New-Item -Path 'C:\temp\caddis' -ItemType Directory -force

# Delete any previous Caddis zips
Remove-Item 'C:\temp\caddis-agent-v1.zip' -Force -WarningAction SilentlyContinue

# Download Agent
$Url = 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 

# Unzip and tidy up
Expand-Archive -LiteralPath 'C:\temp\caddis-agent-v1.zip' -DestinationPath 'C:\temp\caddis\' -Force
Remove-Item 'C:\temp\caddis-agent-v1.zip' -Force -WarningAction SilentlyContinue

# Install agent
msiexec.exe /i "C:\temp\caddis\Setup-Windows-SilentMSI.msi" /qn

# Sleep for little bit to ensure subprocesses can do their thing...
sleep 10
