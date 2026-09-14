package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.Admin;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminRepository extends JpaRepository<Admin, Long> {
  Optional<Admin> findByUsername(String username);
}
