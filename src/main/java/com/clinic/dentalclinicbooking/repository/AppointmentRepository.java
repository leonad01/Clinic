package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.Appointment;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
  boolean existsByDentistScheduleId(Long dentistScheduleId);

  List<Appointment> findAllByOrderByAppointmentDateAscAppointmentTimeAsc();

  List<Appointment> findByStatusOrderByAppointmentDateAscAppointmentTimeAsc(String status);

  List<Appointment> findByPatientUsernameOrderByAppointmentDateDesc(String username);
}
