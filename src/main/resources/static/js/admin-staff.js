document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("[data-staff-form]").forEach((form) => {
    const field = (name) => form.elements.namedItem(name);
    const fields = {
      username: field("username"), password: field("password"), firstName: field("firstName"),
      lastName: field("lastName"), phone: field("phone"), email: field("email")
    };
    const patterns = {
      username: /^[A-Za-z0-9]{4,8}$/,
      password: /^[A-Za-z0-9!#_.]{8,16}$/,
      name: /^[A-Za-z\u0E01-\u0E2E\u0E30-\u0E3A\u0E40-\u0E4E]{2,20}$/,
      phone: /^[0-9]{10}$/
    };
    const setState = (input, valid, message) => {
      input.setCustomValidity(valid ? "" : message);
      input.classList.toggle("is-valid", valid && input.value.length > 0);
      input.classList.toggle("is-invalid", !valid && input.value.length > 0);
      return valid;
    };
    const validators = {
      username: () => setState(fields.username, patterns.username.test(fields.username.value), "Username ต้องเป็นภาษาอังกฤษหรือตัวเลข 4-8 ตัว และไม่มีช่องว่าง"),
      password: () => setState(fields.password, patterns.password.test(fields.password.value), "รหัสผ่านใช้ได้เฉพาะ A-Z, 0-9, !, #, _, . ความยาว 8-16 ตัว และไม่มีช่องว่าง"),
      firstName: () => setState(fields.firstName, patterns.name.test(fields.firstName.value), "ชื่อต้องเป็นภาษาไทยหรืออังกฤษ 2-20 ตัวอักษร และไม่มีช่องว่าง"),
      lastName: () => setState(fields.lastName, patterns.name.test(fields.lastName.value), "นามสกุลต้องเป็นภาษาไทยหรืออังกฤษ 2-20 ตัวอักษร และไม่มีช่องว่าง"),
      phone: () => setState(fields.phone, patterns.phone.test(fields.phone.value), "เบอร์โทรศัพท์ต้องเป็นตัวเลข 10 หลักและไม่มีช่องว่าง"),
      email: () => {
        fields.email.setCustomValidity("");
        const valid = fields.email.value.length >= 5 && fields.email.value.length <= 60 && !/\s/.test(fields.email.value) && fields.email.validity.valid;
        return setState(fields.email, valid, "กรุณากรอกอีเมลให้ถูกต้อง ความยาว 5-60 ตัวอักษร และไม่มีช่องว่าง");
      }
    };
    Object.entries(validators).forEach(([name, validate]) => fields[name].addEventListener("input", validate));
    form.addEventListener("submit", (event) => {
      if (!Object.values(validators).map((validate) => validate()).every(Boolean)) {
        event.preventDefault();
        form.reportValidity();
      }
    });
  });
});
