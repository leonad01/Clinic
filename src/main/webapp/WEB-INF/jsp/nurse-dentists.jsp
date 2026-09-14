<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>รายชื่อทันตแพทย์ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between align-items-center">
      <div>
        <h1 class="h2 mb-1">รายชื่อทันตแพทย์</h1>
        <p class="text-secondary mb-0">ใช้ตรวจสอบรายชื่อก่อนจัดตารางงาน</p>
      </div>
    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/schedules">ตารางทันตแพทย์</a>
  </div>
<div class="card shadow-sm mt-3">
  <div class="table-responsive">
    <table class="table align-middle mb-0">
      <thead>
        <tr>
          <th>ชื่อ-นามสกุล</th>
          <th>Username</th>
          <th>โทรศัพท์</th>
          <th>อีเมล</th>
        </tr>
    </thead>
  <tbody>
    <c:forEach items="${dentists}" var="dentist">
      <tr>
        <td>${dentist.firstName} ${dentist.lastName}</td>
        <td>${dentist.username}</td>
        <td>${dentist.phone}</td>
        <td>${dentist.email}</td>
      </tr>
  </c:forEach>
<c:if test="${empty dentists}">
  <tr>
    <td colspan="4" class="text-center text-secondary py-4">ยังไม่มีข้อมูลทันตแพทย์</td>
  </tr>
</c:if>
</tbody>
</table>
</div>
</div>
</main>
</body>
</html>
