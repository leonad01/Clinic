package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "dentists")
public class Dentist {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "dentist_id")
  private Long id;

  @NotBlank @Size(min = 4, max = 8) @Pattern(regexp = "[A-Za-z0-9]+")
  @Column(name = "dentist_username", nullable = false, unique = true)
  private String username;

  @NotBlank @Size(min = 8, max = 16) @Pattern(regexp = "[A-Za-z0-9!#_.]+")
  @Column(name = "dentist_password", nullable = false)
  private String password;

  @NotBlank @Size(min = 2, max = 20) @Pattern(regexp = "[A-Za-z\\u0E01-\\u0E2E\\u0E30-\\u0E3A\\u0E40-\\u0E4E]+")
  @Column(name = "dentist_first_name", nullable = false)
  private String firstName;

  @NotBlank @Size(min = 2, max = 20) @Pattern(regexp = "[A-Za-z\\u0E01-\\u0E2E\\u0E30-\\u0E3A\\u0E40-\\u0E4E]+")
  @Column(name = "dentist_last_name", nullable = false)
  private String lastName;

  @NotBlank @Pattern(regexp = "[0-9]{10}")
  @Column(name = "dentist_phone")
  private String phone;

  @NotBlank @Size(min = 5, max = 60) @Email @Pattern(regexp = "\\S+")
  @Column(name = "dentist_email", unique = true)
  private String email;

  @OneToMany(mappedBy = "dentist")
  private List<DentistSchedule> schedules = new ArrayList<>();

  @OneToMany(mappedBy = "dentist")
  private List<Appointment> appointments = new ArrayList<>();

  @OneToMany(mappedBy = "dentist")
  private List<TreatmentHistory> treatmentHistories = new ArrayList<>();

  public Long getId() {
    return id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
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

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }
}
