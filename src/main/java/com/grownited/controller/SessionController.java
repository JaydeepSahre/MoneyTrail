package com.grownited.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.ForgotPasswordService;
import com.grownited.service.MailerService;

import jakarta.servlet.http.HttpSession;


@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	MailerService mailerService;
	
	@Autowired
	ForgotPasswordService forgotPasswordService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
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
			if (passwordEncoder.matches(password, userEntity.getPassword())) {
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
	
    // STEP 2: send OTP
    @PostMapping("/send-otp")
    public String sendOtp(@RequestParam String email, Model model) {

        boolean sent = forgotPasswordService.sendOtp(email);

        if (!sent) {
            model.addAttribute("error", "Email not registered");
            return "ForgetPassword";
        }

        model.addAttribute("email", email);
        return "VerifyOtp";
    }

    // STEP 3: verify OTP
    @PostMapping("/verify-otp")
    public String verifyOtp(
            @RequestParam String email,
            @RequestParam String otp,
            Model model) {

        boolean valid = forgotPasswordService.verifyOtp(email, otp);

        if (!valid) {
            model.addAttribute("error", "Invalid OTP");
            model.addAttribute("email", email);
            return "VerifyOtp";
        }

        model.addAttribute("email", email);
        return "ResetPassword";
    }

    // STEP 4: reset password
    @PostMapping("/reset")
    public String resetPassword(
            @RequestParam String email,
            @RequestParam String password) {

        forgotPasswordService.updatePassword(email, password);
        return "redirect:/login";
    }
	
	@PostMapping("/register")
	public String register(UserEntity userEntity) {

		System.out.println(userEntity.getProfilePicURL());
		
		userEntity.setRole("Customer");
		userEntity.setCreatAtDate(java.time.LocalDate.now());
		userEntity.setActive(true);
		
		// encode password
		String encodedPassword = passwordEncoder.encode(userEntity.getPassword());
		System.out.println(encodedPassword);
		userEntity.setPassword(encodedPassword);
					
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
