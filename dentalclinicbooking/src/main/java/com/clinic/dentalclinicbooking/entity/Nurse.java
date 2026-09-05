package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "nurses")
public class Nurse {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "nurse_id")
  private Long id;

  @Column(name = "nurse_username", nullable = false, unique = true)
  private String username;

  @Column(name = "nurse_password", nullable = false)
  private String password;

  @Column(name = "nurse_first_name", nullable = false)
  private String firstName;

  @Column(name = "nurse_last_name", nullable = false)
  private String lastName;

  @Column(name = "nurse_phone")
  private String phone;

  @Column(name = "nurse_email", unique = true)
  private String email;

  @OneToMany(mappedBy = "nurse")
  private List<Appointment> appointments = new ArrayList<>();

  @OneToMany(mappedBy = "nurse")
  private List<DentistSchedule> schedules = new ArrayList<>();

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
