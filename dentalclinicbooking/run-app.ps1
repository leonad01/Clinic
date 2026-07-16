$projectPath = 'd:\ProjectCL\dentalclinicbooking'
Set-Location $projectPath

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Host 'Java 17 or newer is required. Install Java and add it to PATH.' -ForegroundColor Red
    exit 1
}

if (-not (Test-Path '.\mvnw.cmd')) {
    Write-Host 'Maven wrapper (mvnw.cmd) was not found.' -ForegroundColor Red
    exit 1
}

Write-Host 'Starting Dental Clinic Booking app...' -ForegroundColor Green
.\mvnw.cmd spring-boot:run
