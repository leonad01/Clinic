<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>รายละเอียดบุคลากร | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <main class="container py-5">
    <div class="card shadow-sm p-4 col-lg-8 mx-auto">
      <span class="text-primary fw-semibold">ข้อมูลบุคลากร</span>
      <h1 class="h3 mt-2">${staff.firstName} ${staff.lastName}</h1>
      <dl class="row mt-4 mb-0">
        <dt class="col-sm-4">ตำแหน่ง</dt><dd class="col-sm-8">${staffRole}</dd>
        <dt class="col-sm-4">ชื่อผู้ใช้</dt><dd class="col-sm-8">${staff.username}</dd>
        <dt class="col-sm-4">เบอร์โทรศัพท์</dt><dd class="col-sm-8">${empty staff.phone ? '-' : staff.phone}</dd>
        <dt class="col-sm-4">อีเมล</dt><dd class="col-sm-8">${empty staff.email ? '-' : staff.email}</dd>
      </dl>
      <a class="btn btn-link mt-3" href="${pageContext.request.contextPath}/admin/staff">กลับหน้าจัดการบุคลากร</a>
    </div>
  </main>
</body>
</html>
