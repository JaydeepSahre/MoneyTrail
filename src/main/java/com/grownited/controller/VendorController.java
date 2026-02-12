package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.VendorEntity;
import com.grownited.repository.VendorRepository;

@Controller
public class VendorController {
	
	@Autowired
	VendorRepository vendorRepository;
	
	@GetMapping("/addvendor")
	public String addVendor() {
		return "AddVendor";
	}
	
	@PostMapping("/savevendor")
	public String saveVendor(VendorEntity vendorEntity) {
		vendorRepository.save(vendorEntity);
		return "redirect:/listvendor";
	}
	
	@GetMapping("/listvendor")
	public String listVendor(Model model) {
		List<VendorEntity> vendorList = vendorRepository.findAll();
		model.addAttribute("vendorList", vendorList);
		return "ListVendor"; 
	}
	
	@GetMapping("/deletevendor")
	public String deleteVendor(Integer vendorId) {
		vendorRepository.deleteById(vendorId);
		return "redirect:/listvendor";
	}
}