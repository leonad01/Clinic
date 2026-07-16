package com.clinic.dentalclinicbooking.service;

import com.clinic.dentalclinicbooking.entity.Appointment;
import com.clinic.dentalclinicbooking.repository.AppointmentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;

    public AppointmentService(AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    public Appointment save(Appointment appointment) {
        return appointmentRepository.save(appointment);
    }

    public List<Appointment> findAll() {
        return appointmentRepository.findAll();
    }

    public Appointment findById(Long id) {
        return appointmentRepository.findById(id).orElseThrow();
    }

    public void approve(Long id) {
        Appointment appointment = appointmentRepository.findById(id).orElseThrow();
        appointment.setStatus("อนุมัติแล้ว");
        appointmentRepository.save(appointment);
    }

    public void reject(Long id) {
        Appointment appointment = appointmentRepository.findById(id).orElseThrow();
        appointment.setStatus("ปฏิเสธแล้ว");
        appointmentRepository.save(appointment);
    }
}
