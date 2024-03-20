package com.romeo.VetLink.patients.domain;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PatientJpaRepository extends JpaRepository<Patient, Integer> {
    List<Patient> findAllByOwner(Integer owner);
}
