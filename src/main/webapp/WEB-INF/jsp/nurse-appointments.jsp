<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>จัดการนัดหมาย</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=11" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between align-items-center">
      <div>
        <h1 class="h2">คำขอนัดหมาย</h1>
        <p class="text-secondary">จัดการ เพิ่ม แก้ไข อนุมัติ หรือปฏิเสธนัดหมาย</p>
      </div>
    <div class="nurse-header-actions d-flex flex-wrap align-items-center gap-2">
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/patients">รายชื่อผู้ป่วย</a>
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/schedules">ตารางทันตแพทย์</a>
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/nurse/appointments/new">เพิ่มนัด</a>
    </div>
</div>
<div class="card shadow-sm mt-3">
  <div class="table-responsive">
    <table class="table align-middle mb-0">
      <thead>
        <tr>
          <th>ผู้ป่วย</th>
          <th>วัน/เวลา</th>
          <th>บริการ</th>
          <th>สถานะ</th>
          <th>ดำเนินการ</th>
        </tr>
    </thead>
  <tbody>
    <c:forEach items="${appointments}" var="item">
      <tr>
        <td>${item.patientName}</td>
        <td>${item.appointmentDate} ${item.appointmentTime}</td>
        <td>${item.service}</td>
        <td><span class="status-pill status-${item.status}">${item.status}</span></td>
        <td>
          <a class="btn btn-sm btn-outline-primary" data-detail-modal href="${pageContext.request.contextPath}/nurse/appointments/${item.id}">ดูรายละเอียด</a>
          <form class="d-inline" action="${pageContext.request.contextPath}/nurse/appointments/${item.id}/approve" method="post">
            <button class="btn btn-sm btn-success">อนุมัติ</button>
          </form>
    </td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</main>
<%@ include file="includes/detail-modal.jspf" %>
</body>
</html>
