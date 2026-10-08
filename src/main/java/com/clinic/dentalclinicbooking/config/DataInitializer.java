package com.clinic.dentalclinicbooking.config;

import com.clinic.dentalclinicbooking.entity.Admin;
import com.clinic.dentalclinicbooking.entity.DentalService;
import com.clinic.dentalclinicbooking.entity.Dentist;
import com.clinic.dentalclinicbooking.entity.DentistSchedule;
import com.clinic.dentalclinicbooking.entity.Nurse;
import com.clinic.dentalclinicbooking.entity.Room;
import com.clinic.dentalclinicbooking.repository.AdminRepository;
import com.clinic.dentalclinicbooking.repository.AppointmentRepository;
import com.clinic.dentalclinicbooking.repository.DentalServiceRepository;
import com.clinic.dentalclinicbooking.repository.DentistRepository;
import com.clinic.dentalclinicbooking.repository.DentistScheduleRepository;
import com.clinic.dentalclinicbooking.repository.NurseRepository;
import com.clinic.dentalclinicbooking.repository.RoomRepository;
import com.clinic.dentalclinicbooking.repository.TreatmentHistoryRepository;
import java.time.LocalDate;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@ConditionalOnProperty(name = "app.seed-demo-data", havingValue = "true")
public class DataInitializer {

  @Bean
  CommandLineRunner initAdmin(
      AdminRepository admins,
      AppointmentRepository appointmentRecords,
      DentalServiceRepository services,
      NurseRepository nurses,
      DentistRepository dentists,
      RoomRepository rooms,
      DentistScheduleRepository schedules,
      TreatmentHistoryRepository treatmentHistories,
      @Value("${app.reset-schedule-data:false}") boolean resetScheduleData,
      PasswordEncoder passwordEncoder) {
    return args -> {
      if (resetScheduleData) {
        treatmentHistories.deleteAllInBatch();
        appointmentRecords.deleteAllInBatch();
        schedules.deleteAllInBatch();
      }
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
      Nurse nurse = nurses.findByUsername("nurse").orElseGet(() -> {
        Nurse createdNurse = new Nurse();
        createdNurse.setUsername("nurse");
        createdNurse.setPassword(passwordEncoder.encode("Nurse@123"));
        createdNurse.setEmail("nurse@smilecare.local");
        return createdNurse;
      });
      nurse.setFirstName("สิริกานต์");
      nurse.setLastName("มณีวงศ์");
      nurses.save(nurse);

      Dentist dentist = dentists.findByUsername("dentist").orElseGet(() -> {
        Dentist createdDentist = new Dentist();
        createdDentist.setUsername("dentist");
        createdDentist.setPassword(passwordEncoder.encode("Dentist@123"));
        createdDentist.setEmail("dentist@smilecare.local");
        return createdDentist;
      });
      dentist.setFirstName("ทพ.กิตติพงษ์");
      dentist.setLastName("วัฒนานนท์");
      dentists.save(dentist);

      Dentist secondDentist = dentists.findByUsername("dentist2").orElseGet(() -> {
        Dentist createdDentist = new Dentist();
        createdDentist.setUsername("dentist2");
        createdDentist.setPassword(passwordEncoder.encode("Dentist2@123"));
        createdDentist.setEmail("dentist2@smilecare.local");
        return createdDentist;
      });
      secondDentist.setFirstName("ทพ.ธนกร");
      secondDentist.setLastName("ภูมิรักษา");
      dentists.save(secondDentist);

      List<Room> scheduleRooms = ensureScheduleRooms(rooms, 2);
      createAutomaticSchedules(schedules, List.of(dentist, secondDentist), scheduleRooms);
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

  private List<Room> ensureScheduleRooms(RoomRepository rooms, int requiredRooms) {
    List<Room> scheduleRooms = new ArrayList<>(rooms.findAll());
    while (scheduleRooms.size() < requiredRooms) {
      Room room = new Room();
      room.setName("ห้องตรวจ " + (scheduleRooms.size() + 1));
      room.setStatus("AVAILABLE");
      scheduleRooms.add(rooms.save(room));
    }
    return scheduleRooms;
  }

  private void createAutomaticSchedules(
      DentistScheduleRepository schedules, List<Dentist> dentists, List<Room> rooms) {
    LocalDate firstScheduleDate = LocalDate.now().plusDays(1);
    LocalDate lastScheduleDate = firstScheduleDate.plusDays(29);

    for (int dentistIndex = 0; dentistIndex < dentists.size(); dentistIndex++) {
      Dentist dentist = dentists.get(dentistIndex);
      Room room = rooms.get(dentistIndex % rooms.size());
      Set<String> existingSlots = new HashSet<>();
      schedules.findByDentistIdOrderByScheduleDateAscStartTimeAsc(dentist.getId()).forEach(
          schedule -> existingSlots.add(schedule.getScheduleDate() + "|" + schedule.getStartTime()));

      for (LocalDate date = firstScheduleDate; !date.isAfter(lastScheduleDate); date = date.plusDays(1)) {
        int closingHour = date.getDayOfWeek() == DayOfWeek.SUNDAY ? 16 : 18;
        for (int hour = 9; hour < closingHour; hour++) {
          String startTime = String.format("%02d:00", hour);
          String slotKey = date + "|" + startTime;
          if (!existingSlots.contains(slotKey)) {
            addSchedule(schedules, dentist, room, date.toString(), startTime, String.format("%02d:00", hour + 1));
          }
        }
      }
    }
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
