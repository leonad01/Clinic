<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ตารางทันตแพทย์ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
      <div>
        <h1 class="h2 mb-1">ตารางทันตแพทย์</h1>
        <p class="text-secondary mb-0">จัดช่วงเวลา ห้องตรวจ และทันตแพทย์ที่เปิดให้ผู้ป่วยจอง</p>
      </div>
    <div class="d-flex gap-2">
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/dentists">รายชื่อทันตแพทย์</a>
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/nurse/schedules/new">เพิ่มตาราง</a>
    </div>
</div>
<div class="card shadow-sm mt-3">
  <div class="table-responsive">
    <table class="table align-middle mb-0">
      <thead>
        <tr>
          <th>วันที่</th>
          <th>เวลา</th>
          <th>ทันตแพทย์</th>
          <th>ห้อง</th>
          <th>สถานะ</th>
          <th>
          </th>
      </tr>
  </thead>
<tbody>
  <c:forEach items="${schedules}" var="schedule">
    <tr>
      <td>${schedule.scheduleDate}</td>
      <td>${schedule.startTime} - ${schedule.endTime}</td>
      <td>${schedule.dentist.firstName} ${schedule.dentist.lastName}</td>
      <td>${schedule.room.name}</td>
      <td><span class="status-pill status-${schedule.status}">${schedule.status}</span></td>
      <td>
        <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/nurse/schedules/${schedule.id}">แก้ไข</a>
      </td>
  </tr>
</c:forEach>
<c:if test="${empty schedules}">
  <tr>
    <td colspan="6" class="text-center text-secondary py-4">ยังไม่มีตารางทันตแพทย์</td>
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
