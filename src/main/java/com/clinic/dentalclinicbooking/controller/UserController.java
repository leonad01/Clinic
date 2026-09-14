package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.entity.Patient;
import com.clinic.dentalclinicbooking.service.UserService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

  private final UserService userService;

  public UserController(UserService userService) {
    this.userService = userService;
  }

  @GetMapping("/register/patient")
  public String showPatientRegisterForm(Model model) {
    model.addAttribute("patient", new Patient());
    return "register-patient";
  }

  @PostMapping("/register/patient")
  public String registerPatient(
      @Valid @ModelAttribute("patient") Patient patient, BindingResult bindingResult, Model model) {
    if (bindingResult.hasErrors()) {
      return "register-patient";
    }

    var result = userService.registerPatient(patient);
    if (!Boolean.TRUE.equals(result.get("success"))) {
      model.addAttribute("errorMessage", result.get("message"));
      return "register-patient";
    }

    return "redirect:/login?registered";
  }
}
