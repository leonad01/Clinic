package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "rooms")
public class Room {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "room_id")
  private Long id;

  @Column(name = "room_name", nullable = false, unique = true)
  private String name;

  @Column(name = "room_status", nullable = false)
  private String status;

  @OneToMany(mappedBy = "room")
  private List<DentistSchedule> schedules = new ArrayList<>();

  public Long getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
