<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>เข้าสู่ระบบ | SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/clinic.css?v=10" rel="stylesheet">
  </head>
<body class="bg-light">
  <main class="container login-page py-4 py-md-5">
    <section class="login-shell">
      <div class="login-intro">
        <a class="login-brand" href="${pageContext.request.contextPath}/">
          <span class="login-brand-mark">S</span>
          <span>SmileCare</span>
        </a>
        <div class="login-intro-content">
          <span class="login-eyebrow">DENTAL CLINIC</span>
          <h1>ดูแลทุกรอยยิ้ม<br>ในทุกการนัดหมาย</h1>
          <p>เข้าสู่ระบบเพื่อจัดการนัดหมาย ตารางการรักษา และข้อมูลคลินิกอย่างสะดวก</p>
        </div>
        <a class="login-home-link" href="${pageContext.request.contextPath}/">← กลับหน้าหลัก</a>
      </div>

      <div class="login-form-panel">
        <div class="login-form-wrap">
          <span class="login-role-badge">เข้าสู่ระบบสำหรับ ${loginRoleLabel}</span>
          <h2>ยินดีต้อนรับ</h2>
          <p class="login-subtitle">กรอกชื่อผู้ใช้และรหัสผ่านของคุณ</p>

            <c:if test="${param.error != null}">
              <div class="alert alert-danger login-alert">ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง กรุณาลองอีกครั้ง</div>
            </c:if>
            <c:if test="${param.roleError != null}">
              <div class="alert alert-warning login-alert">บัญชีนี้ไม่ใช่บัญชี${loginRoleLabel} กรุณาเลือกประเภทผู้ใช้ที่ถูกต้อง</div>
            </c:if>
            <c:if test="${param.expired != null}">
              <div class="alert alert-warning login-alert">ช่วงเวลาการใช้งานหมดอายุ กรุณาเข้าสู่ระบบอีกครั้ง</div>
            </c:if>
            <c:if test="${param.registered != null}">
              <div class="alert alert-success login-alert">สมัครสมาชิกสำเร็จ กรุณาเข้าสู่ระบบ</div>
            </c:if>

          <form class="login-form" action="${pageContext.request.contextPath}/login" method="post" autocomplete="on">
            <input type="hidden" name="loginRole" value="${loginRole}">
            <div class="mb-3">
              <label class="form-label" for="username">ชื่อผู้ใช้</label>
              <input id="username" type="text" name="username" class="form-control" placeholder="กรอกชื่อผู้ใช้" required autofocus autocomplete="username">
            </div>
            <div class="mb-4">
              <label class="form-label" for="password">รหัสผ่าน</label>
              <input id="password" type="password" name="password" class="form-control" placeholder="กรอกรหัสผ่าน" required autocomplete="current-password">
            </div>
            <button type="submit" class="btn btn-primary login-submit w-100">เข้าสู่ระบบ</button>
          </form>

          <div class="login-role-picker">
            <span>เข้าสู่ระบบในบทบาทอื่น</span>
            <div class="login-role-links">
              <a class="${loginRole == 'ROLE_PATIENT' ? 'active' : ''}" href="${pageContext.request.contextPath}/patient/login">ผู้ป่วย</a>
              <a class="${loginRole == 'ROLE_NURSE' ? 'active' : ''}" href="${pageContext.request.contextPath}/nurse/login">พยาบาล</a>
              <a class="${loginRole == 'ROLE_DENTIST' ? 'active' : ''}" href="${pageContext.request.contextPath}/dentist/login">ทันตแพทย์</a>
              <a class="${loginRole == 'ROLE_ADMIN' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/login">แอดมิน</a>
            </div>
          </div>

          <c:if test="${loginRole == 'ROLE_PATIENT'}">
            <p class="login-register">ยังไม่มีบัญชี? <a href="${pageContext.request.contextPath}/register/patient">สมัครสมาชิกผู้ป่วย</a></p>
          </c:if>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
