package com.romeo.VetLink.config;

import com.romeo.VetLink.user.User;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import org.springframework.security.core.context.SecurityContextHolder;

@MappedSuperclass
public class OwnedEntity {

    protected Integer owner;

    public Integer getOwner() {
        return owner;
    }

    public void setOwner(Integer owner) {
        this.owner = owner;
    }

    @PrePersist
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getId();
    }
}
