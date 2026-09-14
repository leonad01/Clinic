package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.entity.DentistSchedule;
import com.clinic.dentalclinicbooking.repository.*;
import com.clinic.dentalclinicbooking.service.AppointmentService;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Objects;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/nurse")
public class NurseController {
  private final AppointmentService appointments;
  private final PatientRepository patients;
  private final DentistRepository dentists;
  private final RoomRepository rooms;
  private final NurseRepository nurses;
  private final DentistScheduleRepository schedules;
  private final TreatmentHistoryRepository treatmentHistories;
  private final DentalServiceRepository services;

  public NurseController(
      AppointmentService appointments,
      PatientRepository patients,
      DentistRepository dentists,
      RoomRepository rooms,
      NurseRepository nurses,
      DentistScheduleRepository schedules,
      TreatmentHistoryRepository treatmentHistories,
      DentalServiceRepository services) {
    this.appointments = appointments;
    this.patients = patients;
    this.dentists = dentists;
    this.rooms = rooms;
    this.nurses = nurses;
    this.schedules = schedules;
    this.treatmentHistories = treatmentHistories;
    this.services = services;
  }

  @GetMapping("/appointments")
  public String listAppointments(Model model) {
    model.addAttribute("appointments", appointments.findAll());
    return "nurse-appointments-list";
  }

  @GetMapping("/appointments/{id}")
  public String viewAppointment(@PathVariable Long id, Model model) {
    var appointment = appointments.findById(id);
    model.addAttribute("appointment", appointment);
    String patientPhone = appointment.getPhone();
    if ((patientPhone == null || patientPhone.isBlank()) && appointment.getPatient() != null) {
      patientPhone = appointment.getPatient().getPhone();
    }
    model.addAttribute("patientPhone", patientPhone);
    return "nurse-appointment-detail-v2";
  }

  @GetMapping("/appointments/new")
  public String newAppointment(Model model) {
    model.addAttribute("appointment", new Appointment());
    loadAppointmentOptions(model);
    return "nurse-appointment-form";
  }

  @PostMapping("/appointments")
  public String saveAppointment(
      @ModelAttribute Appointment appointment,
      @RequestParam(required = false) Long patientId,
      @RequestParam(required = false) Long serviceId,
      @RequestParam(required = false) Long scheduleId,
      Model model) {
    var patient = patientId == null ? null : patients.findById(patientId).orElse(null);
    var service = serviceId == null ? null : services.findById(serviceId).orElse(null);
    var schedule = scheduleId == null ? null : schedules.findById(scheduleId).orElse(null);
    if (patient == null || service == null || schedule == null || !"AVAILABLE".equals(schedule.getStatus()) || schedule.getAppointment() != null) {
      String message =
          patient == null
              ? "กรุณาเลือกผู้ป่วยจากรายชื่อ"
              : service == null
                  ? "กรุณาเลือกบริการ"
                  : "ช่วงเวลานี้ไม่ว่างแล้ว กรุณาเลือกตารางใหม่";
      return showAppointmentForm(appointment, message, model);
    }
    appointment.setPatient(patient);
    appointment.setPatientName(patient.getFirstName() + " " + patient.getLastName());
    appointment.setPhone(patient.getPhone());
    appointment.setEmail(patient.getEmail());
    appointment.setDentalService(service);
    appointment.setService(service.getName());
    appointment.setDentistSchedule(schedule);
    appointment.setDentist(schedule.getDentist());
    appointment.setAppointmentDate(schedule.getScheduleDate());
    appointment.setAppointmentTime(schedule.getStartTime());
    appointment.setAppointmentEndTime(schedule.getEndTime());
    appointment.setStatus("PENDING");
    appointments.save(appointment);
    return "redirect:/nurse/appointments";
  }

  @PostMapping("/appointments/{id}/approve")
  public String approve(@PathVariable Long id) {
    appointments.approve(id);
    return "redirect:/nurse/appointments";
  }

