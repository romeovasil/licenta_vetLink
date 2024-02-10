package com.romeo.VetLink.config.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.validation.ObjectError;

import java.util.List;
@AllArgsConstructor
@Data
public class ErrorResponse {
    private String message;
    private List<ObjectError> errors;

}
