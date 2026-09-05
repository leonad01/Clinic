package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "dentists")
public class Dentist {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "dentist_id")
  private Long id;

  @Column(name = "dentist_username", nullable = false, unique = true)
  private String username;

  @Column(name = "dentist_password", nullable = false)
  private String password;

  @Column(name = "dentist_first_name", nullable = false)
  private String firstName;

  @Column(name = "dentist_last_name", nullable = false)
  private String lastName;

  @Column(name = "dentist_phone")
  private String phone;

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
