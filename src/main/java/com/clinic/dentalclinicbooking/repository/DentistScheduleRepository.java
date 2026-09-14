package com.clinic.dentalclinicbooking.repository;

import com.clinic.dentalclinicbooking.entity.DentistSchedule;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DentistScheduleRepository extends JpaRepository<DentistSchedule, Long> {
  List<DentistSchedule> findByDentistUsernameOrderByScheduleDateAscStartTimeAsc(String username);

  List<DentistSchedule> findByDentistUsernameAndScheduleDateOrderByStartTimeAsc(
      String username, String scheduleDate);

  List<DentistSchedule> findByDentistIdOrderByScheduleDateAscStartTimeAsc(Long dentistId);

  List<DentistSchedule> findByStatusAndAppointmentIsNullOrderByScheduleDateAscStartTimeAsc(
      String status);

  List<DentistSchedule> findByScheduleDate(String scheduleDate);
}
