document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("[data-register-form]");
  if (!form) return;

  const firstName = form.querySelector("#firstName");
  const lastName = form.querySelector("#lastName");
  const idCard = form.querySelector("#idCard");
  const phone = form.querySelector("#phone");
  const username = form.querySelector("#username");
  const dateOfBirth = form.querySelector("#dateOfBirth");
  const password = form.querySelector("#passwordHash");
  const confirmPassword = form.querySelector("#confirmPassword");
  const passwordHint = form.querySelector("[data-password-hint]");
  const confirmHint = form.querySelector("[data-confirm-hint]");
  const idCardHint = form.querySelector("[data-id-card-hint]");
  const phoneHint = form.querySelector("[data-phone-hint]");
  const usernamePattern = /^[A-Za-z0-9_-]{4,30}$/;

  const setState = (field, valid, message = "") => {
    field.setCustomValidity(valid ? "" : message);
    field.classList.toggle("is-valid", valid && field.value.length > 0);
    field.classList.toggle("is-invalid", !valid && field.value.length > 0);
    return valid;
  };

  const validateName = (field, label) =>
    setState(field, field.value.trim().length >= 2, `กรุณากรอก${label}อย่างน้อย 2 ตัวอักษร`);

  const validateIdCard = () => {
    idCard.value = idCard.value.replace(/\D/g, "").slice(0, 13);
    const value = idCard.value;
    const valid = /^\d{13}$/.test(value);
    setState(idCard, valid, "กรุณากรอกตัวเลขให้ครบ 13 หลัก");
    idCardHint.textContent = value ? (valid ? "กรอกตัวเลขครบ 13 หลักแล้ว" : "กรุณากรอกตัวเลขให้ครบ 13 หลัก") : "โหมดสาธิต: ใช้ตัวเลข 13 หลักที่ไม่ซ้ำกัน";
    idCardHint.className = `form-text ${valid ? "text-success" : value ? "text-danger" : "text-secondary"}`;
    return valid;
  };

  const validateUsername = () =>
    setState(username, usernamePattern.test(username.value), "Username ต้องมี 4-30 ตัว และใช้ได้เฉพาะ A-Z, 0-9, _ หรือ -");

  const validatePhone = () => {
    phone.value = phone.value.replace(/\D/g, "").slice(0, 10);
    const valid = /^0\d{9}$/.test(phone.value);
    setState(phone, valid, "กรุณากรอกเบอร์โทรศัพท์ 10 หลัก ขึ้นต้นด้วย 0");
    phoneHint.textContent = phone.value ? (valid ? "เบอร์โทรศัพท์ถูกต้อง" : "กรุณากรอกตัวเลข 10 หลัก ขึ้นต้นด้วย 0") : "กรอกตัวเลข 10 หลัก ขึ้นต้นด้วย 0";
    phoneHint.className = `form-text ${valid ? "text-success" : phone.value ? "text-danger" : "text-secondary"}`;
    return valid;
  };

  const validateDateOfBirth = () => {
    const valid = Boolean(dateOfBirth.value) && dateOfBirth.value <= new Date().toISOString().slice(0, 10);
    return setState(dateOfBirth, valid, "กรุณาเลือกวันเกิดที่ไม่เกินวันปัจจุบัน");
  };

  const validatePassword = () => {
    const valid = password.value.length >= 8;
    setState(password, valid, "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร");
    passwordHint.textContent = valid ? "รหัสผ่านมีความยาวที่ใช้ได้" : "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร";
    passwordHint.className = `form-text ${valid && password.value ? "text-success" : "text-secondary"}`;
    return valid;
  };

  const validateConfirmation = () => {
    const valid = confirmPassword.value.length > 0 && password.value === confirmPassword.value;
    setState(confirmPassword, valid, "รหัสผ่านยืนยันไม่ตรงกับรหัสผ่าน");
    confirmHint.textContent = confirmPassword.value ? (valid ? "รหัสผ่านตรงกัน" : "รหัสผ่านยืนยันไม่ตรงกัน") : "";
    confirmHint.className = `form-text ${valid ? "text-success" : "text-danger"}`;
    return valid;
  };

  firstName.addEventListener("input", () => validateName(firstName, "ชื่อ"));
  lastName.addEventListener("input", () => validateName(lastName, "นามสกุล"));
  idCard.addEventListener("input", validateIdCard);
  phone.addEventListener("input", validatePhone);
  username.addEventListener("input", validateUsername);
  dateOfBirth.max = new Date().toISOString().slice(0, 10);
  dateOfBirth.addEventListener("change", validateDateOfBirth);
  password.addEventListener("input", () => { validatePassword(); if (confirmPassword.value) validateConfirmation(); });
  confirmPassword.addEventListener("input", validateConfirmation);

  form.querySelectorAll("[data-toggle-password]").forEach((button) => {
    button.addEventListener("click", () => {
      const field = form.querySelector(`#${button.dataset.togglePassword}`);
      const hidden = field.type === "password";
      field.type = hidden ? "text" : "password";
      button.querySelector("span").textContent = hidden ? "🙈" : "👁";
      button.setAttribute("aria-label", hidden ? "ซ่อนรหัสผ่าน" : "แสดงรหัสผ่าน");
      button.setAttribute("title", hidden ? "ซ่อนรหัสผ่าน" : "แสดงรหัสผ่าน");
    });
  });

  form.addEventListener("submit", (event) => {
    const valid = [
      validateName(firstName, "ชื่อ"),
      validateName(lastName, "นามสกุล"),
      validateIdCard(),
      validatePhone(),
      validateUsername(),
      validateDateOfBirth(),
      validatePassword(),
      validateConfirmation()
    ].every(Boolean);
    if (!valid) {
      event.preventDefault();
      form.reportValidity();
    }
  });
});
