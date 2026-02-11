package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {
	
	@GetMapping(value = {"/dashboard","/"})
	public String openDashboard() {
		return "Dashboard"; // JSP name
	}
}