package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.ExpenseEntity;

public interface ExpenseRepository extends JpaRepository<ExpenseEntity, Integer> {

}
