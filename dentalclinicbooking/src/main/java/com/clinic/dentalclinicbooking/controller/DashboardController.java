package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.service.AppointmentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    private final AppointmentService appointmentService;

    public DashboardController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        var appointments = appointmentService.findAll();
        long pending = appointments.stream().filter(a -> "รออนุมัติ".equals(a.getStatus())).count();
        long approved = appointments.stream().filter(a -> "อนุมัติแล้ว".equals(a.getStatus())).count();
        long rejected = appointments.stream().filter(a -> "ปฏิเสธแล้ว".equals(a.getStatus())).count();

        model.addAttribute("appointments", appointments);
        model.addAttribute("pendingCount", pending);
        model.addAttribute("approvedCount", approved);
        model.addAttribute("rejectedCount", rejected);
        model.addAttribute("totalCount", appointments.size());
        return "dashboard";
    }

    @GetMapping("/appointments/{id}")
    public String detail(@org.springframework.web.bind.annotation.PathVariable Long id, Model model) {
        model.addAttribute("appointment", appointmentService.findById(id));
        return "appointment-detail";
    }
}
