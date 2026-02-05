package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.AccountEntity;

public interface AccountRepository extends JpaRepository<AccountEntity, Integer> {

}
