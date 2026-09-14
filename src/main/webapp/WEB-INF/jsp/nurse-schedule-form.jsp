<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>บันทึกตารางทันตแพทย์ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="card shadow-sm p-4 col-xl-9 mx-auto">
      <h1 class="h3">บันทึกตารางทันตแพทย์</h1>
      <p class="text-secondary">ระบบจะตรวจสอบไม่ให้ใช้แพทย์หรือห้องตรวจซ้อนกันในช่วงเวลาเดียวกัน</p>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
      </c:if>
    <form action="${pageContext.request.contextPath}/nurse/schedules" method="post">
      <input type="hidden" name="id" value="${schedule.id}">
      <div class="row g-3">
        <div class="col-12">
          <label class="form-label" for="dentist">ทันตแพทย์</label>
          <select class="form-select" id="dentist" name="dentist" required>
            <c:forEach items="${dentists}" var="dentist">
              <option value="${dentist.id}" ${dentist.id == schedule.dentist.id ? 'selected' : ''}>${dentist.firstName} ${dentist.lastName}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-12">
          <label class="form-label" for="scheduleDate">วันที่</label>
          <input class="form-control" id="scheduleDate" type="date" name="scheduleDate" value="${schedule.scheduleDate}" required>
        </div>
        <div class="col-12">
          <label class="form-label" for="startTime">เวลาเริ่ม</label>
          <input class="form-control" id="startTime" type="time" name="startTime" value="${schedule.startTime}" required>
        </div>
        <div class="col-12">
          <label class="form-label" for="endTime">เวลาสิ้นสุด</label>
          <input class="form-control" id="endTime" type="time" name="endTime" value="${schedule.endTime}" required>
        </div>
        <div class="col-12">
          <label class="form-label" for="room">ห้องตรวจ</label>
          <select class="form-select" id="room" name="room" required>
            <c:forEach items="${rooms}" var="room">
              <option value="${room.id}" ${room.id == schedule.room.id ? 'selected' : ''}>${room.name}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-12">
          <label class="form-label" for="status">สถานะตาราง</label>
          <select class="form-select" id="status" name="status">
            <option value="AVAILABLE" ${schedule.status == 'AVAILABLE' ? 'selected' : ''}>ว่าง</option>
            <option value="UNAVAILABLE" ${schedule.status == 'UNAVAILABLE' ? 'selected' : ''}>ไม่ว่าง</option>
          </select>
        </div>
</div>
<button class="btn btn-primary mt-4">บันทึก</button>
<a class="btn btn-link mt-4" href="${pageContext.request.contextPath}/nurse/schedules">กลับ</a>
</form>
</div>
</main>
</body>
</html>