  @GetMapping("/appointments/{id}/reschedule")
  public String rescheduleForm(@PathVariable Long id, Model model) {
    var appointment = appointments.findById(id);
    if (!canReschedule(appointment)) {
      return "redirect:/nurse/appointments/" + id;
    }
    model.addAttribute("appointment", appointment);
    loadRescheduleOptions(appointment, model);
    return "nurse-appointment-reschedule";
  }

  @PostMapping("/appointments/{id}/reschedule")
  public String reschedule(@PathVariable Long id, @RequestParam Long scheduleId, Model model) {
    var appointment = appointments.findById(id);
    if (!canReschedule(appointment)) {
      return "redirect:/nurse/appointments/" + id;
    }

    var selectedSchedule = schedules.findById(scheduleId).orElse(null);
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
      return "nurse-appointment-reschedule";
    }

    appointment.setDentistSchedule(selectedSchedule);
    appointment.setDentist(selectedSchedule.getDentist());
    appointment.setAppointmentDate(selectedSchedule.getScheduleDate());
    appointment.setAppointmentTime(selectedSchedule.getStartTime());
    appointment.setAppointmentEndTime(selectedSchedule.getEndTime());
    appointment.setStatus("PENDING");
    appointments.save(appointment);
    return "redirect:/nurse/appointments/" + id;
  }

  @GetMapping("/schedules")
  public String listSchedules(Model model) {
    model.addAttribute("dentists", dentists.findAll());
    return "nurse-schedules";
  }

  @GetMapping("/schedules/dentist/{id}")
  public String dentistSchedules(@PathVariable Long id, Model model) {
    var dentist = dentists.findById(id).orElse(null);
    if (dentist == null) {
      return "redirect:/nurse/schedules";
    }
    model.addAttribute("dentist", dentist);
    model.addAttribute("schedules", schedules.findByDentistIdOrderByScheduleDateAscStartTimeAsc(id));
    return "nurse-dentist-schedules";
  }

  @GetMapping("/schedules/new")
  public String newSchedule(Model model) {
    model.addAttribute("schedule", new DentistSchedule());
    loadScheduleOptions(model);
    return "nurse-schedule-form";
  }

  @GetMapping("/schedules/{id}")
  public String editSchedule(@PathVariable Long id, Model model) {
    model.addAttribute("schedule", schedules.findById(id).orElseThrow());
    loadScheduleOptions(model);
    return "nurse-schedule-form";
  }

  @PostMapping("/schedules")
  public String saveSchedule(@ModelAttribute DentistSchedule schedule, Model model) {
    if (schedule.getDentist() == null
        || schedule.getDentist().getId() == null
        || schedule.getRoom() == null
        || schedule.getRoom().getId() == null) {
      return showScheduleForm(schedule, "กรุณาเลือกทันตแพทย์และห้องตรวจ", model);
    }

    var dentist = dentists.findById(schedule.getDentist().getId()).orElse(null);
    var room = rooms.findById(schedule.getRoom().getId()).orElse(null);
    if (dentist == null || room == null) {
      return showScheduleForm(schedule, "ไม่พบข้อมูลทันตแพทย์หรือห้องตรวจ", model);
    }
    schedule.setDentist(dentist);
    schedule.setRoom(room);

    if (!hasValidTimeRange(schedule)) {
      return showScheduleForm(schedule, "เวลาเริ่มต้นต้องอยู่ก่อนเวลาสิ้นสุด", model);
    }
    if (hasScheduleConflict(schedule)) {
      return showScheduleForm(
          schedule,
          "ช่วงเวลานี้ซ้อนกับตารางของทันตแพทย์หรือห้องตรวจที่เลือกแล้ว",
          model);
    }
    schedules.save(schedule);
    return "redirect:/nurse/schedules";
  }

  @GetMapping("/patients")
  public String listPatients(Model model) {
    model.addAttribute("patients", patients.findAll());
    return "nurse-patients-list";
  }

  @GetMapping("/patients/{id}")
  public String patientDetail(@PathVariable Long id, Model model) {
    var patient = patients.findById(id).orElse(null);
    if (patient == null) {
      return "redirect:/nurse/patients";
    }
    model.addAttribute("patient", patient);
    return "nurse-patient-detail";
  }

  @GetMapping("/patients/{id}/treatment-history")
  public String treatmentHistory(@PathVariable Long id, Model model) {
    var patient = patients.findById(id).orElse(null);
    if (patient == null) {
      return "redirect:/nurse/patients";
    }
    model.addAttribute("patient", patient);
    model.addAttribute("histories", treatmentHistories.findByPatientIdOrderByTreatmentDateDesc(id));
    return "nurse-treatment-history";
  }

  @GetMapping("/dentists")
  public String listDentists(Model model) {
    model.addAttribute("dentists", dentists.findAll());
    return "nurse-dentists";
  }

  private void loadAppointmentOptions(Model model) {
    model.addAttribute("patients", patients.findAll());
    model.addAttribute("services", services.findAll());
    model.addAttribute(
        "schedules",
        schedules.findByStatusAndAppointmentIsNullOrderByScheduleDateAscStartTimeAsc("AVAILABLE"));
  }

  private String showAppointmentForm(Appointment appointment, String errorMessage, Model model) {
    model.addAttribute("appointment", appointment);
    model.addAttribute("errorMessage", errorMessage);
    loadAppointmentOptions(model);
    return "nurse-appointment-form";
  }

  private boolean canReschedule(Appointment appointment) {
    return "PENDING".equals(appointment.getStatus()) || "APPROVED".equals(appointment.getStatus());
  }

  private void loadRescheduleOptions(Appointment appointment, Model model) {
    var availableSchedules =
        new ArrayList<>(
            schedules.findByStatusAndAppointmentIsNullOrderByScheduleDateAscStartTimeAsc(
                "AVAILABLE"));
    if (appointment.getDentistSchedule() != null
        && availableSchedules.stream()
            .noneMatch(schedule -> schedule.getId().equals(appointment.getDentistSchedule().getId()))) {
      availableSchedules.add(0, appointment.getDentistSchedule());
    }
    model.addAttribute("schedules", availableSchedules);
  }

  private void loadScheduleOptions(Model model) {
    model.addAttribute("dentists", dentists.findAll());
    model.addAttribute("rooms", rooms.findAll());
    model.addAttribute("nurses", nurses.findAll());
  }

  private String showScheduleForm(DentistSchedule schedule, String errorMessage, Model model) {
    model.addAttribute("schedule", schedule);
    model.addAttribute("errorMessage", errorMessage);
    loadScheduleOptions(model);
    return "nurse-schedule-form";
  }

  private boolean hasValidTimeRange(DentistSchedule schedule) {
    try {
      return LocalTime.parse(schedule.getStartTime()).isBefore(LocalTime.parse(schedule.getEndTime()));
    } catch (DateTimeParseException | NullPointerException exception) {
      return false;
    }
  }

  private boolean hasScheduleConflict(DentistSchedule requestedSchedule) {
    LocalTime requestedStart = LocalTime.parse(requestedSchedule.getStartTime());
    LocalTime requestedEnd = LocalTime.parse(requestedSchedule.getEndTime());
    return schedules.findByScheduleDate(requestedSchedule.getScheduleDate()).stream()
        .filter(existing -> !Objects.equals(existing.getId(), requestedSchedule.getId()))
        .filter(
            existing ->
                Objects.equals(existing.getDentist().getId(), requestedSchedule.getDentist().getId())
                    || Objects.equals(existing.getRoom().getId(), requestedSchedule.getRoom().getId()))
        .anyMatch(
            existing ->
                requestedStart.isBefore(LocalTime.parse(existing.getEndTime()))
                    && LocalTime.parse(existing.getStartTime()).isBefore(requestedEnd));
  }
}
