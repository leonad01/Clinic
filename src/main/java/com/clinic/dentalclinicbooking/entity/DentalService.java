package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "services")
public class DentalService {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "service_id")
  private Long id;

  @Column(name = "service_name", nullable = false, unique = true)
  private String name;

  @Column(name = "service_price", nullable = false)
  private String price;

  @Column(name = "service_duration")
  private String duration;

  @Column(name = "service_category")
  private String category;

  @Column(name = "service_description", length = 1000)
  private String description;

  @OneToMany(mappedBy = "dentalService")
  private List<Appointment> appointments = new ArrayList<>();

  public Long getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getPrice() {
    return price;
  }

  public void setPrice(String price) {
    this.price = price;
  }

  public String getDuration() {
    return duration;
  }

  public void setDuration(String duration) {
    this.duration = duration;
  }

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }
}
