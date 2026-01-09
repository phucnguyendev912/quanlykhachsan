package com.example.Qlykhachsan.Controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.Qlykhachsan.Dto.RegisterRequest;
import com.example.Qlykhachsan.Service.AuthService;

@Controller
public class RegisterController {
	@Autowired
	private AuthService authService;

	@GetMapping("/register")
	public String RegisterForm(Model model) {
		model.addAttribute("registerRequest", new RegisterRequest());
		return "Register";
	}

	@PostMapping("/register")
	public String registerSubmit(@ModelAttribute("registerRequest") RegisterRequest request, Model model)
			throws UnsupportedClassVersionError, NoSuchAlgorithmException, UnsupportedEncodingException {

		// Gọi Service để xử lý logic

		boolean isSuccess = authService.register(request);

		if (isSuccess) {
			return "redirect:/login"; // Đăng ký xong chuyển hướng về trang đăng nhập
		} else {
			model.addAttribute("error", "Đăng ký thất bại!");
			return "Register"; // Ở lại trang đăng ký nếu lỗi
		}
	}
}
