# Run the app on Windows

1. Install Java 21 and start MySQL. Ensure database credentials in
   `src/main/resources/application.properties` are correct.
2. Open PowerShell in this folder and run:
   `powershell -ExecutionPolicy Bypass -File .\run-app.ps1`
   
   The script stops the old web server on port 8086 first, then starts the
   project with `spring-boot:run`. This avoids the Maven error caused by a
   running server locking the `.war` file.
3. Open:
   `http://localhost:8086/`

The app uses MySQL database `dental_booking`.
