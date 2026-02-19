package com.grownited.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailerService;

import jakarta.servlet.http.HttpSession;


@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	MailerService mailerService;
	
	@GetMapping("/signup")
	public String openSignupPage() {
		return "Signup"; //jsp name
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@PostMapping("/authenticate")
	public String authenticate(String email, String password, Model model, HttpSession session) {
		Optional<UserEntity> op = userRepository.findByEmail(email);
		
		if(op.isPresent()) {
			UserEntity userEntity = op.get();
			session.setAttribute("user", userEntity);
			if(userEntity.getPassword().equals(password)) {
				if(userEntity.getRole().equals("Admin")) {
					return "redirect:/admin-dashboard";
				}else if(userEntity.getRole().equals("Customer")) {
					return "redirect:/customer-dashboard";
				}
			}
		}
		model.addAttribute("error", "Invalid Credentials");
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
		mailerService.sendWelcomeEmail(userEntity);
		return "Login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "Login";
	}
	

}
