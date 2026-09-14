<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>บริการ | SmileCare</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"><link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet"></head>
  <body class="bg-light"><main class="container py-5">
    <div class="d-flex justify-content-between align-items-center"><div><span class="text-primary fw-semibold">SMILECARE DENTAL CLINIC</span><h1 class="h2 mt-1">บริการทันตกรรม</h1></div><a class="btn btn-primary" href="${pageContext.request.contextPath}/login">เข้าสู่ระบบเพื่อจอง</a></div>
    <p class="text-secondary">เลือกดูบริการที่เหมาะกับคุณ พร้อมรายละเอียดและระยะเวลาโดยประมาณ</p>
    <form class="row g-2 mb-4" action="${pageContext.request.contextPath}/services" method="get"><div class="col-md-5"><input class="form-control" name="q" value="${q}" placeholder="ค้นหาชื่อบริการ"></div><div class="col-auto"><button class="btn btn-outline-primary">ค้นหา</button></div><div class="col-auto"><a class="btn btn-light" href="${pageContext.request.contextPath}/services">ล้าง</a></div></form>
    <div class="row g-3">
      <c:forEach items="${services}" var="item" varStatus="loop">
        <div class="col-md-6 col-lg-4">
          <article class="card shadow-sm h-100 service-card">
            <c:choose>
              <c:when test="${loop.index % 2 == 0}"><img class="service-image" src="${pageContext.request.contextPath}/images/service-consultation.png" alt="บริการทันตกรรม ${item.name}"></c:when>
              <c:otherwise><img class="service-image" src="${pageContext.request.contextPath}/images/service-treatment.png" alt="บริการทันตกรรม ${item.name}"></c:otherwise>
            </c:choose>
            <div class="p-4 d-flex flex-column h-100">
              <span class="text-primary small fw-semibold">${item.category}</span>
              <h2 class="h5 mt-2">${item.name}</h2>
              <p class="text-secondary">${empty item.description ? 'สอบถามรายละเอียดเพิ่มเติมกับทางคลินิกได้' : item.description}</p>
              <div class="mt-auto border-top pt-3">
                <div class="small text-secondary mb-1">ระยะเวลาโดยประมาณ: ${item.duration}</div>
                <div class="fw-bold mb-3">${item.price} บาท</div>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary w-100">เลือกบริการนี้</a>
              </div>
            </div>
          </article>
        </div>
      </c:forEach>
      <c:if test="${empty services}"><div class="alert alert-info">ไม่พบบริการที่ค้นหา</div></c:if>
    </div>
  </main></body>
</html>
