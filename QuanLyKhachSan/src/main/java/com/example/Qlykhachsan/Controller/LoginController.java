package com.example.Qlykhachsan.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.Qlykhachsan.Dto.LoginRequest;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Service.AuthService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	@Autowired
	private AuthService authService;

	@GetMapping("/login")
	public String LoginForm(Model model) {
		model.addAttribute("loginrequest", new LoginRequest());
		return "login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute("loginRequest") LoginRequest request, HttpSession session, Model model) {
		// goi ham login
		Account account = authService.login(request);
		if (account != null) {
			// dang nhap thanh cong
			session.setAttribute("currentUser", account);
			String rolename = account.getRole().getRoleName();
			if (rolename.equalsIgnoreCase("admin")) {
				return "redirect:/admin";
			} else {
				return "redirect:/LandingPage";
			}
		} else {
			model.addAttribute("Error", "Sai ten dang nhap hoac mat khau");
			return "login";
		}

	}

}