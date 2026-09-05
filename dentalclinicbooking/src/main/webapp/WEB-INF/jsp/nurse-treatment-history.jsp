<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ประวัติการรักษา | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between align-items-center">
      <div>
        <span class="text-primary fw-semibold">NURSE WORKSPACE</span>
        <h1 class="h2 mt-1">ประวัติการรักษา</h1>
        <p class="text-secondary mb-0">ผู้ป่วย: ${patient.firstName} ${patient.lastName}</p>
      </div>
    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/nurse/patients">กลับรายชื่อผู้ป่วย</a>
  </div>
<div class="card shadow-sm mt-3">
  <div class="table-responsive">
    <table class="table mb-0">
      <thead>
        <tr>
          <th>วันที่รักษา</th>
          <th>ทันตแพทย์</th>
          <th>ผลการรักษา / คำแนะนำ</th>
        </tr>
    </thead>
  <tbody>
    <c:forEach items="${histories}" var="history">
      <tr>
        <td>${history.treatmentDate}</td>
        <td>${history.dentist.firstName} ${history.dentist.lastName}</td>
        <td>${history.note}</td>
      </tr>
  </c:forEach>
<c:if test="${empty histories}">
  <tr>
    <td colspan="3" class="text-center text-secondary py-4">ยังไม่มีประวัติการรักษา</td>
  </tr>
</c:if>
</tbody>
</table>
</div>
</div>
</main>
</body>
</html>
