package com.romeo.VetLink.config;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import lombok.Data;

@Data
@MappedSuperclass
public class IdentifiableEntity {
    @Id
    @GeneratedValue
    private Integer id;
}
