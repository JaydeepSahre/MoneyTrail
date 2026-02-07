package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.StatusEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.IncomeRepository;
import com.grownited.repository.StatusRepository;

@Controller
public class IncomeController {
	
	@Autowired
	IncomeRepository incomeRepository;
	
	@Autowired
	AccountRepository accountRepository;
	
	@Autowired
	StatusRepository statusRepository;
	
	// Open Add Income Page
	@GetMapping("/addincome")
	public String openAddIncomePage(Model model) {
		
		// Fetch required data from database
		List<AccountEntity> accounts = accountRepository.findAll();
		List<StatusEntity> statuses = statusRepository.findAll();
		
		// Send data to JSP
		model.addAttribute("accounts", accounts);
		model.addAttribute("statuses", statuses);
		
		return "AddIncome"; // JSP name
	}
	
	// Save Income
	@PostMapping("/saveincome")
	public String saveIncome(IncomeEntity incomeEntity) {
		
		// Print for debugging
		System.out.println("Title: " + incomeEntity.getTitle());
		System.out.println("Amount: " + incomeEntity.getAmount());
		System.out.println("Date: " + incomeEntity.getDate());
		System.out.println("Account ID: " + incomeEntity.getAccountId());
		System.out.println("Status ID: " + incomeEntity.getStatusId());
		System.out.println("Description: " + incomeEntity.getDescription());
		
		// Set userId as null for now (will be set from session later)
		incomeEntity.setUserId(null);
		
		// Save to database
		incomeRepository.save(incomeEntity);
		
		// Redirect to dashboard
		return "Dashboard";
	}
}