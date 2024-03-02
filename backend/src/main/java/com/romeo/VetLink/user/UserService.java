package com.romeo.VetLink.user;

import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
public class UserService {
    private final UserJpaRepository userJpaRepository;

    public UserService(UserJpaRepository userJpaRepository) {
        this.userJpaRepository = userJpaRepository;
    }

    public Optional<User> findById(Integer id){
        return userJpaRepository.findById(id);
    }
}
