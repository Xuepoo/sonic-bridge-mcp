# install.ps1 — SonicBridge MCP Installer for Windows PowerShell
$ErrorActionPreference = "Stop"

Write-Host "SonicBridge MCP - High-Performance Windows Installer" -ForegroundColor Magenta
Write-Host "=========================================================" -ForegroundColor Magenta

# 1. Compiling release binary
Write-Host "[*] Step 1: Compiling Rust MCP Server in release mode..." -ForegroundColor Cyan
& cargo build --release

# 2. Local installation path ($env:USERPROFILE\.local\bin)
$BinDir = Join-Path $env:USERPROFILE ".local\bin"
Write-Host "[*] Step 2: Creating local bin directory: $BinDir..." -ForegroundColor Cyan
if (-not (Test-Path $BinDir)) {
    New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
}

$SourceExe = "target\release\sonic-bridge-mcp.exe"
$DestExe = Join-Path $BinDir "sonic-bridge-mcp.exe"

Write-Host "[*] Step 3: Installing binary..." -ForegroundColor Cyan
Copy-Item -Path $SourceExe -Destination $DestExe -Force

Write-Host "[+] Binary successfully installed to: $DestExe" -ForegroundColor Green

# 3. Handle Windows Environment PATH Auto-Injection
Write-Host "[*] Step 4: Verifying User Environment PATH..." -ForegroundColor Cyan
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
$Paths = $UserPath -split ";"

if ($Paths -notcontains $BinDir -and $Paths -notcontains "$BinDir\") {
    Write-Host "[*] Adding $BinDir to User Environment PATH..." -ForegroundColor Yellow
    $NewUserPath = $UserPath + ";" + $BinDir
    # Remove duplicate semicolons if any
    $NewUserPath = $NewUserPath -replace ';;', ';'
    [Environment]::SetEnvironmentVariable("Path", $NewUserPath, "User")
    Write-Host "[+] PATH environment variable updated successfully!" -ForegroundColor Green
    Write-Host "[!] Note: You may need to restart your terminal/IDE for the PATH changes to take effect." -ForegroundColor Yellow
} else {
    Write-Host "[+] $BinDir is already in your PATH." -ForegroundColor Green
}

Write-Host "=========================================================" -ForegroundColor Magenta
Write-Host "[+] Installation Succeeded!" -ForegroundColor Green
Write-Host "[!] Claude Desktop config location on Windows:" -ForegroundColor Yellow
Write-Host "    `$env:APPDATA\Claude\claude_desktop_config.json" -ForegroundColor Yellow
Write-Host "    (C:\Users\<Name>\AppData\Roaming\Claude\claude_desktop_config.json)" -ForegroundColor Yellow
Write-Host "[!] Example config entry (JSON):" -ForegroundColor Yellow
Write-Host @"
{
  "mcpServers": {
    "sonic-bridge-mcp": {
      "command": "$($DestExe.Replace('\', '\\'))",
      "args": []
    }
  }
}
"@ -ForegroundColor Yellow
