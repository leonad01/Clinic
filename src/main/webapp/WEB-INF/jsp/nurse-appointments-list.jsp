<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>คำขอนัดหมาย | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/clinic.css?v=17" rel="stylesheet">
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-4 nurse-dashboard">
    <section class="nurse-dashboard__hero mb-4">
      <span class="nurse-dashboard__hero-icon" aria-hidden="true">▣</span>
      <div><h1>คำขอนัดหมาย</h1><p class="mb-0">จัดการ แก้ไข และติดตามคำขอนัดหมายของผู้ป่วย</p></div>
      <div class="nurse-dashboard__actions ms-auto"><a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/patients">ผู้ป่วย</a><a class="btn btn-primary" href="${pageContext.request.contextPath}/nurse/appointments/new">+ เพิ่มนัด</a></div>
    </section>

    <section class="appointment-stats mb-3" aria-label="สรุปคำขอนัดหมาย">
      <a class="appointment-stat appointment-stat--pending" href="${pageContext.request.contextPath}/nurse/appointments?status=PENDING"><span class="appointment-stat__icon">⌛</span><span><strong>รออนุมัติ</strong><b>${pendingCount}</b><small>คำขอนัดหมาย</small></span><i>›</i></a>
      <a class="appointment-stat appointment-stat--today" href="${pageContext.request.contextPath}/nurse/appointments"><span class="appointment-stat__icon">▣</span><span><strong>วันนี้</strong><b>${todayCount}</b><small>คำขอนัดหมาย</small></span><i>›</i></a>
      <a class="appointment-stat appointment-stat--approved" href="${pageContext.request.contextPath}/nurse/appointments?status=APPROVED"><span class="appointment-stat__icon">✓</span><span><strong>ยืนยันแล้ว</strong><b>${approvedCount}</b><small>คำขอนัดหมาย</small></span><i>›</i></a>
      <a class="appointment-stat appointment-stat--cancelled" href="${pageContext.request.contextPath}/nurse/appointments?status=CANCELLED"><span class="appointment-stat__icon">×</span><span><strong>ยกเลิก</strong><b>${cancelledCount}</b><small>คำขอนัดหมาย</small></span><i>›</i></a>
    </section>

    <section class="nurse-filter-card mb-3">
      <form class="nurse-filter" method="get" action="${pageContext.request.contextPath}/nurse/appointments">
        <div class="nurse-filter__search"><label class="visually-hidden" for="q">ค้นหา</label><span aria-hidden="true">⌕</span><input id="q" name="q" value="${keyword}" placeholder="ค้นหาชื่อผู้ป่วย / รหัสการจอง"><button type="submit">ค้นหา</button></div>
        <div><label for="service">บริการ</label><select id="service" name="service"><option value="ALL">ทั้งหมด</option><c:forEach items="${services}" var="serviceName"><option value="${serviceName}" ${selectedService == serviceName ? 'selected' : ''}>${serviceName}</option></c:forEach></select></div>
        <div><label for="status">สถานะ</label><select id="status" name="status"><option value="ALL">ทั้งหมด</option><option value="PENDING" ${selectedStatus == 'PENDING' ? 'selected' : ''}>รออนุมัติ</option><option value="APPROVED" ${selectedStatus == 'APPROVED' ? 'selected' : ''}>ยืนยันแล้ว</option><option value="IN_PROGRESS" ${selectedStatus == 'IN_PROGRESS' ? 'selected' : ''}>กำลังรักษา</option><option value="COMPLETED" ${selectedStatus == 'COMPLETED' ? 'selected' : ''}>เสร็จแล้ว</option><option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>ยกเลิก</option></select></div>
        <button class="btn btn-outline-primary nurse-filter__reset" type="button" onclick="window.location='${pageContext.request.contextPath}/nurse/appointments'">ล้างตัวกรอง</button>
      </form>
    </section>

    <section class="nurse-appointment-list">
      <div class="nurse-appointment-list__header"><div><h2>รายการคำขอนัดหมาย <span>(${appointments.size()} รายการ)</span></h2></div><a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/nurse/schedules">จัดการตาราง</a></div>
      <div class="table-responsive">
        <table class="table nurse-appointment-table align-middle mb-0">
          <thead><tr><th>รหัสการจอง</th><th>ผู้ป่วย</th><th>วัน / เวลา</th><th>บริการ</th><th>ทันตแพทย์</th><th>สถานะ</th><th>การดำเนินการ</th></tr></thead>
          <tbody><c:forEach items="${appointments}" var="item"><tr class="${item.status == 'PENDING' ? 'nurse-appointment-table__pending' : ''}">
            <td class="nurse-booking-code">BK-<fmt:formatNumber value="${item.id}" pattern="000000" /></td>
            <td class="fw-semibold">${item.patientName}</td>
            <td><strong>${item.appointmentDate}</strong><small>${item.appointmentTime} - ${item.appointmentEndTime}</small></td>
            <td>${item.service}</td>
            <td><c:choose><c:when test="${not empty item.dentist}"><span class="dentist-chip">♙ ${item.dentist.firstName} ${item.dentist.lastName}</span></c:when><c:otherwise><span class="text-secondary">-</span></c:otherwise></c:choose></td>
            <td><span class="status-pill status-${item.status}">${statusLabel.appointment(item.status)}</span></td>
            <td class="nurse-appointment-table__actions"><c:if test="${item.status == 'PENDING'}"><form action="${pageContext.request.contextPath}/nurse/appointments/${item.id}/approve" method="post"><button class="btn btn-sm btn-success">✓ อนุมัติ</button></form></c:if><a class="btn btn-sm btn-outline-primary" data-detail-modal href="${pageContext.request.contextPath}/nurse/appointments/${item.id}">ดูรายละเอียด</a></td>
          </tr></c:forEach><c:if test="${empty appointments}"><tr><td colspan="7" class="text-center text-secondary py-5">ไม่พบคำขอนัดหมายตามตัวกรองที่เลือก</td></tr></c:if></tbody>
        </table>
      </div>
    </section>
  </main>
  <%@ include file="includes/detail-modal.jspf" %>
</body>
</html>
