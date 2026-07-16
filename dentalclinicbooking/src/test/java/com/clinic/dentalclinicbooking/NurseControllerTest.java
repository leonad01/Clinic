package com.clinic.dentalclinicbooking;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.repository.AppointmentRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class NurseControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Test
    void nurseAppointmentsPageShouldBeAccessible() throws Exception {
        mockMvc.perform(get("/nurse/appointments"))
                .andExpect(status().isOk())
                .andExpect(content().string(org.hamcrest.Matchers.containsString("รายการนัดหมาย")));
    }

    @Test
    void rejectAppointmentShouldUpdateStatus() throws Exception {
        Appointment appointment = new Appointment();
        appointment.setPatientName("ทดสอบปฏิเสธ");
        appointment.setPhone("0811111111");
        appointment.setAppointmentDate("2026-07-21");
        appointment.setAppointmentTime("09:00");
        appointment.setService("ตรวจฟัน");
        Appointment saved = appointmentRepository.save(appointment);

        mockMvc.perform(post("/nurse/appointments/{id}/reject", saved.getId()))
                .andExpect(status().is3xxRedirection());

        Appointment updated = appointmentRepository.findById(saved.getId()).orElseThrow();
        assertThat(updated.getStatus()).isEqualTo("ปฏิเสธแล้ว");
    }
}
