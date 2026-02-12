package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;

@Controller
public class UserController {
	
	@Autowired
	UserRepository userRepository;
	
	@GetMapping("/adduser")
	public String addUser() {
		return "AddUser";
	}
	
	@PostMapping("/saveuser")
	public String saveUser(UserEntity userEntity) {
		userEntity.setRole("Customer");
		userEntity.setCreatAtDate(java.time.LocalDate.now());
		userEntity.setActive(true);
		userRepository.save(userEntity);
		return "redirect:/listuser";
	}
	
	@GetMapping("listuser")
	public String listUsers(Model model) {
		List<UserEntity> userList = userRepository.findAll();
		model.addAttribute("userList", userList);
		return "ListUser";
	}

}
