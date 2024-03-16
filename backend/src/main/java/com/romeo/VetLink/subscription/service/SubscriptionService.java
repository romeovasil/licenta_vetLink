package com.romeo.VetLink.subscription.service;
import com.romeo.VetLink.subscription.domain.Subscription;
import com.romeo.VetLink.subscription.domain.SubscriptionJpaRepository;
import com.romeo.VetLink.subscription.service.dtos.SubscriptionDTO;
import com.romeo.VetLink.subscription.service.dtos.SubscriptionDTOMapper;
import com.romeo.VetLink.user.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class SubscriptionService {
    private final SubscriptionJpaRepository subscriptionJpaRepository;
    private final SubscriptionDTOMapper subscriptionDTOMapper;

    @Transactional
    public void save (SubscriptionDTO subscriptionDTO){
        Subscription subscription = this.subscriptionJpaRepository.save(this.subscriptionDTOMapper.mapDtoToEntity(subscriptionDTO));
    }

    public List<SubscriptionDTO> getAllByOwner() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Subscription> subscriptions = this.subscriptionJpaRepository.findAllByOwner(user.getClinicId());

        return subscriptions.stream().map(this.subscriptionDTOMapper::mapEntityToDTO).toList();

    }
}
