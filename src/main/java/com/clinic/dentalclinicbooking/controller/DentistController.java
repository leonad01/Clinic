package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.repository.TreatmentHistoryRepository;
import com.clinic.dentalclinicbooking.service.AppointmentService;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DentistController {
  private final DentistScheduleRepository schedules;
  private final AppointmentService appointments;
  private final TreatmentHistoryRepository treatmentHistories;

  public DentistController(
      DentistScheduleRepository schedules,
      AppointmentService appointments,
      TreatmentHistoryRepository treatmentHistories) {
    this.schedules = schedules;
    this.appointments = appointments;
    this.treatmentHistories = treatmentHistories;
  }
  @GetMapping("/dentist/schedules")
  public String schedules(Authentication authentication, Model model) {
    Map<String, List<com.clinic.dentalclinicbooking.entity.DentistSchedule>> schedulesByDate =
        new LinkedHashMap<>();
    schedules
        .findByDentistUsernameOrderByScheduleDateAscStartTimeAsc(authentication.getName())
        .forEach(
            schedule ->
                schedulesByDate
                    .computeIfAbsent(schedule.getScheduleDate(), ignored -> new java.util.ArrayList<>())
                    .add(schedule));
    model.addAttribute("schedulesByDate", schedulesByDate);
    return "dentist-schedules";
  }

  @GetMapping("/dentist/schedules/date/{date}")
  public String schedulesByDate(
      @PathVariable String date, Authentication authentication, Model model) {
    model.addAttribute("scheduleDate", date);
    model.addAttribute(
        "schedules",
        schedules.findByDentistUsernameAndScheduleDateOrderByStartTimeAsc(authentication.getName(), date));
    return "dentist-day-schedules";
  }

  @GetMapping("/dentist/schedules/{id}")
  public String viewSchedule(
      @PathVariable Long id, Authentication authentication, Model model) {
    var schedule = schedules.findById(id).orElse(null);
    if (schedule == null
        || schedule.getDentist() == null
        || !authentication.getName().equals(schedule.getDentist().getUsername())) {
      return "redirect:/dentist/schedules";
    }
    model.addAttribute("schedule", schedule);
    if (schedule.getAppointment() != null && schedule.getAppointment().getPatient() != null) {
      model.addAttribute(
          "treatmentHistories",
          treatmentHistories.findByPatientIdOrderByTreatmentDateDesc(
              schedule.getAppointment().getPatient().getId()));
    }
    return "dentist-schedule-detail";
  }

  @PostMapping("/dentist/schedules/{id}/complete")
  public String completeTreatment(
      @PathVariable Long id,
      @RequestParam(required = false) String treatmentNote,
      Authentication authentication) {
    var schedule = schedules.findById(id).orElse(null);
    if (schedule == null
        || schedule.getDentist() == null
        || !authentication.getName().equals(schedule.getDentist().getUsername())
        || schedule.getAppointment() == null
        || !appointments.complete(schedule.getAppointment(), treatmentNote)) {
      return "redirect:/dentist/schedules/" + id + "?error=complete";
    }
    return "redirect:/dentist/schedules/" + id + "?completed";
  }
}
