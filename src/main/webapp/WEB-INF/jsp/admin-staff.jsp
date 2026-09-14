<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>จัดการบุคลากร</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/admin-staff.js?v=1" defer></script>
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between">
      <h1 class="h2">จัดการบุคลากร</h1>
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/rooms">จัดการห้อง</a>
    </div>
  <div class="row g-3 mt-1">
    <div class="col-md-6">
      <div class="card p-4 shadow-sm">
        <h2 class="h5">เพิ่มพยาบาล</h2>
        <form action="${pageContext.request.contextPath}/admin/nurses" method="post" data-staff-form novalidate>
          <input class="form-control mb-2" name="username" placeholder="Username (อย่างน้อย 4 ตัว)" minlength="4" maxlength="30" autocomplete="off" required>
          <div class="input-group mb-2"><input class="form-control" name="password" type="password" placeholder="รหัสผ่าน (อย่างน้อย 8 ตัว)" minlength="8" autocomplete="new-password" required><button class="btn btn-outline-primary password-toggle" type="button" data-toggle-password aria-label="แสดงรหัสผ่าน" title="แสดงรหัสผ่าน"><span aria-hidden="true">👁</span></button></div>
          <input class="form-control mb-2" name="firstName" placeholder="ชื่อ" minlength="2" required>
          <input class="form-control mb-2" name="lastName" placeholder="นามสกุล" minlength="2" required>
          <input class="form-control mb-2" name="phone" placeholder="เบอร์โทร เช่น 0812345678" inputmode="tel">
          <input class="form-control mb-2" name="email" type="email" placeholder="อีเมล">
          <div class="small mb-2" data-form-message></div>
          <button class="btn btn-primary">บันทึกพยาบาล</button>
        </form>
    </div>
</div>
<div class="col-md-6">
  <div class="card p-4 shadow-sm">
    <h2 class="h5">เพิ่มทันตแพทย์</h2>
    <form action="${pageContext.request.contextPath}/admin/dentists" method="post" data-staff-form novalidate>
      <input class="form-control mb-2" name="username" placeholder="Username (อย่างน้อย 4 ตัว)" minlength="4" maxlength="30" autocomplete="off" required>
      <div class="input-group mb-2"><input class="form-control" name="password" type="password" placeholder="รหัสผ่าน (อย่างน้อย 8 ตัว)" minlength="8" autocomplete="new-password" required><button class="btn btn-outline-primary password-toggle" type="button" data-toggle-password aria-label="แสดงรหัสผ่าน" title="แสดงรหัสผ่าน"><span aria-hidden="true">👁</span></button></div>
      <input class="form-control mb-2" name="firstName" placeholder="ชื่อ" minlength="2" required>
      <input class="form-control mb-2" name="lastName" placeholder="นามสกุล" minlength="2" required>
      <input class="form-control mb-2" name="phone" placeholder="เบอร์โทร เช่น 0812345678" inputmode="tel">
      <input class="form-control mb-2" name="email" type="email" placeholder="อีเมล">
      <div class="small mb-2" data-form-message></div>
      <button class="btn btn-primary">บันทึกทันตแพทย์</button>
    </form>
</div>
</div>
</div>
<div class="row g-3 mt-1">
  <div class="col-md-6">
    <div class="card p-3">
      <h2 class="h5">พยาบาล</h2>
      <ul class="mb-0">
        <c:forEach items="${nurses}" var="n">
          <li><a data-detail-modal href="${pageContext.request.contextPath}/admin/staff/nurses/${n.id}">${n.firstName} ${n.lastName}</a> <span class="text-secondary">(${n.username})</span></li>
        </c:forEach>
    </ul>
</div>
</div>
<div class="col-md-6">
  <div class="card p-3">
    <h2 class="h5">ทันตแพทย์</h2>
    <ul class="mb-0">
      <c:forEach items="${dentists}" var="d">
        <li><a data-detail-modal href="${pageContext.request.contextPath}/admin/staff/dentists/${d.id}">${d.firstName} ${d.lastName}</a> <span class="text-secondary">(${d.username})</span></li>
      </c:forEach>
  </ul>
</div>
</div>
</div>
</main>
<%@ include file="includes/detail-modal.jspf" %>
</body>
</html>
