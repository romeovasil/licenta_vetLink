package com.romeo.VetLink.appointment.domain;


import org.springframework.data.jpa.repository.JpaRepository;

public interface ConfirmedScheduleJpaRepository extends JpaRepository<ConfirmedSchedule, Integer> {
}
