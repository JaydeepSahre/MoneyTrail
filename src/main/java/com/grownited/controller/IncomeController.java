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
	
	@GetMapping("/addincome")
	public String AddIncome(Model model) {
		List<AccountEntity> accounts = accountRepository.findAll();
		List<StatusEntity> statuses = statusRepository.findAll();
		
		model.addAttribute("accounts", accounts);
		model.addAttribute("statuses", statuses);
		
		return "AddIncome";
	}
	
	@PostMapping("/saveincome")
	public String saveIncome(IncomeEntity incomeEntity) {
		incomeRepository.save(incomeEntity);
		return "redirect:/listincome";
	}
	
	@GetMapping("/listincome")
	public String listIncome(Model model) {
		List<IncomeEntity> incomeList = incomeRepository.findAll();
		List<AccountEntity> accounts = accountRepository.findAll();
		List<StatusEntity> statuses = statusRepository.findAll();
		
		model.addAttribute("incomeList", incomeList);
		model.addAttribute("accounts", accounts);
		model.addAttribute("statuses", statuses);
		
		return "ListIncome";
	}
	
	@GetMapping("/deleteincome")
	public String deleteIncome(int incomeId) {
		incomeRepository.deleteById(incomeId);
		return "redirect:/listincome";
	}
}