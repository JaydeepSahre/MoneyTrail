package com.grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.repository.AccountRepository;

@Controller
public class AccountController {
	
	@Autowired
	AccountRepository accountRepository;
	
	// Open Add Account Page
	@GetMapping("/addaccount")
	public String openAddAccountPage() {
		return "AddAccount"; // JSP name
	}
	
	// Save Account
	@PostMapping("/saveaccount")
	public String saveAccount(AccountEntity accountEntity) {
		
		// Print for debugging
		System.out.println("Title: " + accountEntity.getTitle());
		System.out.println("Amount: " + accountEntity.getAmount());
		System.out.println("Is Default: " + accountEntity.getExDefault());
		
		// If checkbox is not checked, exDefault will be null, so set it to false
		if (accountEntity.getExDefault() == null) {
			accountEntity.setExDefault(false);
		}
		
		// For now, set userId as null (will be set from session later)
		accountEntity.setUserId(null);
		
		// Save to database
		accountRepository.save(accountEntity);
		
		// Redirect to dashboard
		return "Dashboard";
	}
}