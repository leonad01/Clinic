package com.clinic.dentalclinicbooking.config;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.repository.AppointmentRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initData(AppointmentRepository appointmentRepository) {
        return args -> {
            if (appointmentRepository.count() == 0) {
                Appointment sample1 = new Appointment();
                sample1.setPatientName("นางสมใจ มีสุข");
                sample1.setPhone("0812345678");
                sample1.setEmail("somjai@example.com");
                sample1.setAppointmentDate("2026-07-20");
                sample1.setAppointmentTime("09:00");
                sample1.setService("ตรวจฟันทั่วไป");
                sample1.setNotes("ต้องการตรวจสุขภาพช่องปาก");
                sample1.setStatus("รออนุมัติ");

                Appointment sample2 = new Appointment();
                sample2.setPatientName("นายพงศ์พัฒน์ แก้วใส");
                sample2.setPhone("0898765432");
                sample2.setEmail("pong@example.com");
                sample2.setAppointmentDate("2026-07-20");
                sample2.setAppointmentTime("10:30");
                sample2.setService("อุดฟัน");
                sample2.setNotes("มีฟันผุและต้องการอุดทันที");
                sample2.setStatus("อนุมัติแล้ว");

                appointmentRepository.save(sample1);
                appointmentRepository.save(sample2);
            }
        };
    }
}
