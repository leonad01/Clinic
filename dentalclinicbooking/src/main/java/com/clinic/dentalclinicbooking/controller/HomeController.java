package com.clinic.dentalclinicbooking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {

  @GetMapping("/")
  public String home(Authentication authentication, Model model) {
    boolean loggedIn =
        authentication != null
            && authentication.isAuthenticated()
            && !"anonymousUser".equals(authentication.getName());
    model.addAttribute("loggedIn", loggedIn);
    if (loggedIn) {
      String role = authentication.getAuthorities().iterator().next().getAuthority();
      model.addAttribute("username", authentication.getName());
      model.addAttribute("isPatient", "ROLE_PATIENT".equals(role));
      model.addAttribute(
          "accountPath",
          switch (role) {
            case "ROLE_NURSE" -> "/nurse/appointments";
            case "ROLE_DENTIST" -> "/dentist/schedules";
            case "ROLE_ADMIN" -> "/admin/rooms";
            default -> "/booking";
          });
      model.addAttribute(
          "accountLabel",
          switch (role) {
            case "ROLE_NURSE" -> "หน้าจัดการนัดหมาย";
            case "ROLE_DENTIST" -> "ตารางงานของฉัน";
            case "ROLE_ADMIN" -> "จัดการระบบ";
            default -> "จองคิว";
          });
    }
    return "home";
  }

  @GetMapping({"/login", "/patient/login"})
  public String patientLogin(
      @RequestParam(defaultValue = "false") boolean switchAccount,
      Authentication authentication,
      HttpServletRequest request,
      HttpServletResponse response,
      Model model) {
    if (switchAccount) {
      clearLogin(request, response);
    }
    return showLogin("ROLE_PATIENT", "ผู้ป่วย", model);
  }

  @GetMapping("/nurse/login")
  public String nurseLogin(Model model) {
    return showLogin("ROLE_NURSE", "พยาบาล", model);
  }

  @GetMapping("/dentist/login")
  public String dentistLogin(Model model) {
    return showLogin("ROLE_DENTIST", "ทันตแพทย์", model);
  }

  @GetMapping("/admin/login")
  public String adminLogin(Model model) {
    return showLogin("ROLE_ADMIN", "ผู้ดูแลระบบ", model);
  }

  @GetMapping("/register")
  public String register() {
    return "redirect:/register/patient";
  }

  @GetMapping("/nurse")
  public String nurse() {
    return "redirect:/nurse/appointments";
  }

  @GetMapping("/access-denied")
  public String accessDenied() {
    return "access-denied";
  }

  private String showLogin(String role, String label, Model model) {
    model.addAttribute("loginRole", role);
    model.addAttribute("loginRoleLabel", label);
    return "login";
  }

  private void clearLogin(HttpServletRequest request, HttpServletResponse response) {
    if (request.getSession(false) != null) {
      request.getSession(false).invalidate();
    }
    for (String name : new String[] {"JSESSIONID", "smilecare-remember-me"}) {
      Cookie cookie = new Cookie(name, "");
      cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
      cookie.setMaxAge(0);
      response.addCookie(cookie);
    }
  }
}
