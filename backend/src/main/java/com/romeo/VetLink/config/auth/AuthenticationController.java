package com.romeo.VetLink.config.auth;


import com.romeo.VetLink.user.UserDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authenticationService;
    private final AuthValidator authValidator;
    @PostMapping("/register")
    public ResponseEntity<?> register(
            @RequestBody UserDTO userDTO, BindingResult result){

        authValidator.validate(userDTO,result);
        if (result.hasErrors()) {
            return ResponseEntity.badRequest().body(new ErrorResponse("Validation errors", result.getAllErrors()));
        }
        return ResponseEntity.ok(authenticationService.register(userDTO));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(
            @RequestBody UserDTO userDTO){
        return ResponseEntity.ok(authenticationService.authenticate(userDTO));
    }

}
