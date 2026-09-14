package com.clinic.dentalclinicbooking.config;

import com.clinic.dentalclinicbooking.entity.Admin;
import com.clinic.dentalclinicbooking.entity.DentalService;
import com.clinic.dentalclinicbooking.entity.Dentist;
import com.clinic.dentalclinicbooking.entity.DentistSchedule;
import com.clinic.dentalclinicbooking.entity.Nurse;
import com.clinic.dentalclinicbooking.entity.Room;
import com.clinic.dentalclinicbooking.repository.AdminRepository;
import com.clinic.dentalclinicbooking.repository.DentalServiceRepository;
import com.clinic.dentalclinicbooking.repository.DentistRepository;
import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.repository.NurseRepository;
import com.clinic.dentalclinicbooking.repository.RoomRepository;
import java.time.LocalDate;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@ConditionalOnProperty(name = "app.seed-demo-data", havingValue = "true")
public class DataInitializer {

  @Bean
  CommandLineRunner initAdmin(
      AdminRepository admins,
      DentalServiceRepository services,
      NurseRepository nurses,
      DentistRepository dentists,
      RoomRepository rooms,
      DentistScheduleRepository schedules,
      PasswordEncoder passwordEncoder) {
    return args -> {
      if (admins.findByUsername("admin").isEmpty()) {
        Admin admin = new Admin();
        admin.setUsername("admin");
        admin.setPassword(passwordEncoder.encode("Admin@123"));
        admins.save(admin);
      }
      if (services.count() == 0) {
        addService(services, "ตรวจสุขภาพฟัน", "500", "30 นาที", "ตรวจรักษาทั่วไป");
        addService(services, "อุดฟัน", "800", "45 นาที", "รักษาฟัน");
        addService(services, "ขูดหินปูน", "900", "45 นาที", "ทันตกรรมป้องกัน");
        addService(services, "รากฟันเทียม", "25000", "90 นาที", "ทันตกรรมเฉพาะทาง");
      }
      if (nurses.findByUsername("nurse").isEmpty()) {
        Nurse nurse = new Nurse();
        nurse.setUsername("nurse");
        nurse.setPassword(passwordEncoder.encode("Nurse@123"));
        nurse.setFirstName("พยาบาล");
        nurse.setLastName("ทดสอบ");
        nurse.setEmail("nurse@smilecare.local");
        nurses.save(nurse);
      }
      if (dentists.findByUsername("dentist").isEmpty()) {
        Dentist dentist = new Dentist();
        dentist.setUsername("dentist");
        dentist.setPassword(passwordEncoder.encode("Dentist@123"));
        dentist.setFirstName("ทันตแพทย์");
        dentist.setLastName("ทดสอบ");
        dentist.setEmail("dentist@smilecare.local");
        dentists.save(dentist);
      }

      Room room = rooms.findAll().stream().findFirst().orElseGet(() -> createDefaultRoom(rooms));
      Dentist dentist = dentists.findByUsername("dentist").orElseThrow();
      if (schedules.count() == 0) {
        String date = LocalDate.now().plusDays(1).toString();
        addSchedule(schedules, dentist, room, date, "09:00", "10:00");
        addSchedule(schedules, dentist, room, date, "10:30", "11:30");
        addSchedule(schedules, dentist, room, date, "13:00", "14:00");
        addSchedule(schedules, dentist, room, date, "15:30", "16:30");
      }
    };
  }

  private void addService(DentalServiceRepository services, String name, String price, String duration, String category) {
    DentalService service = new DentalService();
    service.setName(name);
    service.setPrice(price);
    service.setDuration(duration);
    service.setCategory(category);
    services.save(service);
  }

  private Room createDefaultRoom(RoomRepository rooms) {
    Room room = new Room();
    room.setName("ห้องตรวจ 1");
    room.setStatus("AVAILABLE");
    return rooms.save(room);
  }

  private void addSchedule(
      DentistScheduleRepository schedules,
      Dentist dentist,
      Room room,
      String date,
      String startTime,
      String endTime) {
    DentistSchedule schedule = new DentistSchedule();
    schedule.setDentist(dentist);
    schedule.setRoom(room);
    schedule.setScheduleDate(date);
    schedule.setStartTime(startTime);
    schedule.setEndTime(endTime);
    schedule.setStatus("AVAILABLE");
    schedules.save(schedule);
  }
}
