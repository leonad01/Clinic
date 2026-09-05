document.addEventListener("DOMContentLoaded", () => {
  const usernamePattern = /^[A-Za-z0-9_-]{4,30}$/;
  const phonePattern = /^0\d{8,9}$/;

  document.querySelectorAll("[data-staff-form]").forEach((form) => {
    const field = (name) => form.elements.namedItem(name);
    const username = field("username");
    const password = field("password");
    const firstName = field("firstName");
    const lastName = field("lastName");
    const phone = field("phone");
    const email = field("email");
    const message = form.querySelector("[data-form-message]");

    const setState = (input, valid, error = "") => {
      input.setCustomValidity(valid ? "" : error);
      input.classList.toggle("is-valid", valid && input.value.length > 0);
      input.classList.toggle("is-invalid", !valid && input.value.length > 0);
      return valid;
    };

    const validateUsername = () =>
      setState(username, usernamePattern.test(username.value), "Username ใช้ A-Z, 0-9, _ หรือ - จำนวน 4-30 ตัว");
    const validatePassword = () =>
      setState(password, password.value.length >= 8, "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร");
    const validateName = (input, label) =>
      setState(input, input.value.trim().length >= 2, `กรุณากรอก${label}อย่างน้อย 2 ตัวอักษร`);
    const validatePhone = () => {
      const digits = phone.value.replace(/[-\s]/g, "");
      return setState(phone, !digits || phonePattern.test(digits), "กรุณากรอกเบอร์โทร 9-10 หลัก ขึ้นต้นด้วย 0");
    };
    const validateEmail = () => setState(email, !email.value || email.validity.valid, "รูปแบบอีเมลไม่ถูกต้อง");

    username.addEventListener("input", validateUsername);
    password.addEventListener("input", validatePassword);
    firstName.addEventListener("input", () => validateName(firstName, "ชื่อ"));
    lastName.addEventListener("input", () => validateName(lastName, "นามสกุล"));
    phone.addEventListener("input", validatePhone);
    email.addEventListener("input", validateEmail);

    form.querySelector("[data-toggle-password]").addEventListener("click", (event) => {
      const hidden = password.type === "password";
      password.type = hidden ? "text" : "password";
      const button = event.currentTarget;
      button.querySelector("span").textContent = hidden ? "🙈" : "👁";
      button.setAttribute("aria-label", hidden ? "ซ่อนรหัสผ่าน" : "แสดงรหัสผ่าน");
      button.setAttribute("title", hidden ? "ซ่อนรหัสผ่าน" : "แสดงรหัสผ่าน");
    });

    form.addEventListener("submit", (event) => {
      const valid = [
        validateUsername(),
        validatePassword(),
        validateName(firstName, "ชื่อ"),
        validateName(lastName, "นามสกุล"),
        validatePhone(),
        validateEmail()
      ].every(Boolean);
      if (!valid) {
        event.preventDefault();
        message.textContent = "กรุณาตรวจสอบข้อมูลที่ทำเครื่องหมายสีแดง";
        message.className = "small mb-2 text-danger fw-semibold";
        form.reportValidity();
      }
    });
  });
});
