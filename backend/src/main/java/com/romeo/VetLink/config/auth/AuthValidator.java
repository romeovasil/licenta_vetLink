package com.romeo.VetLink.config.auth;

import com.romeo.VetLink.user.User;
import com.romeo.VetLink.user.UserDTO;
import com.romeo.VetLink.user.UserJpaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.Optional;

@Component
@AllArgsConstructor
public class AuthValidator implements Validator {
    private final UserJpaRepository userJpaRepository;
    @Override
    public boolean supports(Class<?> clazz) {
        return UserDTO.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UserDTO userDTO = (UserDTO) target;

        Optional<User> user = userJpaRepository.findByEmail(userDTO.getEmail());

        if(user.isPresent()){
            errors.reject("Email already exists");
        }

    }
}
