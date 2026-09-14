<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>จัดการบุคลากร | SmileCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/clinic.css?v=11" rel="stylesheet">
</head>
<body class="bg-light">
  <%@ include file="includes/clinic-userbar.jspf" %>
  <main class="container py-5">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h1 class="h2 mb-0">จัดการบุคลากร</h1>
      <div class="d-flex flex-wrap gap-2">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/staff/nurses/new">เพิ่มพยาบาล</a>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/staff/dentists/new">เพิ่มทันตแพทย์</a>
        <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/rooms">จัดการห้องตรวจ</a>
      </div>
    </div>
    <div class="row g-3 mt-3">
      <div class="col-md-6"><div class="card p-3 shadow-sm h-100"><h2 class="h5">พยาบาล</h2><ul class="mb-0"><c:forEach items="${nurses}" var="n"><li><a data-detail-modal href="${pageContext.request.contextPath}/admin/staff/nurses/${n.id}">${n.firstName} ${n.lastName}</a> <span class="text-secondary">(${n.username})</span></li></c:forEach></ul></div></div>
      <div class="col-md-6"><div class="card p-3 shadow-sm h-100"><h2 class="h5">ทันตแพทย์</h2><ul class="mb-0"><c:forEach items="${dentists}" var="d"><li><a data-detail-modal href="${pageContext.request.contextPath}/admin/staff/dentists/${d.id}">${d.firstName} ${d.lastName}</a> <span class="text-secondary">(${d.username})</span></li></c:forEach></ul></div></div>
    </div>
  </main>
  <%@ include file="includes/detail-modal.jspf" %>
</body>
</html>
