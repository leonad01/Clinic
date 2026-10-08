package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.repository.DentistRepository;
import com.clinic.dentalclinicbooking.repository.TreatmentHistoryRepository;
import com.clinic.dentalclinicbooking.service.AppointmentService;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
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
  private final DentistRepository dentists;
  private final AppointmentService appointments;
  private final TreatmentHistoryRepository treatmentHistories;

  public DentistController(
      DentistScheduleRepository schedules,
      DentistRepository dentists,
      AppointmentService appointments,
      TreatmentHistoryRepository treatmentHistories) {
    this.schedules = schedules;
    this.dentists = dentists;
    this.appointments = appointments;
    this.treatmentHistories = treatmentHistories;
  }
  @GetMapping("/dentist/schedules")
  public String schedules(
      @RequestParam(required = false) String startDate, Authentication authentication, Model model) {
    dentists
        .findByUsername(authentication.getName())
        .ifPresent(dentist -> model.addAttribute("loggedInDentist", dentist));
    var dentistSchedules =
        schedules.findByDentistUsernameOrderByScheduleDateAscStartTimeAsc(authentication.getName());
    List<String> availableDates =
        dentistSchedules.stream().map(schedule -> schedule.getScheduleDate()).distinct().toList();
    int startIndex = findStartIndex(availableDates, startDate);
    int endIndex = Math.min(startIndex + 7, availableDates.size());
    List<String> displayedDates = availableDates.subList(startIndex, endIndex);
    Map<String, Map<String, com.clinic.dentalclinicbooking.entity.DentistSchedule>> schedulesByDate =
        new LinkedHashMap<>();
    List<String> timeSlots = new ArrayList<>();
    dentistSchedules.stream()
        .filter(schedule -> displayedDates.contains(schedule.getScheduleDate()))
        .forEach(
            schedule -> {
              String timeSlot = schedule.getStartTime() + " - " + schedule.getEndTime();
              schedulesByDate
                  .computeIfAbsent(schedule.getScheduleDate(), ignored -> new LinkedHashMap<>())
                  .put(timeSlot, schedule);
              if (!timeSlots.contains(timeSlot)) {
                timeSlots.add(timeSlot);
              }
            });
    model.addAttribute("schedulesByDate", schedulesByDate);
    model.addAttribute("timeSlots", timeSlots);
    model.addAttribute("totalDays", availableDates.size());
    model.addAttribute("selectedStartDate", displayedDates.isEmpty() ? "" : displayedDates.get(0));
    model.addAttribute("previousStartDate", startIndex == 0 ? null : availableDates.get(Math.max(0, startIndex - 7)));
    model.addAttribute("nextStartDate", endIndex >= availableDates.size() ? null : availableDates.get(endIndex));
    return "dentist-schedules";
  }

  private int findStartIndex(List<String> availableDates, String startDate) {
    if (availableDates.isEmpty() || startDate == null || startDate.isBlank()) {
      return 0;
    }
    try {
      LocalDate requestedDate = LocalDate.parse(startDate);
      for (int index = 0; index < availableDates.size(); index++) {
        if (!LocalDate.parse(availableDates.get(index)).isBefore(requestedDate)) {
          return index;
        }
      }
    } catch (DateTimeParseException ignored) {
      // Fall back to the first available schedule date.
    }
    return 0;
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

  @PostMapping("/dentist/schedules/{id}/start")
  public String startTreatment(@PathVariable Long id, Authentication authentication) {
    var schedule = schedules.findById(id).orElse(null);
    if (schedule == null
        || schedule.getDentist() == null
        || !authentication.getName().equals(schedule.getDentist().getUsername())
        || schedule.getAppointment() == null
        || !appointments.start(schedule.getAppointment().getId())) {
      return "redirect:/dentist/schedules/" + id + "?error=start";
    }
    return "redirect:/dentist/schedules/" + id + "?started";
  }
}
