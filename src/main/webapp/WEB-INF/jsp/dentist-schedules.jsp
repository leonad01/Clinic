<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>ตารางนัดของฉัน | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/clinic.css?v=19" rel="stylesheet">
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5 dentist-workspace">
    <section class="dentist-hero mb-4">
      <div>
        <span class="eyebrow">DENTIST WORKSPACE</span>
        <h1 class="h2 mb-2">ตารางนัดของฉัน</h1>
        <p class="mb-2">ทันตแพทย์: <strong>${loggedInDentist.firstName} ${loggedInDentist.lastName}</strong></p>
        <p class="text-secondary mb-0">แสดงตารางครั้งละไม่เกิน 7 วัน กดชื่อผู้ป่วยเพื่อดูรายละเอียดและดำเนินการรักษา</p>
      </div>
      <span class="appointment-count">${schedulesByDate.size()} จาก ${totalDays} วันทำการ</span>
    </section>

    <section class="appointment-calendar" aria-labelledby="appointment-calendar-title">
      <div class="appointment-calendar__header">
        <div>
          <span class="eyebrow">APPOINTMENT CALENDAR</span>
          <h2 id="appointment-calendar-title" class="h5 mb-0">ตารางนัดหมายผู้ป่วย</h2>
        </div>
        <form class="schedule-date-filter" method="get" action="${pageContext.request.contextPath}/dentist/schedules">
          <label for="startDate">เริ่มแสดงวันที่</label>
          <input id="startDate" name="startDate" type="date" value="${selectedStartDate}">
          <button class="btn btn-sm btn-primary" type="submit">แสดง</button>
        </form>
      </div>
      <div class="appointment-calendar__toolbar">
        <span class="text-secondary small">ช่วงเวลาว่างแสดงด้วยคำว่า “ว่าง”</span>
        <div class="d-flex gap-2">
          <c:choose><c:when test="${not empty previousStartDate}"><a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/dentist/schedules?startDate=${previousStartDate}">← 7 วันก่อนหน้า</a></c:when><c:otherwise><span class="btn btn-sm btn-outline-secondary disabled">← 7 วันก่อนหน้า</span></c:otherwise></c:choose>
          <c:choose><c:when test="${not empty nextStartDate}"><a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/dentist/schedules?startDate=${nextStartDate}">7 วันถัดไป →</a></c:when><c:otherwise><span class="btn btn-sm btn-outline-secondary disabled">7 วันถัดไป →</span></c:otherwise></c:choose>
        </div>
      </div>
      <div class="table-responsive appointment-grid-wrap">
        <table class="table appointment-grid align-middle mb-0">
          <thead><tr><th scope="col">วันนัด</th><c:forEach items="${timeSlots}" var="timeSlot"><th scope="col">${timeSlot}</th></c:forEach></tr></thead>
          <tbody><c:forEach items="${schedulesByDate}" var="day"><tr>
            <th scope="row" class="appointment-grid__date">${day.key}</th>
            <c:forEach items="${timeSlots}" var="timeSlot"><c:set var="schedule" value="${day.value[timeSlot]}" />
              <td><c:choose><c:when test="${not empty schedule && not empty schedule.appointment}"><article class="appointment-grid__card">
                <a class="appointment-grid__patient" href="${pageContext.request.contextPath}/dentist/schedules/${schedule.id}">${schedule.appointment.patientName}</a>
                <span class="appointment-grid__service">${schedule.appointment.service}</span>
                <span class="status-pill status-${schedule.appointment.status}">${statusLabel.appointment(schedule.appointment.status)}</span>
              </article></c:when><c:when test="${not empty schedule}"><article class="appointment-grid__card appointment-grid__card--available">
                <strong class="appointment-grid__available">+ ว่าง</strong>
                <span class="appointment-grid__service">${schedule.room.name}</span>
                <span class="status-pill status-${schedule.status}">${statusLabel.schedule(schedule.status)}</span>
              </article></c:when><c:otherwise><span class="appointment-grid__empty">—</span></c:otherwise></c:choose></td>
            </c:forEach>
          </tr></c:forEach></tbody>
        </table>
      </div>
      <c:if test="${empty schedulesByDate}">
        <div class="appointment-calendar__empty text-center">
          <div class="fs-5 fw-semibold text-dark mb-1">ยังไม่มีตารางทำการ</div>
          <span class="text-secondary">เมื่อตั้งตารางทำการแล้ว ตารางจะแสดงที่นี่</span>
        </div>
      </c:if>
    </section>
  </main>
</body>
</html>
