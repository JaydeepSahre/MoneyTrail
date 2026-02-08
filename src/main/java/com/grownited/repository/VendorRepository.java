package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.VendorEntity;

@Repository
public interface VendorRepository extends JpaRepository<VendorEntity, Integer> {

}
