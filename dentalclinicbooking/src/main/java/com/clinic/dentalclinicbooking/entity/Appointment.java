package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "appointments")
public class Appointment {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String patientName;
  private String phone;
  private String appointmentDate;
  private String appointmentTime;
  private String appointmentEndTime;
  private String service;
  private String email;
  private String notes;
  private String status = "PENDING";

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "patient_id")
  private Patient patient;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "dentist_id")
  private Dentist dentist;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "nurse_id")
  private Nurse nurse;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "service_id")
  private DentalService dentalService;

  @OneToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "dentist_schedule_id", unique = true)
  private DentistSchedule dentistSchedule;

  @OneToOne(mappedBy = "appointment")
  private TreatmentHistory treatmentHistory;

  public Long getId() {
    return id;
  }

  public String getPatientName() {
    return patientName;
  }

  public void setPatientName(String patientName) {
    this.patientName = patientName;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getAppointmentDate() {
    return appointmentDate;
  }

  public void setAppointmentDate(String appointmentDate) {
    this.appointmentDate = appointmentDate;
  }

  public String getAppointmentTime() {
    return appointmentTime;
  }

  public void setAppointmentTime(String appointmentTime) {
    this.appointmentTime = appointmentTime;
  }

  public String getAppointmentEndTime() {
    return appointmentEndTime;
  }

  public void setAppointmentEndTime(String appointmentEndTime) {
    this.appointmentEndTime = appointmentEndTime;
  }

  public String getService() {
    return service;
  }

  public void setService(String service) {
    this.service = service;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getNotes() {
    return notes;
  }

  public void setNotes(String notes) {
    this.notes = notes;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
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

  public Nurse getNurse() {
    return nurse;
  }

  public void setNurse(Nurse nurse) {
    this.nurse = nurse;
  }

  public DentalService getDentalService() {
    return dentalService;
  }

  public void setDentalService(DentalService dentalService) {
    this.dentalService = dentalService;
  }

  public DentistSchedule getDentistSchedule() {
    return dentistSchedule;
  }

  public void setDentistSchedule(DentistSchedule dentistSchedule) {
    this.dentistSchedule = dentistSchedule;
  }

  public TreatmentHistory getTreatmentHistory() {
    return treatmentHistory;
  }
}
