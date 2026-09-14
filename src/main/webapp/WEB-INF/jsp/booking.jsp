<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>จองคิว | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/appointment-selector.js?v=3" defer>
    </script>
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="card shadow-sm p-4 p-md-5 col-lg-8 mx-auto">
      <span class="text-primary fw-semibold">SMILECARE APPOINTMENT</span>
      <h1 class="h3 mt-2">จองคิวทันตกรรม</h1>
      <p class="text-secondary">เลือกบริการก่อน จากนั้นเลือกทันตแพทย์ วันที่ และช่วงเวลาว่าง</p>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
      </c:if>
    <c:choose>
      <c:when test="${empty schedules}">
        <div class="alert alert-info">ยังไม่มีช่วงเวลาว่าง กรุณาติดต่อคลินิก</div>
      </c:when>
    <c:otherwise>
      <form action="${pageContext.request.contextPath}/booking" method="post" data-appointment-selector>
        <select data-schedule-source class="d-none" aria-hidden="true">
          <c:forEach items="${schedules}" var="s">
            <option value="${s.id}" data-id="${s.id}" data-dentist-id="${s.dentist.id}" data-dentist-name="${s.dentist.firstName} ${s.dentist.lastName}" data-date="${s.scheduleDate}" data-start="${s.startTime}" data-end="${s.endTime}" data-room="${s.room.name}">
            </option>
        </c:forEach>
    </select>
  <div class="row g-3">
    <div class="col-12">
      <label class="form-label">1. บริการ</label>
      <select class="form-select" name="serviceId" data-service required>
        <option value="">-- เลือกบริการ --</option>
        <c:forEach items="${services}" var="service">
          <option value="${service.id}">${service.name}</option>
        </c:forEach>
    </select>
</div>
<div class="col-md-6">
  <label class="form-label">2. ทันตแพทย์</label>
  <select class="form-select" data-dentist disabled required>
    <option>-- เลือกบริการก่อน --</option>
  </select>
</div>
<div class="col-md-6">
  <label class="form-label">3. วันที่ว่าง</label>
  <select class="form-select" data-date disabled required>
    <option>-- เลือกทันตแพทย์ก่อน --</option>
  </select>
</div>
<div class="col-md-6">
  <label class="form-label">4. เวลาว่าง</label>
  <select class="form-select" name="scheduleId" data-time disabled required>
    <option>-- เลือกวันที่ก่อน --</option>
  </select>
</div>
<div class="col-md-6">
  <label class="form-label">หมายเหตุเพิ่มเติม</label>
  <input class="form-control" name="notes" placeholder="ถ้ามี">
</div>
</div>
<button class="btn btn-primary mt-4">ยืนยันการจองคิว</button>
</form>
</c:otherwise>
</c:choose>
</div>
</main>
</body>
</html>
