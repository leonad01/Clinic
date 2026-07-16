package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "patients")
public class Patient {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank(message = "กรุณากรอกชื่อ") private String firstName;
    @NotBlank(message = "กรุณากรอกนามสกุล") private String lastName;
    @NotBlank(message = "กรุณากรอก username") @Column(unique = true)
    private String username;
    @Column(unique = true, nullable = false)
    private String email;
    @NotBlank(message = "กรุณาเลือกวันเกิด") private String dateOfBirth;
    @NotBlank(message = "กรุณาเลือกเพศ") private String gender;
    @NotBlank(message = "กรุณากรอกรหัสผ่าน") @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    @Transient private String confirmPassword;
    private String role = "PATIENT";
    public Long getId() { return id; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
    public String getRole() { return role; }
}
