package com.romeo.VetLink.user;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserJpaRepository extends JpaRepository <User, Integer>{
    Optional<User> findByEmail(String email);
}
