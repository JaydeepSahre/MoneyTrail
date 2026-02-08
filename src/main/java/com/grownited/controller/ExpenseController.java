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
	
	@GetMapping("/addexpense")
	public String addExpense(Model model) {
		
		List<CategoryEntity> categories = categoryRepository.findAll();
		List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();
		List<VendorEntity> vendors = vendorRepository.findAll();
		List<AccountEntity> accounts = accountRepository.findAll();
		List<StatusEntity> statuses = statusRepository.findAll();
		
		
		model.addAttribute("categories", categories);
		model.addAttribute("subCategories", subCategories);
		model.addAttribute("vendors", vendors);
		model.addAttribute("accounts", accounts);
		model.addAttribute("statuses", statuses);
		
		return "AddExpense";
	}
	
	@PostMapping("/saveexpense")
	public String saveExpense(ExpenseEntity expenseEntity) {
		expenseRepository.save(expenseEntity);
		return "redirect:/listexpense";
	}
	
	@GetMapping("/listexpense")
	public String listExpense(Model model) {
		List<ExpenseEntity> expenseList = expenseRepository.findAll();
		List<CategoryEntity> categories = categoryRepository.findAll();
		List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();
		List<VendorEntity> vendors = vendorRepository.findAll();
		List<AccountEntity> accounts = accountRepository.findAll();
		List<StatusEntity> statuses = statusRepository.findAll();
		
		model.addAttribute("expenseList", expenseList);
		model.addAttribute("categories", categories);
		model.addAttribute("subCategories", subCategories);
		model.addAttribute("vendors", vendors);
		model.addAttribute("accounts", accounts);
		model.addAttribute("statuses", statuses);
		
		return "ListExpense";
	}
}