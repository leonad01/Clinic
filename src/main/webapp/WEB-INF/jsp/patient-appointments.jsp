<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>นัดหมายของฉัน</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex justify-content-between">
      <h1 class="h2">นัดหมายของฉัน</h1>
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/booking">จองคิวใหม่</a>
    </div>
  <div class="card shadow-sm mt-3">
    <table class="table mb-0">
      <thead>
        <tr>
          <th>วัน/เวลา</th>
          <th>บริการ</th>
          <th>สถานะ</th>
          <th>
          </th>
      </tr>
  </thead>
<tbody>
  <c:forEach items="${appointments}" var="item">
    <tr>
      <td>${item.appointmentDate} ${item.appointmentTime}</td>
      <td>${item.service}</td>
      <td><span class="status-pill status-${item.status}">${item.status}</span></td>
      <td>
        <a class="btn btn-sm btn-outline-primary" data-detail-modal href="${pageContext.request.contextPath}/patient/appointments/${item.id}">รายละเอียด</a>
      </td>
  </tr>
</c:forEach>
</tbody>
</table>
</div>
</main>
<%@ include file="includes/detail-modal.jspf" %>
</body>
</html>
