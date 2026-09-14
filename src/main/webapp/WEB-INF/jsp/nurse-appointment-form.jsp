<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>บันทึกนัดหมาย</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/appointment-selector.js?v=4" defer></script>
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="card p-4 shadow-sm">
      <h1 class="h3">บันทึกนัดหมาย</h1>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
      </c:if>
      <form action="${pageContext.request.contextPath}/nurse/appointments" method="post" data-appointment-selector>
        <input type="hidden" name="id" value="${appointment.id}">
        <select data-schedule-source class="d-none" aria-hidden="true">
          <c:forEach items="${schedules}" var="schedule">
            <option value="${schedule.id}" data-id="${schedule.id}" data-dentist-id="${schedule.dentist.id}" data-dentist-name="${schedule.dentist.firstName} ${schedule.dentist.lastName}" data-date="${schedule.scheduleDate}" data-start="${schedule.startTime}" data-end="${schedule.endTime}"></option>
          </c:forEach>
        </select>
        <div class="row g-3">
          <div class="col-12">
            <label class="form-label" for="patientId">ผู้ป่วย</label>
            <select class="form-select" id="patientId" name="patientId" required>
              <option value="">-- เลือกผู้ป่วย --</option>
              <c:forEach items="${patients}" var="patient">
                <option value="${patient.id}" ${appointment.patient != null && appointment.patient.id == patient.id ? 'selected' : ''}>${patient.firstName} ${patient.lastName} (${patient.idCard})</option>
              </c:forEach>
            </select>
          </div>
        <div class="col-12">
          <label class="form-label">บริการ</label>
          <select class="form-select" name="serviceId" required>
            <option value="">-- เลือกบริการ --</option>
            <c:forEach items="${services}" var="service">
              <option value="${service.id}" ${appointment.dentalService != null && appointment.dentalService.id == service.id ? 'selected' : ''}>${service.name}</option>
            </c:forEach>
          </select>
        </div>
      <div class="col-12">
        <label class="form-label">ทันตแพทย์</label>
        <select class="form-select" data-dentist required></select>
      </div>
    <div class="col-12">
      <label class="form-label">วันที่ว่าง</label>
      <select class="form-select" data-date required></select>
    </div>
  <div class="col-12">
    <label class="form-label">เวลาว่าง</label>
    <select class="form-select" name="scheduleId" data-time required></select>
  </div>
<div class="col-12">
  <label class="form-label">หมายเหตุ</label>
  <textarea class="form-control" name="notes">${appointment.notes}</textarea>
</div>
</div>
<button class="btn btn-primary mt-4">บันทึก</button>
<a class="btn btn-link mt-4" href="${pageContext.request.contextPath}/nurse/appointments">กลับ</a>
</form>
</div>
</main>
</body>
</html>
