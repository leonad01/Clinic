package com.clinic.dentalclinicbooking.service;

import com.clinic.dentalclinicbooking.entity.Doctor;
import com.clinic.dentalclinicbooking.entity.Patient;
import com.clinic.dentalclinicbooking.repository.DoctorRepository;
import com.clinic.dentalclinicbooking.repository.PatientRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    private final PatientRepository patientRepository;
    private final DoctorRepository doctorRepository;
    private final PasswordEncoder passwordEncoder;
    public UserService(PatientRepository patientRepository, DoctorRepository doctorRepository, PasswordEncoder passwordEncoder) {
        this.patientRepository = patientRepository; this.doctorRepository = doctorRepository; this.passwordEncoder = passwordEncoder;
    }
    public Map<String, Object> registerPatient(Patient patient) {
        Map<String, Object> result = new HashMap<>();
        if (patientRepository.existsByUsername(patient.getUsername())) {
            result.put("success", false); result.put("message", "username นี้ถูกใช้งานแล้ว"); return result;
        }
        if (!patient.getPasswordHash().equals(patient.getConfirmPassword())) {
            result.put("success", false); result.put("message", "รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน"); return result;
        }
        patient.setEmail(patient.getUsername() + "@patient.local");
        patient.setPasswordHash(passwordEncoder.encode(patient.getPasswordHash()));
        patientRepository.save(patient);
        result.put("success", true); result.put("message", "สมัครสมาชิกผู้ป่วยสำเร็จ"); return result;
    }
    public Map<String, Object> registerDoctor(Doctor doctor) {
        Map<String, Object> result = new HashMap<>();
        if (doctorRepository.existsByEmail(doctor.getEmail())) { result.put("success", false); result.put("message", "อีเมลนี้ถูกใช้งานแล้ว"); return result; }
        doctor.setPasswordHash(passwordEncoder.encode(doctor.getPasswordHash())); doctorRepository.save(doctor);
        result.put("success", true); result.put("message", "สมัครหมอสำเร็จ"); return result;
    }
}
