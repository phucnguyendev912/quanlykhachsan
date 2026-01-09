package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Service.Admin.AccountAdminService;

@Controller
public class AdminAccountController {
	@Autowired
	private AccountAdminService accountAdminService;

	@GetMapping("/accountManagement")
	public String ManagementAccount(Model model) {
		List<Account> lstAccount = accountAdminService.findAll();
		model.addAttribute("lstAccount", lstAccount);
		return "AccountManagement";
	}
}
