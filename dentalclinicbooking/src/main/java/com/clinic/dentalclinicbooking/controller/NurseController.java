package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.service.AppointmentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/nurse")
public class NurseController {

    private final AppointmentService appointmentService;

    public NurseController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    @GetMapping("/appointments")
    public String appointments(Model model) {
        model.addAttribute("appointments", appointmentService.findAll());
        return "nurse-appointments";
    }

    @PostMapping("/appointments/{id}/approve")
    public String approve(@PathVariable Long id) {
        appointmentService.approve(id);
        return "redirect:/nurse/appointments";
    }

    @PostMapping("/appointments/{id}/reject")
    public String reject(@PathVariable Long id) {
        appointmentService.reject(id);
        return "redirect:/nurse/appointments";
    }
}
