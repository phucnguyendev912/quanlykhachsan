package com.example.Qlykhachsan.Controller.Admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Model.Account;

import jakarta.servlet.http.HttpSession;

@Controller 
public class AdminController {

	@GetMapping("/admin")
	public String adminPage(HttpSession session, Model model) {

		// 1. Lấy user hiện tại từ session
		Account currentUser = (Account) session.getAttribute("currentUser");

		
		if (currentUser == null || !currentUser.getRole().getRoleName().equalsIgnoreCase("admin")) {
			return "redirect:/login";
		}

		
		model.addAttribute("adminName", currentUser.getAccountName());

		
		
		return "admin";
	}
	@GetMapping("/Dashboard")
	public String Dashboard(Model model) {
		return "Dashboard";
	}
}
