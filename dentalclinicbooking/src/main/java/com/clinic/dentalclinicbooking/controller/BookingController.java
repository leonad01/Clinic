package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.service.AppointmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class BookingController {

    private final AppointmentService appointmentService;

    public BookingController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    @GetMapping("/booking")
    public String bookingForm() {
        return "booking";
    }

    @PostMapping("/booking")
    public String submitBooking(@ModelAttribute Appointment appointment) {
        Appointment saved = appointmentService.save(appointment);
        return "redirect:/appointments/" + saved.getId();
    }
}
