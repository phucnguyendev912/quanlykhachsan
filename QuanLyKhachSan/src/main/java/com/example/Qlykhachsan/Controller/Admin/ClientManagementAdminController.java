package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Service.Admin.ClientManagementAdmin;

@Controller
public class ClientManagementAdminController {
	@Autowired
	private ClientManagementAdmin clientManagementAdmin;

	@GetMapping("/clientManagement")
	public String clientManagement(Model model) {
		List<Clients>lstclient=clientManagementAdmin.getall();
		model.addAttribute("lstclient",lstclient);
		return "clientManagement";
	}
}
