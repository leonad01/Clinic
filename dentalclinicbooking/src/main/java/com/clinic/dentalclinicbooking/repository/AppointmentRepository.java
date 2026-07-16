package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
}
