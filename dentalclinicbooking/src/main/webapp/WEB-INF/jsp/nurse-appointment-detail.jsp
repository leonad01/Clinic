<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>รายละเอียดการจอง | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
  <body class="bg-light">
    <%@ include file="includes/clinic-userbar.jspf" %>
    <main class="container py-5">
      <div class="card shadow-sm p-4 p-md-5 col-lg-8 mx-auto">
        <div class="d-flex justify-content-between align-items-start gap-3">
          <div>
            <span class="text-primary fw-semibold">SMILECARE APPOINTMENT</span>
            <h1 class="h3 mt-2 mb-1">รายละเอียดการจอง #${appointment.id}</h1>
            <p class="text-secondary mb-0">ตรวจสอบข้อมูลนัดหมายก่อนดำเนินการ</p>
          </div>
          <c:choose>
            <c:when test="${appointment.status == 'PENDING'}"><span class="status-pill status-PENDING">รออนุมัติ</span></c:when>
            <c:when test="${appointment.status == 'APPROVED'}"><span class="status-pill status-APPROVED">อนุมัติแล้ว</span></c:when>
            <c:when test="${appointment.status == 'COMPLETED'}"><span class="status-pill status-COMPLETED">รักษาเสร็จแล้ว</span></c:when>
            <c:when test="${appointment.status == 'CANCELLED'}"><span class="status-pill status-CANCELLED">ยกเลิกแล้ว</span></c:when>
            <c:otherwise><span class="status-pill status-REJECTED">ปฏิเสธแล้ว</span></c:otherwise>
          </c:choose>
        </div>

        <h2 class="h5 border-bottom pb-2 mt-4">ข้อมูลผู้ป่วย</h2>
        <dl class="row mb-0">
          <dt class="col-sm-4">ชื่อผู้ป่วย</dt>
          <dd class="col-sm-8">${appointment.patientName}</dd>
          <dt class="col-sm-4">โทรศัพท์</dt>
          <dd class="col-sm-8">${empty appointment.phone ? '-' : appointment.phone}</dd>
          <dt class="col-sm-4">อีเมล</dt>
          <dd class="col-sm-8">${empty appointment.email ? '-' : appointment.email}</dd>
        </dl>

        <h2 class="h5 border-bottom pb-2 mt-4">ข้อมูลการจอง</h2>
        <dl class="row mb-0">
          <dt class="col-sm-4">1. บริการ</dt>
          <dd class="col-sm-8">${appointment.service}</dd>
          <dt class="col-sm-4">2. ทันตแพทย์</dt>
          <dd class="col-sm-8">
            <c:choose>
              <c:when test="${not empty appointment.dentist}">${appointment.dentist.firstName} ${appointment.dentist.lastName}</c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </dd>
          <dt class="col-sm-4">3. วันที่นัด</dt>
          <dd class="col-sm-8">${appointment.appointmentDate}</dd>
          <dt class="col-sm-4">4. ช่วงเวลา</dt>
          <dd class="col-sm-8">${appointment.appointmentTime} - ${appointment.appointmentEndTime}</dd>
          <dt class="col-sm-4">ห้องตรวจ</dt>
          <dd class="col-sm-8">
            <c:choose>
              <c:when test="${not empty appointment.dentistSchedule}">${appointment.dentistSchedule.room.name}</c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </dd>
          <dt class="col-sm-4">หมายเหตุผู้ป่วย</dt>
          <dd class="col-sm-8">${empty appointment.notes ? '-' : appointment.notes}</dd>
        </dl>

        <div class="border-top pt-3 mt-4 d-flex flex-wrap gap-2">
          <c:if test="${appointment.status == 'PENDING'}">
            <form action="${pageContext.request.contextPath}/nurse/appointments/${appointment.id}/approve" method="post">
              <button class="btn btn-success">อนุมัตินัดหมาย</button>
            </form>
          </c:if>
          <c:if test="${appointment.status == 'PENDING' || appointment.status == 'APPROVED'}">
            <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/appointments/${appointment.id}/reschedule">แก้ไข / เลื่อนนัด</a>
          </c:if>
          <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/appointments">กลับรายการนัดหมาย</a>
        </div>
      </div>
    </main>
  </body>
</html>
