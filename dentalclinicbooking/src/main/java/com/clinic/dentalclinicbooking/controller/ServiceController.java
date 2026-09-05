package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.repository.DentalServiceRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ServiceController {
  private final DentalServiceRepository services;
  public ServiceController(DentalServiceRepository services) { this.services = services; }
  @GetMapping("/services")
  public String list(@RequestParam(required = false) String q, Model model) {
    model.addAttribute("services", q == null || q.isBlank() ? services.findAll() : services.findByNameContainingIgnoreCase(q));
    model.addAttribute("q", q);
    return "services";
  }
}
