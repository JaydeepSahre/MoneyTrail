package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.StatusEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.entity.VendorEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.StatusRepository;
import com.grownited.repository.SubCategoryRepository;
import com.grownited.repository.VendorRepository;

@Controller
public class ExpenseController {
	
	@Autowired
	ExpenseRepository expenseRepository;
	
	@Autowired
	CategoryRepository categoryRepository;
	
	@Autowired
	SubCategoryRepository subCategoryRepository;
	
	@Autowired
	VendorRepository vendorRepository;
	
	@Autowired
	AccountRepository accountRepository;
	
	@Autowired
	StatusRepository statusRepository;
	
	// Open Add Expense Page
	@GetMapping("/addexpense")
	public String openAddExpensePage(Model model) {
		
		// Fetch all required data from database
		List<CategoryEntity> categories = categoryRepository.findAll();
		List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();
		List<VendorEntity> vendors = vendorRepository.findAll();
		List<AccountEntity> accounts = accountRepository.findAll();
		List<StatusEntity> statuses = statusRepository.findAll();
		
		// Send data to JSP
		model.addAttribute("categories", categories);
		model.addAttribute("subCategories", subCategories);
		model.addAttribute("vendors", vendors);
		model.addAttribute("accounts", accounts);
		model.addAttribute("statuses", statuses);
		
		return "AddExpense"; // JSP name
	}
	
	// Save Expense
	@PostMapping("/saveexpense")
	public String saveExpense(ExpenseEntity expenseEntity) {
		
		// Print for debugging
		System.out.println("Title: " + expenseEntity.getTitle());
		System.out.println("Amount: " + expenseEntity.getAmount());
		System.out.println("Date: " + expenseEntity.getDate());
		System.out.println("Category ID: " + expenseEntity.getCategoryId());
		System.out.println("SubCategory ID: " + expenseEntity.getSubCategoryId());
		System.out.println("Vendor ID: " + expenseEntity.getVendorId());
		System.out.println("Account ID: " + expenseEntity.getAccountId());
		System.out.println("Status ID: " + expenseEntity.getStatusId());
		System.out.println("Description: " + expenseEntity.getDescription());
		
		// Set userId as null for now (will be set from session later)
		expenseEntity.setUserId(null);
		
		// Save to database
		expenseRepository.save(expenseEntity);
		
		// Redirect to dashboard
		return "Dashboard";
	}
}