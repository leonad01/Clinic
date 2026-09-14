<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ตารางเวลาทันตแพทย์ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between align-items-center gap-3">
      <div>
        <h1 class="h2 mb-1">ตารางเวลา วันที่ ${scheduleDate}</h1>
        <p class="text-secondary mb-0">กดดูรายละเอียดเพื่อเปิดข้อมูลเคส</p>
      </div>
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/dentist/schedules">← เลือกวันอื่น</a>
    </div>
    <div class="card shadow-sm mt-3">
      <div class="table-responsive">
        <table class="table align-middle mb-0">
          <thead><tr><th>เวลา</th><th>ห้องตรวจ</th><th>ผู้ป่วย / บริการ</th><th>สถานะเคส</th><th class="text-end">รายละเอียด</th></tr></thead>
          <tbody>
            <c:forEach items="${schedules}" var="schedule">
              <tr class="${not empty schedule.appointment ? 'table-info' : ''}">
                <td class="fw-semibold">${schedule.startTime} - ${schedule.endTime}</td>
                <td>${schedule.room.name}</td>
                <td><c:choose><c:when test="${not empty schedule.appointment}"><div class="fw-semibold">${schedule.appointment.patientName}</div><small class="text-secondary">${schedule.appointment.service}</small></c:when><c:otherwise><span class="text-secondary">ยังไม่มีผู้จอง</span></c:otherwise></c:choose></td>
                <td><c:choose><c:when test="${empty schedule.appointment}"><span class="status-pill status-AVAILABLE">ว่าง</span></c:when><c:when test="${schedule.appointment.status == 'PENDING'}"><span class="status-pill status-PENDING">รออนุมัติ</span></c:when><c:when test="${schedule.appointment.status == 'APPROVED'}"><span class="status-pill status-APPROVED">รอทำ</span></c:when><c:when test="${schedule.appointment.status == 'COMPLETED'}"><span class="status-pill status-COMPLETED">ทำแล้ว</span></c:when><c:when test="${schedule.appointment.status == 'CANCELLED'}"><span class="status-pill status-CANCELLED">ยกเลิกแล้ว</span></c:when><c:otherwise><span class="status-pill status-REJECTED">ปฏิเสธแล้ว</span></c:otherwise></c:choose></td>
                <td class="text-end"><a class="btn btn-sm btn-outline-primary" data-detail-modal href="${pageContext.request.contextPath}/dentist/schedules/${schedule.id}">ดูรายละเอียด</a></td>
              </tr>
            </c:forEach>
            <c:if test="${empty schedules}"><tr><td colspan="5" class="text-center text-secondary py-4">ไม่พบตารางเวลาของวันนี้</td></tr></c:if>
          </tbody>
        </table>
      </div>
    </div>
  </main>
  <%@ include file="includes/detail-modal.jspf" %>
</body>
</html>
