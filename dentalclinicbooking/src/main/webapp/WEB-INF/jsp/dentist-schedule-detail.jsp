<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>รายละเอียดตารางงาน | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="card shadow-sm p-4 col-lg-8 mx-auto">
      <span class="text-primary fw-semibold">DENTIST WORKSPACE</span>
      <h1 class="h3 mt-2">รายละเอียดตารางงาน</h1>
      <c:if test="${param.completed != null}">
        <div class="alert alert-success mt-3">บันทึกผลการรักษาและปิดนัดหมายเรียบร้อยแล้ว</div>
      </c:if>
    <c:if test="${param.error != null}">
      <div class="alert alert-danger mt-3">ไม่สามารถปิดนัดหมายได้ กรุณาตรวจสอบสถานะนัด</div>
    </c:if>
  <dl class="row mt-4 mb-0">
    <dt class="col-sm-4">วันที่</dt>
    <dd class="col-sm-8">${schedule.scheduleDate}</dd>
    <dt class="col-sm-4">เวลา</dt>
    <dd class="col-sm-8">${schedule.startTime} - ${schedule.endTime}</dd>
    <dt class="col-sm-4">ห้องตรวจ</dt>
    <dd class="col-sm-8">${schedule.room.name}</dd>
    <dt class="col-sm-4">สถานะตาราง</dt>
    <dd class="col-sm-8"><span class="status-pill status-${schedule.status}">${schedule.status}</span></dd>
    <dt class="col-sm-4">ผู้ป่วย</dt>
    <dd class="col-sm-8">${empty schedule.appointment ? 'ยังไม่มีผู้ป่วยจอง' : schedule.appointment.patientName}</dd>
    <dt class="col-sm-4">บริการ</dt>
    <dd class="col-sm-8">${empty schedule.appointment ? '-' : schedule.appointment.service}</dd>
    <dt class="col-sm-4">สถานะเคส</dt>
    <dd class="col-sm-8">
      <c:choose>
        <c:when test="${empty schedule.appointment}">ยังไม่มีผู้ป่วยจอง</c:when>
        <c:when test="${schedule.appointment.status == 'PENDING'}"><span class="status-pill status-PENDING">รออนุมัติ</span></c:when>
        <c:when test="${schedule.appointment.status == 'APPROVED'}"><span class="status-pill status-APPROVED">รอทำ</span></c:when>
        <c:when test="${schedule.appointment.status == 'COMPLETED'}"><span class="status-pill status-COMPLETED">ทำแล้ว</span></c:when>
        <c:when test="${schedule.appointment.status == 'CANCELLED'}"><span class="status-pill status-CANCELLED">ยกเลิกแล้ว</span></c:when>
        <c:otherwise><span class="status-pill status-REJECTED">ปฏิเสธแล้ว</span></c:otherwise>
      </c:choose>
    </dd>
  </dl>
<c:if test="${not empty schedule.appointment && schedule.appointment.status == 'APPROVED'}">
  <form action="${pageContext.request.contextPath}/dentist/schedules/${schedule.id}/complete" method="post" class="border-top pt-4 mt-4">
    <label class="form-label" for="treatmentNote">ผลการรักษา / คำแนะนำผู้ป่วย</label>
    <textarea class="form-control" id="treatmentNote" name="treatmentNote" rows="4" placeholder="เช่น ขูดหินปูนเรียบร้อย แนะนำแปรงฟันอย่างน้อยวันละ 2 ครั้ง">
    </textarea>
  <button class="btn btn-success mt-3">บันทึกผลการรักษาและปิดนัด</button>
</form>
</c:if>
<a class="btn btn-outline-primary mt-3" href="${pageContext.request.contextPath}/dentist/schedules">กลับตารางงาน</a>
</div>
</main>
</body>
</html>
