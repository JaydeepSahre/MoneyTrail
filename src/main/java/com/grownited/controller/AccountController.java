package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AccountRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class AccountController {
	
	@Autowired
	AccountRepository accountRepository;
	
	@GetMapping("/addaccount")
	public String addAccount() {
		return "AddAccount";
	}
	
	@PostMapping("/saveaccount")
	public String saveAccount(AccountEntity accountEntity, HttpSession session) {
		if (accountEntity.getExDefault() == null) {
			accountEntity.setExDefault(false);
		}
		
		UserEntity currentUser = (UserEntity) session.getAttribute("user");
		accountEntity.setUserId(currentUser.getUserId());
		accountRepository.save(accountEntity);
		
		return "redirect:/listaccount";
	}
	
	@GetMapping("/listaccount")
	public String listAccount(Model model) {
		List<AccountEntity> accountList = accountRepository.findAll();
		model.addAttribute("accountList", accountList);
		return "ListAccount";
	}
	
	@GetMapping("/deleteaccount")
	public String deleteAccount(Integer accountId) {
		accountRepository.deleteById(accountId);
		return "redirect:/listaccount";
	}
}
