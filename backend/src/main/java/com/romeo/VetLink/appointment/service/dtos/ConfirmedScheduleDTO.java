package com.romeo.VetLink.appointment.service.dtos;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ConfirmedScheduleDTO {
    private Integer id;

    private LocalDateTime start;
    private LocalDateTime end;
    private Integer doctorNumber;
}
