package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.repository.DentalServiceRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

  @GetMapping("/services/search")
  public String search(@RequestParam(required = false) String q) {
    if (q == null || q.isBlank()) {
      return "redirect:/services";
    }
    return services
        .findFirstByNameContainingIgnoreCase(q.trim())
        .map(service -> "redirect:/services/" + service.getId())
        .orElse("redirect:/services?q=" + q.trim());
  }

  @GetMapping("/services/{id}")
  public String detail(@PathVariable Long id, Model model) {
    var service = services.findById(id).orElse(null);
    if (service == null) {
      return "redirect:/services";
    }
    model.addAttribute("service", service);
    return "service-detail";
  }
}
