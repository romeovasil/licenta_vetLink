package com.romeo.VetLink.demo;

import com.romeo.VetLink.config.JWTService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/demo-controller")
@RequiredArgsConstructor
public class DemoController {
    private final JWTService jwtService;

    @GetMapping
    public ResponseEntity<String> sayHello(@RequestHeader HttpHeaders header){
        final String authHeader = header.get("Authorization").get(0);
        final String jwt;

        jwt = authHeader.substring(7);
        System.out.println(jwtService.extractUsername(jwt));
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return ResponseEntity.ok("Hello from secured endpoint");
    }
}
