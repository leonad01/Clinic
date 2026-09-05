package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "admins")
public class Admin {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "admin_id")
  private Long id;

  @Column(name = "admin_username", nullable = false, unique = true)
  private String username;

  @Column(name = "admin_password", nullable = false)
  private String password;

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
}
