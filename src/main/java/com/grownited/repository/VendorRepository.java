package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.VendorEntity;

public interface VendorRepository extends JpaRepository<VendorEntity, Integer> {

}
