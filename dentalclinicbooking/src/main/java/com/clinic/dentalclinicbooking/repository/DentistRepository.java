package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.Dentist;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DentistRepository extends JpaRepository<Dentist, Long> {
  Optional<Dentist> findByUsername(String username);

  boolean existsByUsername(String username);
}
