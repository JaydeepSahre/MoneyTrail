package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.IncomeEntity;

public interface IncomeRepository extends JpaRepository<IncomeEntity, Integer>{

}
