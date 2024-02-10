package com.romeo.VetLink.vetClinic.domain;


import com.romeo.VetLink.vetClinic.service.dtos.VetClinicService;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VetClinicJpaRepository extends JpaRepository<VetClinic, Integer> {
    List<VetClinic> findAllByOwner(String owner);
}
