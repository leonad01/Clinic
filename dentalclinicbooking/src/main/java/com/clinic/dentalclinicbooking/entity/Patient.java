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
import jakarta.validation.constraints.Pattern;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotBlank(message = "กรุณากรอกชื่อ")
  private String firstName;

  @NotBlank(message = "กรุณากรอกนามสกุล")
  private String lastName;

  @NotBlank(message = "กรุณากรอก username")
  @Column(unique = true)
  private String username;

  @Column(unique = true, nullable = false)
  private String email;

  @NotBlank(message = "กรุณากรอกเลขบัตรประชาชน")
  @Pattern(regexp = "\\d{13}", message = "เลขบัตรประชาชนต้องมี 13 หลัก")
  @Column(name = "id_card", unique = true)
  private String idCard;

  @NotBlank(message = "กรุณากรอกเบอร์โทรศัพท์")
  @Pattern(regexp = "0\\d{9}", message = "เบอร์โทรศัพท์ต้องเป็นตัวเลข 10 หลักและขึ้นต้นด้วย 0")
  @Column(nullable = false, length = 10)
  private String phone;

  @NotBlank(message = "กรุณาเลือกวันเกิด")
  private String dateOfBirth;

  @NotBlank(message = "กรุณาเลือกเพศ")
  private String gender;

  @NotBlank(message = "กรุณากรอกรหัสผ่าน")
  @Column(name = "password_hash", nullable = false)
  private String passwordHash;

  @Transient private String confirmPassword;
  private String role = "PATIENT";

  @OneToMany(mappedBy = "patient")
  private List<Appointment> appointments = new ArrayList<>();

  @OneToMany(mappedBy = "patient")
  private List<TreatmentHistory> treatmentHistories = new ArrayList<>();

  public Long getId() {
    return id;
  }

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getIdCard() {
    return idCard;
  }

  public void setIdCard(String idCard) {
    this.idCard = idCard;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getDateOfBirth() {
    return dateOfBirth;
  }

  public void setDateOfBirth(String dateOfBirth) {
    this.dateOfBirth = dateOfBirth;
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

  public String getPasswordHash() {
    return passwordHash;
  }

  public void setPasswordHash(String passwordHash) {
    this.passwordHash = passwordHash;
  }

  public String getConfirmPassword() {
    return confirmPassword;
  }

  public void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
  }

  public String getRole() {
    return role;
  }

  public List<Appointment> getAppointments() {
    return appointments;
  }

  public List<TreatmentHistory> getTreatmentHistories() {
    return treatmentHistories;
  }
}
