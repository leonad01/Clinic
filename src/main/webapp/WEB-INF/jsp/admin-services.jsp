<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>จัดการบริการ | SmileCare</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"><link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet"></head>
  <body class="bg-light">
    <%@ include file="includes/clinic-userbar.jspf" %>
    <main class="container py-5">
    <div class="d-flex justify-content-between"><h1 class="h2">จัดการบริการ</h1><a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/rooms">จัดการห้อง</a></div>
    <div class="card shadow-sm p-4 mt-3"><form action="${pageContext.request.contextPath}/admin/services" method="post" class="row g-2"><div class="col-md-2"><input class="form-control" name="name" placeholder="ชื่อบริการ" required></div><div class="col-md-1"><input class="form-control" name="price" placeholder="ราคา" required></div><div class="col-md-2"><input class="form-control" name="duration" placeholder="ระยะเวลา"></div><div class="col-md-2"><input class="form-control" name="category" placeholder="หมวดหมู่"></div><div class="col-md-4"><input class="form-control" name="description" placeholder="คำอธิบายบริการ"></div><div class="col-md-1"><button class="btn btn-primary w-100">เพิ่ม</button></div></form></div>
    <div class="card shadow-sm mt-3"><div class="table-responsive"><table class="table mb-0"><thead><tr><th>บริการ</th><th>ราคา</th><th>ระยะเวลา</th><th>หมวดหมู่</th><th>คำอธิบาย</th></tr></thead><tbody><c:forEach items="${services}" var="service"><tr><td>${service.name}</td><td>${service.price}</td><td>${service.duration}</td><td>${service.category}</td><td>${service.description}</td></tr></c:forEach></tbody></table></div></div>
  </main></body>
</html>
