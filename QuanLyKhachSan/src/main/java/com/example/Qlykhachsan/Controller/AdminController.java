package com.example.Qlykhachsan.Controller;

import org.springframework.stereotype.Controller; // Nhớ import cái này
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Model.Account;

import jakarta.servlet.http.HttpSession;

@Controller // <--- BẮT BUỘC PHẢI CÓ
public class AdminController {

	@GetMapping("/admin")
	public String adminPage(HttpSession session, Model model) {

		// 1. Lấy user hiện tại từ session
		Account currentUser = (Account) session.getAttribute("currentUser");

		// 2. CHECK BẢO MẬT (Quan trọng)
		// Nếu chưa đăng nhập HOẶC role không phải admin -> Đá về trang login
		if (currentUser == null || !currentUser.getRole().getRoleName().equalsIgnoreCase("admin")) {
			return "redirect:/login";
		}

		// 3. Nếu đúng là Admin thì gửi tên sang giao diện
		model.addAttribute("adminName", currentUser.getAccountName());

		// 4. Trả về đúng tên file JSP bạn đã tạo
		// Nếu file bạn tên là AdminDashboard.jsp thì điền vào đây
		return "admin";
	}
}