package com.romeo.VetLink.config;

import com.romeo.VetLink.user.User;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import org.springframework.security.core.context.SecurityContextHolder;

@MappedSuperclass
public class OwnedEntity {

    private String owner;

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @PrePersist
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getId().toString();
    }
}
