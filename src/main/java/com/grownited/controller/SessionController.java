package com.grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;

@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@GetMapping("/signup")
	public String openSignupPage() {
		return "Signup"; //jsp name
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@GetMapping("/forgetpassword")
	public String openForgetPasswordPage() {
		return "ForgetPassword";
	}
	
	@PostMapping("/register")
	public String register(UserEntity userEntity) {
		System.out.println(userEntity.getFirstName());
		System.out.println(userEntity.getLastName());
		System.out.println(userEntity.getEmail());
		System.out.println(userEntity.getContactNum());
		System.out.println(userEntity.getBirthYear());
		System.out.println(userEntity.getGender());
		System.out.println(userEntity.getPassword());
		System.out.println(userEntity.getProfilePicURL());
		
		userEntity.setRole("Customer");
		userEntity.setCreatAtDate(java.time.LocalDate.now());
		userEntity.setActive(true);
		
		//call repository save method
		userRepository.save(userEntity);
		return "Login";
	}
	

}
