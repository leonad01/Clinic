<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>แก้ไขและเลื่อนนัด | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/appointment-selector.js?v=3" defer></script>
  </head>
  <body class="bg-light">
    <%@ include file="includes/clinic-userbar.jspf" %>
    <main class="container py-5">
      <div class="card shadow-sm p-4 p-md-5 col-lg-8 mx-auto">
        <span class="text-primary fw-semibold">SMILECARE APPOINTMENT</span>
        <h1 class="h3 mt-2">แก้ไข / เลื่อนนัดหมาย #${appointment.id}</h1>
        <p class="text-secondary">เลือกทันตแพทย์ วันที่ และช่วงเวลาว่างใหม่ ระบบจะเปลี่ยนสถานะเป็นรออนุมัติ</p>
        <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>

        <form action="${pageContext.request.contextPath}/nurse/appointments/${appointment.id}/reschedule" method="post" data-appointment-selector data-selected-schedule-id="${appointment.dentistSchedule.id}">
          <select data-schedule-source class="d-none" aria-hidden="true">
            <c:forEach items="${schedules}" var="s">
              <option value="${s.id}" data-id="${s.id}" data-dentist-id="${s.dentist.id}" data-dentist-name="${s.dentist.firstName} ${s.dentist.lastName}" data-date="${s.scheduleDate}" data-start="${s.startTime}" data-end="${s.endTime}"></option>
            </c:forEach>
          </select>
          <div class="row g-3">
            <div class="col-12">
              <label class="form-label">1. บริการ</label>
              <input class="form-control" value="${appointment.service}" readonly>
            </div>
            <div class="col-md-6">
              <label class="form-label">2. ทันตแพทย์</label>
              <select class="form-select" data-dentist required></select>
            </div>
            <div class="col-md-6">
              <label class="form-label">3. วันที่ว่าง</label>
              <select class="form-select" data-date required></select>
            </div>
            <div class="col-md-6">
              <label class="form-label">4. เวลาว่าง</label>
              <select class="form-select" name="scheduleId" data-time required></select>
            </div>
          </div>
          <button class="btn btn-primary mt-4">บันทึกการเลื่อนนัด</button>
          <a class="btn btn-link mt-4" href="${pageContext.request.contextPath}/nurse/appointments/${appointment.id}">กลับ</a>
        </form>
      </div>
    </main>
  </body>
</html>
