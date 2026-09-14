package com.clinic.dentalclinicbooking.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "dentist_schedules")
public class DentistSchedule {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "schedule_id")
  private Long id;

  @Column(name = "schedule_date", nullable = false)
  private String scheduleDate;

  @Column(name = "schedule_start_time", nullable = false)
  private String startTime;

  @Column(name = "schedule_end_time", nullable = false)
  private String endTime;

  @Column(name = "schedule_status", nullable = false)
  private String status;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "dentist_id", nullable = false)
  private Dentist dentist;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "room_id", nullable = false)
  private Room room;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "nurse_id")
  private Nurse nurse;

  @OneToOne(mappedBy = "dentistSchedule")
  private Appointment appointment;

  public Long getId() {
    return id;
  }

  public String getScheduleDate() {
    return scheduleDate;
  }

  public void setScheduleDate(String scheduleDate) {
    this.scheduleDate = scheduleDate;
  }

  public String getStartTime() {
    return startTime;
  }

  public void setStartTime(String startTime) {
    this.startTime = startTime;
  }

  public String getEndTime() {
    return endTime;
  }

  public void setEndTime(String endTime) {
    this.endTime = endTime;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public Dentist getDentist() {
    return dentist;
  }

  public void setDentist(Dentist dentist) {
    this.dentist = dentist;
  }

  public Room getRoom() {
    return room;
  }

  public void setRoom(Room room) {
    this.room = room;
  }

  public Nurse getNurse() {
    return nurse;
  }

  public void setNurse(Nurse nurse) {
    this.nurse = nurse;
  }

  public Appointment getAppointment() {
    return appointment;
  }
}
