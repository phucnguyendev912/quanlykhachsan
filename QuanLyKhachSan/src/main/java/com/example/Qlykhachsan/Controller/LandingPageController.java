package com.example.Qlykhachsan.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Model.Account;

import jakarta.servlet.http.HttpSession;

@Controller
public class LandingPageController {

	@GetMapping("/LandingPage")
	public String showLandingPage(HttpSession session, Model model) {
		// lay thong tin nguoi dung bang session
		Account currentUser = (Account) session.getAttribute("currentUser");

		if (currentUser != null) {
			// --- TRƯỜNG HỢP ĐÃ ĐĂNG NHẬP ---
			model.addAttribute("isLoggedIn", true);
			model.addAttribute("fullName", currentUser.getUser().getFullname());

		} else {
			// --- TRƯỜNG HỢP CHƯA ĐĂNG NHẬP: khach chua dang ki tai khoan
			model.addAttribute("isLoggedIn", false);
		}

		return "LandingPage";
	}
}