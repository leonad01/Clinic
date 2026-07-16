package com.clinic.dentalclinicbooking;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.clinic.dentalclinicbooking.repository.AppointmentRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource(properties = {
        "spring.datasource.url=jdbc:h2:mem:dental-test;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE",
        "spring.datasource.driver-class-name=org.h2.Driver",
        "spring.jpa.hibernate.ddl-auto=create-drop"
})
class BookingFlowTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Test
    void bookingFormShouldPersistAppointment() throws Exception {
        long appointmentCountBefore = appointmentRepository.count();

        mockMvc.perform(post("/booking")
                        .param("patientName", "ทดสอบระบบ")
                        .param("phone", "0812345678")
                        .param("appointmentDate", "2026-07-20")
                        .param("appointmentTime", "09:00")
                        .param("service", "อุดฟัน"))
                .andExpect(status().is3xxRedirection());

        assertThat(appointmentRepository.count()).isEqualTo(appointmentCountBefore + 1);
    }
}
