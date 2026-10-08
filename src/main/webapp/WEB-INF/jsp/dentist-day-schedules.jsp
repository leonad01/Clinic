<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>รายการนัด | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"><link href="${pageContext.request.contextPath}/css/clinic.css?v=17" rel="stylesheet">
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5 dentist-workspace">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
      <div><span class="eyebrow">DAILY SCHEDULE</span><h1 class="h2 mb-1">ตารางวันที่ ${scheduleDate}</h1><p class="text-secondary mb-0">แสดงทั้งช่วงเวลาว่างและช่วงที่มีนัดหมาย</p></div>
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/dentist/schedules">← กลับหน้าสรุป</a>
    </div>
    <div class="card shadow-sm border-0 overflow-hidden"><div class="table-responsive"><table class="table align-middle mb-0">
      <thead><tr><th>เวลา</th><th>ผู้ป่วย / บริการ</th><th>ห้องตรวจ</th><th>สถานะเคส</th></tr></thead>
      <tbody><c:forEach items="${schedules}" var="schedule"><tr>
        <td class="fw-semibold text-nowrap">${schedule.startTime} - ${schedule.endTime}</td><td><c:choose><c:when test="${not empty schedule.appointment}"><a class="fw-semibold" href="${pageContext.request.contextPath}/dentist/schedules/${schedule.id}">${schedule.appointment.patientName}</a><br><small class="text-secondary">${schedule.appointment.service}</small></c:when><c:otherwise><span class="text-secondary">ว่าง</span></c:otherwise></c:choose></td><td>${schedule.room.name}</td>
        <td><c:choose><c:when test="${not empty schedule.appointment}"><span class="status-pill status-${schedule.appointment.status}">${statusLabel.appointment(schedule.appointment.status)}</span></c:when><c:otherwise><span class="status-pill status-${schedule.status}">${statusLabel.schedule(schedule.status)}</span></c:otherwise></c:choose></td>
      </tr></c:forEach><c:if test="${empty schedules}"><tr><td colspan="4" class="text-center py-5 text-secondary">ไม่พบตารางทำการในวันนี้</td></tr></c:if></tbody>
    </table></div></div>
  </main>
</body>
</html>
