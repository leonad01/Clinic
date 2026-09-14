package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.DentalService;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DentalServiceRepository extends JpaRepository<DentalService, Long> {
  List<DentalService> findByNameContainingIgnoreCase(String name);

  Optional<DentalService> findFirstByNameContainingIgnoreCase(String name);
}
