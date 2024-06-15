package com.romeo.VetLink.appointment.domain;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AppointmentRequestJpaRepository extends JpaRepository<AppointmentRequest, Integer> {

    List<AppointmentRequest> findAllByOwner(Integer owner);
}
