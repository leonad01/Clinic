$projectPath = 'd:\ProjectCL\dentalclinicbooking'
Set-Location $projectPath

# Stop only the process that is currently using this project's web port.
# This prevents Maven from trying to replace a WAR file that is still in use.
$runningApp = Get-NetTCPConnection -LocalPort 8086 -State Listen -ErrorAction SilentlyContinue
if ($runningApp) {
    Write-Host 'Stopping the previous SmileCare web server...' -ForegroundColor Yellow
    Stop-Process -Id $runningApp.OwningProcess -Force
    Start-Sleep -Seconds 1
}

# Use the Java runtime bundled with VS Code when it is available.
$bundledJavaHome = 'C:\Users\ROG\.vscode\extensions\redhat.java-1.55.0-win32-x64\jre\21.0.11-win32-x86_64'
if (Test-Path "$bundledJavaHome\bin\java.exe") {
    $env:JAVA_HOME = $bundledJavaHome
    $env:Path = "$env:JAVA_HOME\bin;$env:Path"
}

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Host 'Java 17 or newer is required. Install Java and add it to PATH.' -ForegroundColor Red
    exit 1
}

if (-not (Test-Path '.\mvnw.cmd')) {
    Write-Host 'Maven wrapper (mvnw.cmd) was not found.' -ForegroundColor Red
    exit 1
}

Write-Host 'Starting Dental Clinic Booking app at http://localhost:8086 ...' -ForegroundColor Green
# Rebuild from scratch so stale classes compiled by a different Java version cannot prevent startup.
# spring-boot:run runs from compiled classes, so it does not lock target\*.war.
.\mvnw.cmd clean spring-boot:run
