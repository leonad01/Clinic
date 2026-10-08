<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>ตารางทันตแพทย์ | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/clinic.css?v=19" rel="stylesheet">
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5 dentist-workspace">
    <section class="dentist-hero mb-4">
      <div>
        <span class="eyebrow">NURSE SCHEDULE MANAGEMENT</span>
        <h1 class="h2 mb-2">ตารางของ ${dentist.firstName} ${dentist.lastName}</h1>
        <p class="text-secondary mb-0">แสดงทุกวันและทุกช่วงเวลาทำการ กดแต่ละช่องเพื่อแก้ไขช่วงเวลา ห้องตรวจ หรือสถานะตาราง</p>
      </div>
      <div class="d-flex flex-wrap align-items-center justify-content-end gap-2">
        <span class="appointment-count">${schedulesByDate.size()} วันทำการ</span>
        <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/schedules">เลือกทันตแพทย์</a>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/nurse/schedules/new">เพิ่มตาราง</a>
      </div>
    </section>

    <section class="appointment-calendar" aria-labelledby="appointment-calendar-title">
      <div class="appointment-calendar__header">
        <div>
          <span class="eyebrow">DENTIST SCHEDULE</span>
          <h2 id="appointment-calendar-title" class="h5 mb-0">ตารางเวลาทันตแพทย์</h2>
        </div>
        <span class="text-secondary small">กดแต่ละช่วงเวลาเพื่อแก้ไขตาราง</span>
      </div>
      <div class="table-responsive appointment-grid-wrap">
        <table class="table appointment-grid align-middle mb-0">
          <thead>
            <tr>
              <th scope="col">วัน</th>
              <c:forEach items="${timeSlots}" var="timeSlot"><th scope="col">${timeSlot}</th></c:forEach>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${schedulesByDate}" var="day">
              <tr>
                <th scope="row" class="appointment-grid__date">${day.key}</th>
                <c:forEach items="${timeSlots}" var="timeSlot">
                  <c:set var="schedule" value="${day.value[timeSlot]}" />
                  <td>
                    <c:choose>
                      <c:when test="${not empty schedule && not empty schedule.appointment}">
                        <a class="appointment-grid__card appointment-grid__card--link" href="${pageContext.request.contextPath}/nurse/schedules/${schedule.id}">
                          <strong class="appointment-grid__patient">${schedule.appointment.patientName}</strong>
                          <span class="appointment-grid__service">${schedule.appointment.service}</span>
                          <span class="status-pill status-${schedule.appointment.status}">${statusLabel.appointment(schedule.appointment.status)}</span>
                        </a>
                      </c:when>
                      <c:when test="${not empty schedule}">
                        <a class="appointment-grid__card appointment-grid__card--available appointment-grid__card--link" href="${pageContext.request.contextPath}/nurse/schedules/${schedule.id}">
                          <strong class="appointment-grid__available">+ ว่าง</strong>
                          <span class="appointment-grid__service">${schedule.room.name}</span>
                          <span class="status-pill status-${schedule.status}">${statusLabel.schedule(schedule.status)}</span>
                        </a>
                      </c:when>
                      <c:otherwise><span class="appointment-grid__empty">—</span></c:otherwise>
                    </c:choose>
                  </td>
                </c:forEach>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <c:if test="${empty schedulesByDate}">
        <div class="appointment-calendar__empty text-center">
          <div class="fs-5 fw-semibold text-dark mb-1">ยังไม่มีตารางทำการ</div>
          <span class="text-secondary">เพิ่มช่วงเวลาทำการให้ทันตแพทย์ แล้วตารางจะแสดงที่นี่</span>
        </div>
      </c:if>
    </section>
  </main>
</body>
</html>
