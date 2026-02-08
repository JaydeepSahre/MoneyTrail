package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

		
		if (accountEntity.getExDefault() == null) {
			accountEntity.setExDefault(false);
		}
		
		accountRepository.save(accountEntity);
		
		return "redirect:/listaccount";
	}
	
	@GetMapping("/listaccount")
	public String listAccount(Model model) {
		List<AccountEntity> accountList = accountRepository.findAll();
		model.addAttribute("accountList", accountList);
		return "ListAccount";
	}
}
