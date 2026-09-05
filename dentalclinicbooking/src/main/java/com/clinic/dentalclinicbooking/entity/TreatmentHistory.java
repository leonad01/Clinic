package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "treatment_histories")
public class TreatmentHistory {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "treatment_id")
  private Long id;

  @Column(name = "treatment_date", nullable = false)
  private String treatmentDate;

  @Column(name = "note", length = 2000)
  private String note;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "patient_id", nullable = false)
  private Patient patient;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "dentist_id", nullable = false)
  private Dentist dentist;

  @OneToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "appointment_id", nullable = false, unique = true)
  private Appointment appointment;

  public Long getId() {
    return id;
  }

  public String getTreatmentDate() {
    return treatmentDate;
  }

  public void setTreatmentDate(String treatmentDate) {
    this.treatmentDate = treatmentDate;
  }

  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
  }

  public Patient getPatient() {
    return patient;
  }

  public void setPatient(Patient patient) {
    this.patient = patient;
  }

  public Dentist getDentist() {
    return dentist;
  }

  public void setDentist(Dentist dentist) {
    this.dentist = dentist;
  }

  public Appointment getAppointment() {
    return appointment;
  }

  public void setAppointment(Appointment appointment) {
    this.appointment = appointment;
  }
}
