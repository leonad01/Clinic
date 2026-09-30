package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.repository.DentalServiceRepository;
import com.clinic.dentalclinicbooking.repository.PatientRepository;
import com.clinic.dentalclinicbooking.service.AppointmentService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BookingController {

  private final AppointmentService appointmentService;
  private final PatientRepository patientRepository;
  private final DentistScheduleRepository dentistScheduleRepository;
  private final DentalServiceRepository dentalServiceRepository;

  public BookingController(
      AppointmentService appointmentService,
      PatientRepository patientRepository,
      DentistScheduleRepository dentistScheduleRepository,
      DentalServiceRepository dentalServiceRepository) {
    this.appointmentService = appointmentService;
    this.patientRepository = patientRepository;
    this.dentistScheduleRepository = dentistScheduleRepository;
    this.dentalServiceRepository = dentalServiceRepository;
  }

  @GetMapping("/booking")
  public String bookingForm(Model model) {
    loadAvailableSchedules(model);
    return "booking";
  }

  @PostMapping("/booking")
  public String submitBooking(
      @ModelAttribute Appointment appointment,
      @RequestParam Long scheduleId,
      @RequestParam(required = false) Long serviceId,
      Authentication authentication,
      Model model) {
    var schedule = dentistScheduleRepository.findById(scheduleId).orElse(null);
    if (schedule == null || !"AVAILABLE".equals(schedule.getStatus()) || schedule.getAppointment() != null) {
      model.addAttribute("errorMessage", "ช่วงเวลานี้ไม่ว่างแล้ว กรุณาเลือกตารางใหม่");
      loadAvailableSchedules(model);
      return "booking";
    }

    var patient = patientRepository.findByUsername(authentication.getName()).orElseThrow();
    appointment.setPatient(patient);
    appointment.setPatientName(patient.getFirstName() + " " + patient.getLastName());
    appointment.setPhone(patient.getPhone());
    appointment.setEmail(patient.getEmail());
    if (serviceId != null) {
      var dentalService = dentalServiceRepository.findById(serviceId).orElse(null);
      if (dentalService == null) {
        model.addAttribute("errorMessage", "ไม่พบข้อมูลบริการ กรุณาเลือกใหม่");
        loadAvailableSchedules(model);
        return "booking";
      }
      appointment.setDentalService(dentalService);
      appointment.setService(dentalService.getName());
    }
    appointment.setStatus("PENDING");
    Appointment saved = appointmentService.reserveAvailableSchedule(appointment, scheduleId);
    if (saved == null) {
      model.addAttribute("errorMessage", "ช่วงเวลานี้ถูกจองไปแล้ว กรุณาเลือกเวลาใหม่");
      loadAvailableSchedules(model);
      return "booking";
    }
    return "redirect:/patient/appointments/" + saved.getId();
  }

  private void loadAvailableSchedules(Model model) {
    model.addAttribute(
        "schedules",
        dentistScheduleRepository.findByStatusAndAppointmentIsNullOrderByScheduleDateAscStartTimeAsc(
            "AVAILABLE"));
    model.addAttribute("services", dentalServiceRepository.findAll());
  }
}
