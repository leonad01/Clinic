<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>จัดการห้อง</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between">
      <h1 class="h2">จัดการห้องตรวจ</h1>
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/staff">จัดการบุคลากร</a>
    </div>
  <div class="card shadow-sm p-4 mt-3">
    <h2 class="h5">เพิ่มห้อง</h2>
    <form action="${pageContext.request.contextPath}/admin/rooms" method="post" class="row g-2">
      <div class="col-md-5">
        <input class="form-control" name="name" placeholder="ชื่อห้อง" required>
      </div>
    <div class="col-md-5">
      <select class="form-select" name="status">
        <option value="AVAILABLE">พร้อมใช้งาน</option>
        <option value="UNAVAILABLE">ปิดใช้งาน</option>
      </select>
  </div>
<div class="col-md-2">
  <button class="btn btn-primary w-100">เพิ่ม</button>
</div>
</form>
</div>
<div class="card shadow-sm mt-3">
  <table class="table mb-0">
    <thead>
      <tr>
        <th>ห้อง</th>
        <th>สถานะ</th>
      </tr>
  </thead>
<tbody>
  <c:forEach items="${rooms}" var="room">
    <tr>
      <td>${room.name}</td>
      <td><span class="status-pill status-${room.status}">${room.status}</span></td>
    </tr>
</c:forEach>
</tbody>
</table>
</div>
</main>
</body>
</html>
