package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.Patient;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
  Optional<Patient> findByUsername(String username);

  boolean existsByUsername(String username);

  boolean existsByIdCard(String idCard);
}
