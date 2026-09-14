<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ตารางทันตแพทย์ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
      <div>
        <h1 class="h2 mb-1">เลือกทันตแพทย์</h1>
        <p class="text-secondary mb-0">เลือกชื่อทันตแพทย์เพื่อดูและจัดการตารางเวลาของแต่ละคน</p>
      </div>
    <div class="d-flex gap-2">
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/nurse/schedules/new">เพิ่มตาราง</a>
    </div>
</div>
<div class="card shadow-sm mt-3">
  <div class="table-responsive">
    <table class="table align-middle mb-0">
      <thead>
        <tr><th>ทันตแพทย์</th><th>ชื่อผู้ใช้</th><th>เบอร์โทรศัพท์</th><th class="text-end">ตารางเวลา</th></tr>
  </thead>
<tbody>
  <c:forEach items="${dentists}" var="dentist">
    <tr>
      <td class="fw-semibold">${dentist.firstName} ${dentist.lastName}</td>
      <td>${dentist.username}</td>
      <td>${empty dentist.phone ? '-' : dentist.phone}</td>
      <td class="text-end"><a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/nurse/schedules/dentist/${dentist.id}">ดูตารางเวลา</a></td>
  </tr>
</c:forEach>
<c:if test="${empty dentists}">
  <tr>
    <td colspan="4" class="text-center text-secondary py-4">ยังไม่มีรายชื่อทันตแพทย์</td>
  </tr>
</c:if>
</tbody>
</table>
</div>
</div>
<a class="d-inline-block mt-3" href="${pageContext.request.contextPath}/nurse/appointments">กลับรายการนัดหมาย</a>
</main>
</body>
</html>
