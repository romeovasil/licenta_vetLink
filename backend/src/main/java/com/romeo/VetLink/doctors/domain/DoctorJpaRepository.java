package com.romeo.VetLink.doctors.domain;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DoctorJpaRepository extends JpaRepository<Doctor, Integer> {
    List<Doctor> findAllByOwner(Integer owner);
}
