package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.TreatmentHistory;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TreatmentHistoryRepository extends JpaRepository<TreatmentHistory, Long> {
  List<TreatmentHistory> findByPatientUsernameOrderByTreatmentDateDesc(String username);

  List<TreatmentHistory> findByPatientIdOrderByTreatmentDateDesc(Long patientId);

  boolean existsByAppointmentId(Long appointmentId);
}
