package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotBlank(message = "กรุณากรอกชื่อ")
  @Size(min = 2, max = 20, message = "ชื่อต้องมีความยาว 2-20 ตัวอักษร")
  @Pattern(regexp = "[A-Za-z\\u0E01-\\u0E2E\\u0E30-\\u0E3A\\u0E40-\\u0E4E]+", message = "ชื่อต้องเป็นภาษาไทยหรืออังกฤษเท่านั้น และไม่มีช่องว่าง")
  private String firstName;

  @NotBlank(message = "กรุณากรอกนามสกุล")
  @Size(min = 2, max = 20, message = "นามสกุลต้องมีความยาว 2-20 ตัวอักษร")
  @Pattern(regexp = "[A-Za-z\\u0E01-\\u0E2E\\u0E30-\\u0E3A\\u0E40-\\u0E4E]+", message = "นามสกุลต้องเป็นภาษาไทยหรืออังกฤษเท่านั้น และไม่มีช่องว่าง")
  private String lastName;

  @NotBlank(message = "กรุณากรอก username")
  @Size(min = 4, max = 8, message = "Username ต้องมีความยาว 4-8 ตัวอักษร")
  @Pattern(regexp = "[A-Za-z0-9]+", message = "Username ต้องเป็นภาษาอังกฤษหรือตัวเลขเท่านั้น และไม่มีช่องว่าง")
  @Column(unique = true)
  private String username;

  @NotBlank(message = "กรุณากรอกอีเมล")
  @Size(min = 5, max = 60, message = "อีเมลต้องมีความยาว 5-60 ตัวอักษร")
  @Email(message = "รูปแบบอีเมลไม่ถูกต้อง")
  @Pattern(regexp = "\\S+", message = "อีเมลต้องไม่มีช่องว่าง")
  @Column(unique = true, nullable = false, length = 60)
  private String email;

  @NotBlank(message = "กรุณากรอกเลขบัตรประชาชน")
  @Pattern(regexp = "[0-9]{13}", message = "เลขบัตรประชาชนต้องเป็นตัวเลข 13 หลักและไม่มีช่องว่าง")
  @Column(name = "id_card", unique = true)
  private String idCard;

  @NotBlank(message = "กรุณากรอกเบอร์โทรศัพท์")
  @Pattern(regexp = "[0-9]{10}", message = "เบอร์โทรศัพท์ต้องเป็นตัวเลข 10 หลักและไม่มีช่องว่าง")
  @Column(nullable = false, length = 10)
  private String phone;

  @NotBlank(message = "กรุณาเลือกวันเกิด")
  private String dateOfBirth;

  @NotBlank(message = "กรุณาเลือกเพศ")
  private String gender;

  @NotBlank(message = "กรุณากรอกรหัสผ่าน")
  @Size(min = 8, max = 16, message = "รหัสผ่านต้องมีความยาว 8-16 ตัวอักษร")
  @Pattern(regexp = "[A-Za-z0-9!#_.]+", message = "รหัสผ่านใช้ได้เฉพาะ A-Z, 0-9, !, #, _, . และไม่มีช่องว่าง")
  @Column(name = "password_hash", nullable = false)
  private String passwordHash;

  @Transient private String confirmPassword;
  private String role = "PATIENT";

  @OneToMany(mappedBy = "patient")
  private List<Appointment> appointments = new ArrayList<>();

  @OneToMany(mappedBy = "patient")
  private List<TreatmentHistory> treatmentHistories = new ArrayList<>();

  public Long getId() { return id; }
  public String getFirstName() { return firstName; }
  public void setFirstName(String firstName) { this.firstName = firstName; }
  public String getLastName() { return lastName; }
  public void setLastName(String lastName) { this.lastName = lastName; }
  public String getUsername() { return username; }
  public void setUsername(String username) { this.username = username; }
  public String getEmail() { return email; }
  public void setEmail(String email) { this.email = email; }
  public String getIdCard() { return idCard; }
  public void setIdCard(String idCard) { this.idCard = idCard; }
  public String getPhone() { return phone; }
  public void setPhone(String phone) { this.phone = phone; }
  public String getDateOfBirth() { return dateOfBirth; }
  public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }
  public String getGender() { return gender; }
  public void setGender(String gender) { this.gender = gender; }
  public String getPasswordHash() { return passwordHash; }
  public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
  public String getConfirmPassword() { return confirmPassword; }
  public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
  public String getRole() { return role; }
  public List<Appointment> getAppointments() { return appointments; }
  public List<TreatmentHistory> getTreatmentHistories() { return treatmentHistories; }
}
