package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.DentalService;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DentalServiceRepository extends JpaRepository<DentalService, Long> {
  List<DentalService> findByNameContainingIgnoreCase(String name);
}
