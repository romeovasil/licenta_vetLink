package com.romeo.VetLink.config;

import com.romeo.VetLink.user.User;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.security.core.context.SecurityContextHolder;

@EqualsAndHashCode(callSuper = true)
@Data
@MappedSuperclass
public class OwnedEntity extends IdentifiableEntity{

    protected Integer owner;

    @PrePersist
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getId();
    }
}
