<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>รายละเอียดนัดหมาย | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="card shadow-sm p-4 col-lg-8 mx-auto">
      <c:if test="${param.cancelError != null}">
        <div class="alert alert-warning">ไม่สามารถยกเลิกนัดที่ทำเสร็จแล้วหรือถูกยกเลิกไปแล้วได้</div>
      </c:if>
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <span class="text-primary fw-semibold">SMILECARE APPOINTMENT</span>
          <h1 class="h3 mt-2">รายละเอียดนัดหมาย</h1>
        </div>
      <span class="status-pill status-${appointment.status}">${appointment.status}</span>
    </div>
  <dl class="row mt-4 mb-2">
    <dt class="col-sm-4">รหัสการจอง</dt>
    <dd class="col-sm-8 fw-semibold">BK-<fmt:formatNumber value="${appointment.id}" pattern="000000" /></dd>
    <dt class="col-sm-4">บริการ</dt>
    <dd class="col-sm-8">${appointment.service}</dd>
    <dt class="col-sm-4">วันที่นัด</dt>
    <dd class="col-sm-8">${appointment.appointmentDate}</dd>
    <dt class="col-sm-4">เวลานัด</dt>
    <dd class="col-sm-8">${appointment.appointmentTime} - ${appointment.appointmentEndTime}</dd>
    <dt class="col-sm-4">ทันตแพทย์</dt>
    <dd class="col-sm-8">${appointment.dentist.firstName} ${appointment.dentist.lastName}</dd>
<dt class="col-sm-4">หมายเหตุ</dt>
<dd class="col-sm-8">${empty appointment.notes ? '-' : appointment.notes}</dd>
</dl>
<div class="border-top pt-3 mt-3">
  <c:if test="${appointment.status == 'PENDING' || appointment.status == 'APPROVED'}">
    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/patient/appointments/${appointment.id}/reschedule">เลื่อนนัด</a>
    <form class="d-inline" action="${pageContext.request.contextPath}/patient/appointments/${appointment.id}/cancel" method="post">
      <button class="btn btn-outline-danger">ยกเลิกนัด</button>
    </form>
  </c:if>
  <c:if test="${appointment.status == 'COMPLETED'}">
    <span class="text-secondary small">นัดนี้ทำเสร็จแล้ว จึงไม่สามารถเลื่อนหรือยกเลิกได้</span>
  </c:if>
<a class="btn btn-link" href="${pageContext.request.contextPath}/patient/appointments">กลับรายการนัด</a>
</div>
</div>
</main>
</body>
</html>
