package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.StatusEntity;

public interface StatusRepository extends JpaRepository<StatusEntity, Integer> {

}
