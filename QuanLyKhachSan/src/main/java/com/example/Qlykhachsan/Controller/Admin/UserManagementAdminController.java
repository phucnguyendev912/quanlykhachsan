package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Service.Admin.UserManamentAdminService;

@Controller
public class UserManagementAdminController {
	@Autowired
	private UserManamentAdminService userManamentAdminService;

	@GetMapping("/usermanagement")
	public String usermanagement(Model model) {
	List<User>lstuser=userManamentAdminService.getall();
	model.addAttribute("lstUser",lstuser);
	return "userManagement";
	}
	@Controller
	public class UserController {

	    

	    // 1. Hiển thị form thêm mới
	    @GetMapping("/addUser")
	    public String showAddForm(Model model) {
	        User user = new User();
	        user.setSex(true); // Mặc định chọn Nam
	        user.setStatus("ACTIVE"); // Mặc định là Hoạt động
	        
	        model.addAttribute("user", user);
	        return "addUser"; // Tên file JSP bên dưới
	    }

	   
	    @PostMapping("/saveUser")
	    public String saveUser(@ModelAttribute("user") User user) {
	    userManamentAdminService.saveUser(user);
	        return "redirect:/usermanagement"; // Lưu xong quay về trang danh sách
	    }
	    @GetMapping("/editUser/{id}")
	    public String showEditForm(@PathVariable("id") Integer id, Model model) {
	        // 1. Lấy thông tin người dùng cũ từ DB
	        User existingUser =userManamentAdminService.getuserById(id);

	       
	        if (existingUser != null) {
	            model.addAttribute("user", existingUser);
	            return "addUser"; 
	        }
	        return "redirect:/usermanagement"; 
	    }
	    @GetMapping("/deleteUser/{id}")
	    public String deleteUser(@PathVariable("id") Integer id) {
	        userManamentAdminService.deleteUser(id);
	        return "redirect:/usermanagement";
	    }
	}
}
