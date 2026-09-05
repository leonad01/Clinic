<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ไม่สามารถเข้าถึงหน้านี้ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <main class="container py-5">
    <div class="card shadow-sm p-4 p-md-5 col-lg-6 mx-auto text-center">
      <div class="fs-1 mb-3">🔒</div>
      <h1 class="h3">ไม่สามารถเข้าถึงหน้านี้ได้</h1>
      <p class="text-secondary mb-4">บัญชีที่กำลังเข้าสู่ระบบไม่มีสิทธิ์ใช้งานหน้านี้ หรือการเข้าสู่ระบบอาจหมดอายุแล้ว</p>
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/">กลับหน้าแรก</a>
      <a class="btn btn-outline-primary ms-2" href="${pageContext.request.contextPath}/login">เข้าสู่ระบบ</a>
    </div>
</main>
</body>
</html>
