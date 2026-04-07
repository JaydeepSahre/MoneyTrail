package com.grownited.repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.ExpenseEntity;

@Repository
public interface ExpenseRepository extends JpaRepository<ExpenseEntity, Integer> {
	List<ExpenseEntity> findByUserId(Integer userId);
	
	@Query("SELECT SUM(e.amount) FROM ExpenseEntity e " +
	           "WHERE e.userId = :userId " +
	           "  AND e.expenseDate >= :startDate " +
	           "  AND e.expenseDate <= :endDate")
	    BigDecimal sumByUserIdAndDateBetween(
	            @Param("userId")    Integer   userId,
	            @Param("startDate") LocalDate startDate,
	            @Param("endDate")   LocalDate endDate);
	
	@Query("SELECT SUM(e.amount) FROM ExpenseEntity e WHERE e.userId = :userId")
    BigDecimal sumByUserId(@Param("userId") Integer userId);
	
	List<ExpenseEntity> findTop9ByUserIdOrderByExpenseDateDesc(Integer userId);
}
