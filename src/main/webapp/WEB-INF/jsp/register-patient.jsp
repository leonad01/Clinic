<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>สมัครสมาชิก</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=9" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/register-patient.js?v=2" defer></script>
  </head>
<body class="bg-light">
  <main class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm p-4">
          <h1 class="h3">สมัครสมาชิกผู้ป่วย</h1>
          <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
          </c:if>
        <form action="${pageContext.request.contextPath}/register/patient" method="post" data-register-form novalidate>
          <div class="row g-3">
            <div class="col-md-6">
              <label>ชื่อ</label>
              <input class="form-control" id="firstName" name="firstName" placeholder="เช่น สมใจ" minlength="2" maxlength="20" pattern="[A-Za-zก-ฮะ-ฺเ-๎]{2,20}" required>
            </div>
          <div class="col-md-6">
            <label>นามสกุล</label>
            <input class="form-control" id="lastName" name="lastName" placeholder="เช่น ใจดี" minlength="2" maxlength="20" pattern="[A-Za-zก-ฮะ-ฺเ-๎]{2,20}" required>
          </div>
        <div class="col-md-6">
          <label>เลขบัตรประชาชน</label>
          <input class="form-control" id="idCard" name="idCard" inputmode="numeric" minlength="13" maxlength="13" pattern="[0-9]{13}" autocomplete="off" placeholder="กรอกเลขบัตรประชาชน 13 หลัก" required>
          <div class="form-text" data-id-card-hint>โหมดสาธิต: ใช้ตัวเลข 13 หลักที่ไม่ซ้ำกัน</div>
        </div>
        <div class="col-md-6">
          <label>Username</label>
          <input class="form-control" id="username" name="username" placeholder="เช่น Somjai1" minlength="4" maxlength="8" pattern="[A-Za-z0-9]{4,8}" autocomplete="username" required>
          <div class="form-text">ใช้ตัวอักษรภาษาอังกฤษ ตัวเลข _ หรือ - อย่างน้อย 4 ตัว</div>
        </div>
      <div class="col-md-6">
        <label for="phone">เบอร์โทรศัพท์</label>
        <input class="form-control" id="phone" name="phone" type="tel" inputmode="numeric" minlength="10" maxlength="10" pattern="[0-9]{10}" autocomplete="tel" placeholder="เช่น 0812345678" required>
        <div class="form-text" data-phone-hint>กรอกตัวเลข 10 หลัก ขึ้นต้นด้วย 0</div>
      </div>
      <div class="col-md-6">
        <label>อีเมล</label>
        <input class="form-control" id="email" name="email" type="email" placeholder="เช่น somjai@example.com" minlength="5" maxlength="60" required>
      </div>
    <div class="col-md-6">
      <label>วันเกิด</label>
      <input class="form-control" id="dateOfBirth" name="dateOfBirth" type="date" required>
    </div>
  <div class="col-md-6">
    <label>เพศ</label>
    <select class="form-select" name="gender">
      <option value="MALE">ชาย</option>
      <option value="FEMALE">หญิง</option>
      <option value="OTHER">อื่น ๆ</option>
    </select>
</div>
<div class="col-md-6">
  <label>รหัสผ่าน</label>
  <div class="input-group">
    <input class="form-control" id="passwordHash" name="passwordHash" type="password" placeholder="เช่น Somjai#1" minlength="8" maxlength="16" pattern="[A-Za-z0-9!#_.]{8,16}" autocomplete="new-password" required>
    <button class="btn btn-outline-primary password-toggle" type="button" data-toggle-password="passwordHash" aria-label="แสดงรหัสผ่าน" title="แสดงรหัสผ่าน"><span aria-hidden="true">👁</span></button>
  </div>
  <div class="form-text" data-password-hint>อย่างน้อย 8 ตัวอักษร</div>
</div>
<div class="col-md-6">
  <label>ยืนยันรหัสผ่าน</label>
  <div class="input-group">
    <input class="form-control" id="confirmPassword" name="confirmPassword" type="password" placeholder="กรอกรหัสผ่านเดิมอีกครั้ง" minlength="8" autocomplete="new-password" required>
    <button class="btn btn-outline-primary password-toggle" type="button" data-toggle-password="confirmPassword" aria-label="แสดงรหัสผ่าน" title="แสดงรหัสผ่าน"><span aria-hidden="true">👁</span></button>
  </div>
  <div class="form-text" data-confirm-hint></div>
</div>
</div>
<button class="btn btn-primary mt-4">สมัครสมาชิก</button>
</form>
</div>
</div>
</div>
</main>
</body>
</html>
