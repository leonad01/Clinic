package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.DentistSchedule;
import jakarta.persistence.LockModeType;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface DentistScheduleRepository extends JpaRepository<DentistSchedule, Long> {
  @Lock(LockModeType.PESSIMISTIC_WRITE)
  @Query("select schedule from DentistSchedule schedule where schedule.id = :id")
  Optional<DentistSchedule> findByIdForUpdate(@Param("id") Long id);

  List<DentistSchedule> findByDentistUsernameOrderByScheduleDateAscStartTimeAsc(String username);

  List<DentistSchedule> findByDentistUsernameAndScheduleDateOrderByStartTimeAsc(
      String username, String scheduleDate);

  List<DentistSchedule> findByDentistIdOrderByScheduleDateAscStartTimeAsc(Long dentistId);

  List<DentistSchedule> findByStatusAndAppointmentIsNullOrderByScheduleDateAscStartTimeAsc(
      String status);

  List<DentistSchedule> findByScheduleDate(String scheduleDate);
}
