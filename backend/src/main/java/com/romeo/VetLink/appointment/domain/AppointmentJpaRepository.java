package com.romeo.VetLink.appointment.domain;



import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AppointmentJpaRepository extends JpaRepository<Appointment, Integer> {
    List<Appointment> findAllByOwner(Integer owner);
}
