-- Run once against database: dental_booking. Existing appointments/patients are retained.
ALTER TABLE patients ADD COLUMN id_card VARCHAR(255) NULL UNIQUE;
ALTER TABLE appointments
    ADD COLUMN appointment_end_time VARCHAR(255) NULL,
    ADD COLUMN patient_id BIGINT NULL,
    ADD COLUMN dentist_id BIGINT NULL,
    ADD COLUMN nurse_id BIGINT NULL,
    ADD COLUMN service_id BIGINT NULL,
    ADD COLUMN dentist_schedule_id BIGINT NULL UNIQUE;

CREATE TABLE dentists (
    dentist_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    dentist_username VARCHAR(255) NOT NULL UNIQUE,
    dentist_password VARCHAR(255) NOT NULL,
    dentist_first_name VARCHAR(255) NOT NULL,
    dentist_last_name VARCHAR(255) NOT NULL,
    dentist_phone VARCHAR(255),
    dentist_email VARCHAR(255) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE nurses (
    nurse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nurse_username VARCHAR(255) NOT NULL UNIQUE,
    nurse_password VARCHAR(255) NOT NULL,
    nurse_first_name VARCHAR(255) NOT NULL,
    nurse_last_name VARCHAR(255) NOT NULL,
    nurse_phone VARCHAR(255),
    nurse_email VARCHAR(255) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE rooms (
    room_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(255) NOT NULL UNIQUE,
    room_status VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE services (
    service_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL UNIQUE,
    service_price VARCHAR(255) NOT NULL,
    service_duration VARCHAR(255),
    service_category VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE admins (
    admin_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    admin_username VARCHAR(255) NOT NULL UNIQUE,
    admin_password VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE dentist_schedules (
    schedule_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    schedule_date VARCHAR(255) NOT NULL,
    schedule_start_time VARCHAR(255) NOT NULL,
    schedule_end_time VARCHAR(255) NOT NULL,
    schedule_status VARCHAR(255) NOT NULL,
    dentist_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    nurse_id BIGINT NULL,
    CONSTRAINT fk_schedule_dentist FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    CONSTRAINT fk_schedule_room FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    CONSTRAINT fk_schedule_nurse FOREIGN KEY (nurse_id) REFERENCES nurses(nurse_id)
) ENGINE=InnoDB;

CREATE TABLE treatment_histories (
    treatment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    treatment_date VARCHAR(255) NOT NULL,
    note VARCHAR(2000),
    patient_id BIGINT NOT NULL,
    dentist_id BIGINT NOT NULL,
    appointment_id BIGINT NOT NULL UNIQUE,
    CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES patients(id),
    CONSTRAINT fk_history_dentist FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    CONSTRAINT fk_history_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
) ENGINE=InnoDB;

ALTER TABLE appointments
    ADD CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients(id),
    ADD CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    ADD CONSTRAINT fk_appointment_nurse FOREIGN KEY (nurse_id) REFERENCES nurses(nurse_id),
    ADD CONSTRAINT fk_appointment_service FOREIGN KEY (service_id) REFERENCES services(service_id),
    ADD CONSTRAINT fk_appointment_schedule FOREIGN KEY (dentist_schedule_id) REFERENCES dentist_schedules(schedule_id);
