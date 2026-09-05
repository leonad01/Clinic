<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ตารางงานทันตแพทย์ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <h1 class="h2">เลือกวันนัดหมาย</h1>
    <p class="text-secondary">เลือกวันที่เพื่อดูตารางเวลาและรายละเอียดเคส</p>
    <div class="card shadow-sm mt-3">
      <div class="table-responsive">
        <table class="table align-middle mb-0">
          <thead>
            <tr>
              <th>วันที่</th>
              <th>จำนวนช่วงเวลา</th>
              <th>เคสที่รอทำ</th>
              <th>ทำแล้ว</th>
              <th class="text-end">ตารางเวลา</th>
          </tr>
      </thead>
    <tbody>
      <c:forEach items="${schedulesByDate}" var="day">
        <tr>
          <td class="fw-semibold">${day.key}</td>
          <td>${day.value.size()} ช่วงเวลา</td>
          <td>
            <c:set var="pendingCases" value="0" />
            <c:forEach items="${day.value}" var="schedule"><c:if test="${not empty schedule.appointment && schedule.appointment.status == 'APPROVED'}"><c:set var="pendingCases" value="${pendingCases + 1}" /></c:if></c:forEach>
            ${pendingCases} เคส
          </td>
          <td>
            <c:set var="completedCases" value="0" />
            <c:forEach items="${day.value}" var="schedule"><c:if test="${not empty schedule.appointment && schedule.appointment.status == 'COMPLETED'}"><c:set var="completedCases" value="${completedCases + 1}" /></c:if></c:forEach>
            ${completedCases} เคส
          </td>
          <td class="text-end"><a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/dentist/schedules/date/${day.key}">ดูตารางเวลา</a></td>
        </tr>
      </c:forEach>
<c:if test="${empty schedulesByDate}">
  <tr>
    <td colspan="5" class="text-center text-secondary py-4">ยังไม่มีตารางงาน</td>
  </tr>
</c:if>
</tbody>
</table>
</div>
</div>
</main>
</body>
</html>
