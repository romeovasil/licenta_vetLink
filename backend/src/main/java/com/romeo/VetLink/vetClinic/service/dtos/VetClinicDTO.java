package com.romeo.VetLink.vetClinic.service.dtos;

import lombok.Data;

@Data
public class VetClinicDTO {
    String id;
    String name;
    String county;
    String city;
    String street;
    String number;
    String phoneNumber;
    String shortDescription;
    String owner;
}
