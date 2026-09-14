package com.clinic.dentalclinicbooking.controller;

import com.clinic.dentalclinicbooking.entity.Dentist;
import com.clinic.dentalclinicbooking.entity.Nurse;
import com.clinic.dentalclinicbooking.entity.Room;
import com.clinic.dentalclinicbooking.entity.DentalService;
import com.clinic.dentalclinicbooking.repository.DentalServiceRepository;
import com.clinic.dentalclinicbooking.repository.DentistRepository;
import com.clinic.dentalclinicbooking.repository.NurseRepository;
import com.clinic.dentalclinicbooking.repository.RoomRepository;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {
  private final RoomRepository rooms; private final NurseRepository nurses; private final DentistRepository dentists; private final DentalServiceRepository services; private final PasswordEncoder passwordEncoder;
  public AdminController(RoomRepository rooms, NurseRepository nurses, DentistRepository dentists, DentalServiceRepository services, PasswordEncoder passwordEncoder) { this.rooms=rooms; this.nurses=nurses; this.dentists=dentists; this.services=services; this.passwordEncoder=passwordEncoder; }
  @GetMapping("/rooms") public String rooms(Model model) { model.addAttribute("rooms", rooms.findAll()); return "admin-rooms-list"; }
  @GetMapping("/rooms/new") public String newRoomForm(Model model) { model.addAttribute("room", new Room()); return "admin-room-form"; }
  @PostMapping("/rooms") public String addRoom(@ModelAttribute Room room) { rooms.save(room); return "redirect:/admin/rooms"; }
  @GetMapping("/staff") public String staff(Model model) { model.addAttribute("nurses", nurses.findAll()); model.addAttribute("dentists", dentists.findAll()); return "admin-staff-list"; }
  @GetMapping("/staff/nurses/new") public String newNurseForm(Model model) { model.addAttribute("nurse", new Nurse()); return "admin-nurse-form-v2"; }
  @GetMapping("/staff/dentists/new") public String newDentistForm(Model model) { model.addAttribute("dentist", new Dentist()); return "admin-dentist-form-v2"; }
  @GetMapping("/staff/nurses/{id}") public String nurseDetail(@PathVariable Long id, Model model) { var nurse = nurses.findById(id).orElse(null); if (nurse == null) return "redirect:/admin/staff"; model.addAttribute("staff", nurse); model.addAttribute("staffRole", "พยาบาล"); return "admin-staff-detail"; }
  @GetMapping("/staff/dentists/{id}") public String dentistDetail(@PathVariable Long id, Model model) { var dentist = dentists.findById(id).orElse(null); if (dentist == null) return "redirect:/admin/staff"; model.addAttribute("staff", dentist); model.addAttribute("staffRole", "ทันตแพทย์"); return "admin-staff-detail"; }
  @PostMapping("/nurses") public String addNurse(@Valid @ModelAttribute("nurse") Nurse nurse, BindingResult bindingResult) { if (bindingResult.hasErrors()) return "admin-nurse-form-v2"; nurse.setPassword(passwordEncoder.encode(nurse.getPassword())); nurses.save(nurse); return "redirect:/admin/staff"; }
  @PostMapping("/dentists") public String addDentist(@Valid @ModelAttribute("dentist") Dentist dentist, BindingResult bindingResult) { if (bindingResult.hasErrors()) return "admin-dentist-form-v2"; dentist.setPassword(passwordEncoder.encode(dentist.getPassword())); dentists.save(dentist); return "redirect:/admin/staff"; }
  @GetMapping("/services") public String services(Model model) { model.addAttribute("services", services.findAll()); return "admin-services"; }
  @PostMapping("/services") public String addService(@ModelAttribute DentalService service) { services.save(service); return "redirect:/admin/services"; }
}
