package com.romeo.VetLink.vetClinic.domain;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VetClinicJpaRepository extends JpaRepository<VetClinic, Integer> {
    List<VetClinic> findAllByOwner(Integer owner);
    VetClinic findByOwner(Integer owner);
}
