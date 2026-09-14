<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>SmileCare Dental Clinic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
    <style>
      body { font-family: system-ui, sans-serif; background: #f4f9fc; color: #163b53; }
      .nav-brand { font-weight: 800; color: #087f8c; }
      .hero { background: linear-gradient(115deg, #087f8c, #35a8b5); border-radius: 28px; color: #fff; }
      .card { border: 0; border-radius: 18px; box-shadow: 0 8px 24px #163b5318; }
      .icon { width: 48px; height: 48px; border-radius: 14px; background: #e4f6f7; display: grid; place-items: center; font-size: 1.4rem; }
      .btn { border-radius: 12px; }
      .home-service-search { max-width: 680px; margin: 0 auto; }
    </style>
</head>
<body>
  <nav class="navbar bg-white border-bottom">
    <div class="container">
      <a class="navbar-brand nav-brand" href="${pageContext.request.contextPath}/">🦷 SmileCare</a>
      <div class="d-flex align-items-center gap-2">
        <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/services">บริการ</a>
        <c:choose>
          <c:when test="${loggedIn}">
            <span class="small text-secondary d-none d-md-inline">เข้าสู่ระบบ: <strong>${username}</strong>
            </span>
          <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}${accountPath}">${accountLabel}</a>
          <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
            <button class="btn btn-sm btn-outline-danger" type="submit">ออกจากระบบ</button>
          </form>
      </c:when>
    <c:otherwise>
      <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/login">เข้าสู่ระบบ</a>
    </c:otherwise>
</c:choose>
</div>
</div>
</nav>
<main class="container py-5">
  <c:if test="${param.logout != null}">
    <div class="alert alert-success">ออกจากระบบเรียบร้อยแล้ว</div>
  </c:if>
<section class="hero p-4 p-md-5 mb-4">
  <span class="badge bg-light text-dark mb-3">คลินิกทันตกรรมครบวงจร</span>
  <h1 class="display-6 fw-bold">รอยยิ้มที่มั่นใจ เริ่มต้นจากการดูแลที่ดี</h1>
  <p class="lead opacity-75">จองคิวออนไลน์ ตรวจสอบนัดหมาย และดูประวัติการรักษาได้สะดวกในที่เดียว</p>
  <c:choose>
    <c:when test="${loggedIn}">
      <p class="mb-3">ยินดีต้อนรับกลับมา ${username}</p>
      <a class="btn btn-light text-primary fw-bold" href="${pageContext.request.contextPath}${accountPath}">ไปที่ ${accountLabel}</a>
    </c:when>
  <c:otherwise>
    <a class="btn btn-light text-primary fw-bold" href="${pageContext.request.contextPath}/register/patient">สมัครสมาชิกผู้ป่วย</a>
    <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/login">เข้าสู่ระบบเพื่อจองคิว</a>
  </c:otherwise>
</c:choose>
</section>
<section class="home-service-search card p-4 p-md-5 mb-4 text-center">
  <span class="text-primary fw-semibold small">ค้นหาบริการ</span>
  <h2 class="h4 mt-2">วันนี้ต้องการดูแลเรื่องอะไร?</h2>
  <p class="text-secondary mb-3">ค้นหาชื่อบริการ เช่น ขูดหินปูน อุดฟัน หรือ ตรวจสุขภาพฟัน</p>
  <form class="d-flex gap-2" action="${pageContext.request.contextPath}/services/search" method="get">
    <input class="form-control" type="search" name="q" placeholder="พิมพ์ชื่อบริการ" aria-label="ค้นหาบริการ" required>
    <button class="btn btn-primary text-nowrap" type="submit">ค้นหา</button>
  </form>
</section>
<section class="row g-3">
  <div class="col-md-4">
    <div class="card h-100 p-4">
      <div class="icon mb-3">📅</div>
      <h2 class="h5">จองนัดออนไลน์</h2>
      <p class="text-secondary">เลือกช่วงเวลา แพทย์ และห้องตรวจที่พร้อมให้บริการ</p>
      <c:choose>
        <c:when test="${loggedIn && isPatient}">
          <a href="${pageContext.request.contextPath}/booking">จองคิว →</a>
        </c:when>
      <c:when test="${loggedIn}">
        <a href="${pageContext.request.contextPath}${accountPath}">ไปยังหน้าของฉัน →</a>
      </c:when>
    <c:otherwise>
      <a href="${pageContext.request.contextPath}/login">เข้าสู่ระบบเพื่อจอง →</a>
    </c:otherwise>
</c:choose>
</div>
</div>
<div class="col-md-4">
  <div class="card h-100 p-4">
    <div class="icon mb-3">🪥</div>
    <h2 class="h5">บริการของเรา</h2>
    <p class="text-secondary">ดูรายการบริการและราคาได้ทันที</p>
    <a href="${pageContext.request.contextPath}/services">ดูบริการทั้งหมด →</a>
  </div>
</div>
<div class="col-md-4">
  <div class="card h-100 p-4">
    <div class="icon mb-3">📋</div>
    <h2 class="h5">นัดหมายของฉัน</h2>
    <p class="text-secondary">ตรวจสอบ เลื่อน หรือยกเลิกนัดหมายได้</p>
    <c:choose>
      <c:when test="${loggedIn && isPatient}">
        <a href="${pageContext.request.contextPath}/patient/appointments">ดูนัดหมาย →</a>
      </c:when>
    <c:when test="${loggedIn}">
      <a href="${pageContext.request.contextPath}${accountPath}">ไปยังหน้าของฉัน →</a>
    </c:when>
  <c:otherwise>
    <a href="${pageContext.request.contextPath}/login">เข้าสู่ระบบเพื่อดูนัด →</a>
  </c:otherwise>
</c:choose>
</div>
</div>
</section>
<section class="clinic-contact card mt-4 p-4 p-md-5">
  <div class="row g-4">
    <div class="col-lg-4">
      <span class="text-primary fw-semibold small">ติดต่อเรา</span>
      <h2 class="h4 mt-2">SmileCare Dental Clinic</h2>
      <p class="text-secondary mb-0">ดูแลสุขภาพช่องปากของคุณและครอบครัว ด้วยการนัดหมายที่สะดวกและบริการที่ใส่ใจ</p>
    </div>
    <div class="col-sm-6 col-lg-4">
      <h3 class="h6 fw-bold">ที่อยู่คลินิก</h3>
      <address class="text-secondary mb-0">
        123/45 ถนนห้วยแก้ว ตำบลช้างเผือก<br>
        อำเภอเมืองเชียงใหม่ จังหวัดเชียงใหม่ 50300
      </address>
    </div>
    <div class="col-sm-6 col-lg-4">
      <h3 class="h6 fw-bold">ช่องทางติดต่อ</h3>
      <ul class="list-unstyled text-secondary mb-0">
        <li><strong>โทร:</strong> <a href="tel:053123456">053-123-456</a></li>
        <li><strong>LINE:</strong> @smilecareclinic</li>
        <li><strong>อีเมล:</strong> <a href="mailto:contact@smilecare.local">contact@smilecare.local</a></li>
      </ul>
    </div>
  </div>
  <div class="clinic-hours border-top mt-4 pt-3 d-flex flex-wrap gap-2 align-items-center">
    <span class="fw-bold">เวลาทำการ</span>
    <span class="text-secondary">จันทร์–เสาร์ 09:00–18:00 น. · อาทิตย์ 09:00–16:00 น.</span>
  </div>
</section>
</main>
<c:if test="${loggedIn}">
  <script>window.smileCareContextPath = '${pageContext.request.contextPath}';</script>
  <script src="${pageContext.request.contextPath}/js/session-timeout.js?v=1" defer></script>
</c:if>
</body>
</html>
