package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.Nurse;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NurseRepository extends JpaRepository<Nurse, Long> {
  Optional<Nurse> findByUsername(String username);
}
