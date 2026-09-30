package com.clinic.dentalclinicbooking.service;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.entity.TreatmentHistory;
import com.clinic.dentalclinicbooking.repository.AppointmentRepository;
import com.clinic.dentalclinicbooking.repository.TreatmentHistoryRepository;
import java.time.LocalDate;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AppointmentService {

  private final AppointmentRepository appointmentRepository;
  private final TreatmentHistoryRepository treatmentHistoryRepository;
  private final DentistScheduleRepository dentistScheduleRepository;

  public AppointmentService(
      AppointmentRepository appointmentRepository,
      TreatmentHistoryRepository treatmentHistoryRepository,
      DentistScheduleRepository dentistScheduleRepository) {
    this.appointmentRepository = appointmentRepository;
    this.treatmentHistoryRepository = treatmentHistoryRepository;
    this.dentistScheduleRepository = dentistScheduleRepository;
  }

  public Appointment save(Appointment appointment) {
    return appointmentRepository.save(appointment);
  }

  @Transactional
  public Appointment reserveAvailableSchedule(Appointment appointment, Long scheduleId) {
    var schedule = dentistScheduleRepository.findByIdForUpdate(scheduleId).orElse(null);
    if (schedule == null
        || !"AVAILABLE".equals(schedule.getStatus())
        || appointmentRepository.existsByDentistScheduleId(scheduleId)) {
      return null;
    }

    appointment.setDentistSchedule(schedule);
    appointment.setDentist(schedule.getDentist());
    appointment.setAppointmentDate(schedule.getScheduleDate());
    appointment.setAppointmentTime(schedule.getStartTime());
    appointment.setAppointmentEndTime(schedule.getEndTime());
    return appointmentRepository.saveAndFlush(appointment);
  }

  public List<Appointment> findAll() {
    return appointmentRepository.findAll();
  }

  public List<Appointment> findForPatient(String username) {
    return appointmentRepository.findByPatientUsernameOrderByAppointmentDateDesc(username);
  }

  public Appointment findById(Long id) {
    return appointmentRepository.findById(id).orElseThrow();
  }

  public void approve(Long id) {
    Appointment appointment = appointmentRepository.findById(id).orElseThrow();
    appointment.setStatus("APPROVED");
    appointmentRepository.save(appointment);
  }

  public boolean cancel(Long id) {
    Appointment appointment = appointmentRepository.findById(id).orElseThrow();
    if (!"PENDING".equals(appointment.getStatus()) && !"APPROVED".equals(appointment.getStatus())) {
      return false;
    }
    appointment.setStatus("CANCELLED");
    appointment.setDentistSchedule(null);
    appointmentRepository.save(appointment);
    return true;
  }

  @Transactional
  public boolean complete(Appointment appointment, String treatmentNote) {
    if (appointment.getPatient() == null
        || appointment.getDentist() == null
        || !"APPROVED".equals(appointment.getStatus())
        || treatmentHistoryRepository.existsByAppointmentId(appointment.getId())) {
      return false;
    }

    TreatmentHistory history = new TreatmentHistory();
    history.setAppointment(appointment);
    history.setPatient(appointment.getPatient());
    history.setDentist(appointment.getDentist());
    history.setTreatmentDate(LocalDate.now().toString());
    history.setNote(treatmentNote == null || treatmentNote.isBlank() ? "รับบริการเรียบร้อย" : treatmentNote.trim());
    treatmentHistoryRepository.save(history);

    appointment.setStatus("COMPLETED");
    appointmentRepository.save(appointment);
    return true;
  }
}
