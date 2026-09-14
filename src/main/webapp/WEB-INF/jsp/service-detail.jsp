<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>รายละเอียดบริการ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <main class="container py-5">
    <div class="card shadow-sm p-4 p-md-5 col-lg-8 mx-auto">
      <span class="text-primary fw-semibold">บริการทันตกรรม</span>
      <h1 class="h2 mt-2">${service.name}</h1>
      <p class="text-secondary">${empty service.description ? 'สอบถามรายละเอียดเพิ่มเติมกับทางคลินิกได้' : service.description}</p>
      <dl class="row mt-4 mb-0">
        <dt class="col-sm-4">หมวดหมู่</dt><dd class="col-sm-8">${empty service.category ? '-' : service.category}</dd>
        <dt class="col-sm-4">ระยะเวลาโดยประมาณ</dt><dd class="col-sm-8">${empty service.duration ? '-' : service.duration}</dd>
        <dt class="col-sm-4">ราคาเริ่มต้น</dt><dd class="col-sm-8 fw-semibold">${service.price} บาท</dd>
      </dl>
      <div class="border-top pt-3 mt-4">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">เข้าสู่ระบบเพื่อจองคิว</a>
        <a class="btn btn-link" href="${pageContext.request.contextPath}/services">กลับรายการบริการ</a>
      </div>
    </div>
  </main>
</body>
</html>
