package com.romeo.VetLink.config.auth;

import com.romeo.VetLink.config.JWTService;
import com.romeo.VetLink.user.Role;
import com.romeo.VetLink.user.User;
import com.romeo.VetLink.user.UserDTO;
import com.romeo.VetLink.user.UserJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserJpaRepository userJpaRepository;
    private final PasswordEncoder passwordEncoder;
    private final JWTService jwtService;
    private final AuthenticationManager authenticationManager;
    public AuthenticationResponse authenticate(UserDTO userDTO) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(userDTO.getEmail(),userDTO.getPassword())
        );
        var user = userJpaRepository.findByEmail(userDTO.getEmail()).orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder().token(jwtToken).build();

    }

    public AuthenticationResponse register(UserDTO userDTO) {
        var user = User.builder()
                .firstname(userDTO.getFirstName())
                .lastname(userDTO.getLastName())
                .email(userDTO.getEmail())
                .password(passwordEncoder.encode(userDTO.getPassword()))
                .role(Role.USER)
                .build();

        userJpaRepository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder().token(jwtToken).build();
    }
}
