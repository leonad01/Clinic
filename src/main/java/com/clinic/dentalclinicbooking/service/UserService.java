package com.clinic.dentalclinicbooking.service;

import com.clinic.dentalclinicbooking.entity.Patient;
import com.clinic.dentalclinicbooking.repository.PatientRepository;
import java.util.HashMap;
import java.util.Map;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
  private final PatientRepository patientRepository;
  private final PasswordEncoder passwordEncoder;

  public UserService(PatientRepository patientRepository, PasswordEncoder passwordEncoder) {
    this.patientRepository = patientRepository;
    this.passwordEncoder = passwordEncoder;
  }

  public Map<String, Object> registerPatient(Patient patient) {
    Map<String, Object> result = new HashMap<>();
    if (patientRepository.existsByUsername(patient.getUsername())) {
      result.put("success", false);
      result.put("message", "username นี้ถูกใช้งานแล้ว");
      return result;
    }
    if (!isValidThaiIdCard(patient.getIdCard())) {
      result.put("success", false);
      result.put("message", "เลขบัตรประชาชนไม่ถูกต้อง");
      return result;
    }
    if (patientRepository.existsByIdCard(patient.getIdCard())) {
      result.put("success", false);
      result.put("message", "เลขบัตรประชาชนนี้ถูกใช้งานแล้ว");
      return result;
    }
    if (!patient.getPasswordHash().equals(patient.getConfirmPassword())) {
      result.put("success", false);
      result.put("message", "รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน");
      return result;
    }
    patient.setEmail(patient.getUsername() + "@patient.local");
    patient.setPasswordHash(passwordEncoder.encode(patient.getPasswordHash()));
    patientRepository.save(patient);
    result.put("success", true);
    result.put("message", "สมัครสมาชิกผู้ป่วยสำเร็จ");
    return result;
  }

  private boolean isValidThaiIdCard(String idCard) {
    // Demo mode: validate only the length and numeric format.
    return idCard != null && idCard.matches("\\d{13}");
  }
}
