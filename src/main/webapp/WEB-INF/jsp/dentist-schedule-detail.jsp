<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>รายละเอียดนัดหมาย | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"><link href="${pageContext.request.contextPath}/css/clinic.css?v=17" rel="stylesheet">
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5 dentist-workspace"><div class="card shadow-sm border-0 p-4 col-lg-8 mx-auto">
    <span class="eyebrow">APPOINTMENT DETAIL</span><h1 class="h3 mt-2">รายละเอียดนัดหมาย</h1>
    <c:if test="${param.started != null}"><div class="alert alert-info mt-3 mb-0">เริ่มดำเนินการรักษาแล้ว</div></c:if>
    <c:if test="${param.completed != null}"><div class="alert alert-success mt-3 mb-0">บันทึกผลการรักษาและปิดนัดหมายเรียบร้อยแล้ว</div></c:if>
    <c:if test="${param.error != null}"><div class="alert alert-danger mt-3 mb-0">ไม่สามารถเปลี่ยนสถานะได้ กรุณาตรวจสอบสถานะเคสอีกครั้ง</div></c:if>
    <dl class="row mt-4 mb-0">
      <dt class="col-sm-4">รหัสการจอง</dt><dd class="col-sm-8 fw-semibold">BK-<fmt:formatNumber value="${schedule.appointment.id}" pattern="000000" /></dd>
      <dt class="col-sm-4">วัน / เวลา</dt><dd class="col-sm-8">${schedule.scheduleDate} &nbsp; ${schedule.startTime} - ${schedule.endTime}</dd>
      <dt class="col-sm-4">ผู้ป่วย</dt><dd class="col-sm-8">${schedule.appointment.patientName}</dd>
      <dt class="col-sm-4">บริการ</dt><dd class="col-sm-8">${schedule.appointment.service}</dd>
      <dt class="col-sm-4">ห้องตรวจ</dt><dd class="col-sm-8">${schedule.room.name}</dd>
      <dt class="col-sm-4">สถานะตาราง / เคส</dt><dd class="col-sm-8"><c:choose><c:when test="${schedule.appointment.status == 'PENDING'}"><span class="status-pill status-PENDING">รออนุมัติ</span></c:when><c:when test="${schedule.appointment.status == 'APPROVED'}"><span class="status-pill status-APPROVED">รอทำ</span></c:when><c:when test="${schedule.appointment.status == 'IN_PROGRESS'}"><span class="status-pill status-IN_PROGRESS">กำลังทำ</span></c:when><c:when test="${schedule.appointment.status == 'COMPLETED'}"><span class="status-pill status-COMPLETED">ทำเสร็จแล้ว</span></c:when><c:otherwise><span class="status-pill status-CANCELLED">ยกเลิกแล้ว</span></c:otherwise></c:choose></dd>
    </dl>
    <c:if test="${schedule.appointment.status == 'APPROVED'}"><form action="${pageContext.request.contextPath}/dentist/schedules/${schedule.id}/start" method="post" class="border-top pt-4 mt-4"><h2 class="h5">พร้อมเริ่มการรักษา</h2><p class="text-secondary mb-3">กดเริ่มทำเมื่อผู้ป่วยเข้ารับบริการ สถานะตารางและเคสจะเปลี่ยนพร้อมกัน</p><button class="btn btn-primary">เริ่มทำการรักษา</button></form></c:if>
    <c:if test="${schedule.appointment.status == 'IN_PROGRESS'}"><form action="${pageContext.request.contextPath}/dentist/schedules/${schedule.id}/complete" method="post" class="border-top pt-4 mt-4"><h2 class="h5">บันทึกผลการรักษา</h2><label class="form-label" for="treatmentNote">ผลการรักษา / คำแนะนำผู้ป่วย</label><textarea class="form-control" id="treatmentNote" name="treatmentNote" rows="4" placeholder="ระบุผลการรักษาหรือคำแนะนำ"></textarea><button class="btn btn-success mt-3">บันทึกและทำเครื่องหมายว่าเสร็จแล้ว</button></form></c:if>
    <c:if test="${not empty treatmentHistories}"><section class="border-top pt-4 mt-4"><h2 class="h5 mb-3">ประวัติการรักษา</h2><div class="table-responsive"><table class="table table-sm mb-0"><thead><tr><th>วันที่</th><th>ทันตแพทย์</th><th>รายละเอียด</th></tr></thead><tbody><c:forEach items="${treatmentHistories}" var="history"><tr><td>${history.treatmentDate}</td><td>${history.dentist.firstName} ${history.dentist.lastName}</td><td>${empty history.note ? '-' : history.note}</td></tr></c:forEach></tbody></table></div></section></c:if>
    <a class="btn btn-outline-primary mt-4" href="${pageContext.request.contextPath}/dentist/schedules">กลับตารางนัด</a>
  </div></main>
</body>
</html>
