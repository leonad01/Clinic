package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.service.AppointmentService;
import java.util.ArrayList;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PatientController {
  private final AppointmentService appointmentService;
  private final DentistScheduleRepository dentistScheduleRepository;

  public PatientController(
      AppointmentService appointmentService,
      DentistScheduleRepository dentistScheduleRepository) {
    this.appointmentService = appointmentService;
    this.dentistScheduleRepository = dentistScheduleRepository;
  }

  @GetMapping("/patient/appointments")
  public String appointments(Authentication auth, Model model) {
    model.addAttribute("appointments", appointmentService.findForPatient(auth.getName()));
    return "patient-appointments";
  }

  @GetMapping("/patient/treatment-history")
  public String patientTreatmentHistoryUnavailable() {
    return "redirect:/access-denied";
  }

  @GetMapping("/patient/appointments/{id}")
  public String appointment(@PathVariable Long id, Authentication auth, Model model) {
    var appointment = appointmentService.findById(id);
    if (appointment.getPatient() == null
        || !auth.getName().equals(appointment.getPatient().getUsername()))
      return "redirect:/patient/appointments";
    model.addAttribute("appointment", appointment);
    return "patient-appointment-detail";
  }

  @PostMapping("/patient/appointments/{id}/cancel")
  public String cancel(@PathVariable Long id, Authentication auth) {
    var appointment = appointmentService.findById(id);
    if (appointment.getPatient() != null
        && auth.getName().equals(appointment.getPatient().getUsername())
        && appointmentService.cancel(id)) {
      return "redirect:/patient/appointments";
    }
    return "redirect:/patient/appointments/" + id + "?cancelError";
  }

  @GetMapping("/patient/appointments/{id}/reschedule")
  public String rescheduleForm(@PathVariable Long id, Authentication auth, Model model) {
    var appointment = appointmentService.findById(id);
    if (appointment.getPatient() == null || !auth.getName().equals(appointment.getPatient().getUsername())) {
      return "redirect:/patient/appointments";
    }
    model.addAttribute("appointment", appointment);
    loadRescheduleOptions(appointment, model);
    return "patient-reschedule";
  }

  @PostMapping("/patient/appointments/{id}/reschedule")
  public String reschedule(
      @PathVariable Long id,
      Authentication auth,
      @RequestParam Long scheduleId,
      Model model) {
    var appointment = appointmentService.findById(id);
    if (appointment.getPatient() == null
        || !auth.getName().equals(appointment.getPatient().getUsername())) {
      return "redirect:/patient/appointments";
    }

    var selectedSchedule = dentistScheduleRepository.findById(scheduleId).orElse(null);
    boolean isCurrentSchedule =
        appointment.getDentistSchedule() != null
            && appointment.getDentistSchedule().getId().equals(scheduleId);
    if (selectedSchedule == null
        || (!isCurrentSchedule
            && (!"AVAILABLE".equals(selectedSchedule.getStatus())
                || selectedSchedule.getAppointment() != null))) {
      model.addAttribute("appointment", appointment);
      model.addAttribute("errorMessage", "ช่วงเวลานี้ไม่ว่างแล้ว กรุณาเลือกตารางใหม่");
      loadRescheduleOptions(appointment, model);
      return "patient-reschedule";
    }

    appointment.setDentistSchedule(selectedSchedule);
    appointment.setDentist(selectedSchedule.getDentist());
    appointment.setAppointmentDate(selectedSchedule.getScheduleDate());
    appointment.setAppointmentTime(selectedSchedule.getStartTime());
    appointment.setAppointmentEndTime(selectedSchedule.getEndTime());
    appointment.setStatus("PENDING");
    appointmentService.save(appointment);
    return "redirect:/patient/appointments/" + id;
  }

  private void loadRescheduleOptions(
      com.clinic.dentalclinicbooking.entity.Appointment appointment, Model model) {
    var availableSchedules =
        new ArrayList<>(
            dentistScheduleRepository.findByStatusAndAppointmentIsNullOrderByScheduleDateAscStartTimeAsc(
                "AVAILABLE"));
    if (appointment.getDentistSchedule() != null
        && availableSchedules.stream()
            .noneMatch(schedule -> schedule.getId().equals(appointment.getDentistSchedule().getId()))) {
      availableSchedules.add(0, appointment.getDentistSchedule());
    }
    model.addAttribute("schedules", availableSchedules);
  }
}
