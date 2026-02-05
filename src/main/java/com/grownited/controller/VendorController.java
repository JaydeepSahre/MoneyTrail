package com.grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.VendorEntity;
import com.grownited.repository.VendorRepository;

@Controller
public class VendorController {
	
	@Autowired
	VendorRepository vendorRepository;
	
	// Open Add Vendor Page
	@GetMapping("/addvendor")
	public String openAddVendorPage() {
		return "AddVendor"; // JSP name
	}
	
	// Save Vendor
	@PostMapping("/savevendor")
	public String saveVendor(VendorEntity vendorEntity) {
		// Print for debugging
		System.out.println("Vendor Name: " + vendorEntity.getVendorName());
		
		// Save to database
		vendorRepository.save(vendorEntity);
		
		return "Dashboard";
	}
}