package com.romeo.VetLink.patients.service.dtos;

import lombok.Data;

@Data
public class PatientDTO {
    private Integer id;

    private String type;
    private String race;
    private String subRace;
    private String name;
    private Integer age;
    private String allergy;
    private String healthProblems;
}
