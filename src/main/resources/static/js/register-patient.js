document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("[data-register-form]");
  if (!form) return;

  const firstName = form.querySelector("#firstName");
  const lastName = form.querySelector("#lastName");
  const idCard = form.querySelector("#idCard");
  const phone = form.querySelector("#phone");
  const email = form.querySelector("#email");
  const username = form.querySelector("#username");
  const dateOfBirth = form.querySelector("#dateOfBirth");
  const password = form.querySelector("#passwordHash");
  const confirmPassword = form.querySelector("#confirmPassword");
  const passwordHint = form.querySelector("[data-password-hint]");
  const confirmHint = form.querySelector("[data-confirm-hint]");
  const idCardHint = form.querySelector("[data-id-card-hint]");
  const phoneHint = form.querySelector("[data-phone-hint]");
  const usernamePattern = /^[A-Za-z0-9]{4,8}$/;
  const patientNamePattern = /^[A-Za-z\u0E01-\u0E2E\u0E30-\u0E3A\u0E40-\u0E4E]{2,20}$/;
  const passwordPattern = /^[A-Za-z0-9!#_.]{8,16}$/;

  const setState = (field, valid, message = "") => {
    field.setCustomValidity(valid ? "" : message);
    field.classList.toggle("is-valid", valid && field.value.length > 0);
    field.classList.toggle("is-invalid", !valid && field.value.length > 0);
    return valid;
  };

  const validateFirstName = () =>
    setState(firstName, patientNamePattern.test(firstName.value), "ชื่อต้องเป็นภาษาไทยหรืออังกฤษ 2-20 ตัวอักษร และไม่มีช่องว่าง");

  const validateLastName = () =>
    setState(lastName, patientNamePattern.test(lastName.value), "นามสกุลต้องเป็นภาษาไทยหรืออังกฤษ 2-20 ตัวอักษร และไม่มีช่องว่าง");

  firstName.addEventListener("input", validateFirstName);

  const validateName = (field, label) =>
    setState(field, field.value.trim().length >= 2, `กรุณากรอก${label}อย่างน้อย 2 ตัวอักษร`);

  const validateIdCard = () => {
    const value = idCard.value;
    const valid = /^[0-9]{13}$/.test(value);
    setState(idCard, valid, "กรุณากรอกเลขบัตรประชาชน 13 หลัก โดยไม่มีช่องว่าง");
    idCardHint.textContent = value ? (valid ? "กรอกตัวเลขครบ 13 หลักแล้ว" : "กรุณากรอกตัวเลข 13 หลัก โดยไม่มีช่องว่าง") : "กรอกตัวเลข 13 หลัก";
    idCardHint.className = `form-text ${valid ? "text-success" : value ? "text-danger" : "text-secondary"}`;
    return valid;
  };

  const validateUsername = () =>
    setState(username, usernamePattern.test(username.value), "Username ต้องเป็นภาษาอังกฤษหรือตัวเลข 4-8 ตัว และไม่มีช่องว่าง");

  const validatePhone = () => {
    const valid = /^[0-9]{10}$/.test(phone.value);
    setState(phone, valid, "กรุณากรอกเบอร์โทรศัพท์เป็นตัวเลข 10 หลัก โดยไม่มีช่องว่าง");
    phoneHint.textContent = phone.value ? (valid ? "เบอร์โทรศัพท์ถูกต้อง" : "กรุณากรอกตัวเลข 10 หลัก โดยไม่มีช่องว่าง") : "กรอกตัวเลข 10 หลัก";
    phoneHint.className = `form-text ${valid ? "text-success" : phone.value ? "text-danger" : "text-secondary"}`;
    return valid;
  };

  const validateEmail = () => {
    email.setCustomValidity("");
    const valid =
      email.value.length >= 5 &&
      email.value.length <= 60 &&
      !/\s/.test(email.value) &&
      email.validity.valid;
    return setState(email, valid, "กรุณากรอกอีเมลให้ถูกต้อง ความยาว 5-60 ตัวอักษร และไม่มีช่องว่าง");
  };

  const validateDateOfBirth = () => {
    const valid = Boolean(dateOfBirth.value) && dateOfBirth.value <= new Date().toISOString().slice(0, 10);
    return setState(dateOfBirth, valid, "กรุณาเลือกวันเกิดที่ไม่เกินวันปัจจุบัน");
  };

  const validatePassword = () => {
    const valid = passwordPattern.test(password.value);
    setState(password, valid, "รหัสผ่านใช้ได้เฉพาะ A-Z, 0-9, !, #, _, . ความยาว 8-16 ตัว และไม่มีช่องว่าง");
    passwordHint.textContent = valid ? "รหัสผ่านมีรูปแบบที่ใช้ได้" : "ใช้ A-Z, 0-9, !, #, _, . ความยาว 8-16 ตัว และไม่มีช่องว่าง";
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
  firstName.addEventListener("input", validateFirstName);
  lastName.addEventListener("input", validateLastName);
  idCard.addEventListener("input", validateIdCard);
  phone.addEventListener("input", validatePhone);
  email.addEventListener("input", validateEmail);
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
      validateEmail(),
      validateUsername(),
      validateDateOfBirth(),
      validatePassword(),
      validateConfirmation()
    ].every(Boolean);
    if (!valid || !validateFirstName() || !validateLastName()) {
      event.preventDefault();
      form.reportValidity();
    }
  });
});
