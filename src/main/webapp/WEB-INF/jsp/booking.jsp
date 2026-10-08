<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>จองคิวทำฟัน | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/clinic.css?v=14" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/js/appointment-selector.js?v=4" defer></script>
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="card shadow-sm p-4 p-md-5 col-lg-8 mx-auto">
      <span class="text-primary fw-semibold">SMILECARE APPOINTMENT</span>
      <h1 class="h3 mt-2 mb-1">จองคิวทันตกรรม</h1>
      <p class="text-secondary mb-4">กรอกข้อมูลตามลำดับเพื่อเลือกช่วงเวลานัดที่ว่าง</p>
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
                <option value="${s.id}" data-id="${s.id}" data-dentist-id="${s.dentist.id}" data-dentist-name="${s.dentist.firstName} ${s.dentist.lastName}" data-date="${s.scheduleDate}" data-start="${s.startTime}" data-end="${s.endTime}" data-room="${s.room.name}"></option>
              </c:forEach>
            </select>

            <h2 class="h5 mb-3">1. เลือกบริการ</h2>
            <div class="mb-4">
              <label class="form-label" for="serviceId">บริการทันตกรรม</label>
              <select class="form-select" id="serviceId" name="serviceId" data-service required>
                <option value="">-- เลือกบริการ --</option>
                <c:forEach items="${services}" var="service">
                  <option value="${service.id}">${service.name}</option>
                </c:forEach>
              </select>
            </div>

            <h2 class="h5 border-top pt-4 mb-3">2. เลือกวันและเวลานัด</h2>
            <div class="mb-3">
              <label class="form-label" for="dentist">ทันตแพทย์</label>
              <select class="form-select" id="dentist" data-dentist disabled required>
                <option value="">-- เลือกบริการก่อน --</option>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label" for="appointmentDate">วันที่ว่าง</label>
              <select class="form-select" id="appointmentDate" data-date disabled required>
                <option value="">-- เลือกทันตแพทย์ก่อน --</option>
              </select>
            </div>
            <div class="mb-4">
              <label class="form-label" for="scheduleId">เวลาว่าง</label>
              <select class="form-select" id="scheduleId" name="scheduleId" data-time disabled required>
                <option value="">-- เลือกวันที่ก่อน --</option>
              </select>
            </div>

            <h2 class="h5 border-top pt-4 mb-3">3. หมายเหตุเพิ่มเติม</h2>
            <div class="mb-4">
              <label class="form-label" for="notes">รายละเอียดเพิ่มเติม (ถ้ามี)</label>
              <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="เช่น มีอาการปวดฟัน หรือมีโรคประจำตัวที่ควรแจ้งทันตแพทย์"></textarea>
            </div>
            <button class="btn btn-primary" type="submit">ยืนยันการจองคิว</button>
          </form>
        </c:otherwise>
      </c:choose>
    </div>
  </main>
</body>
</html>
