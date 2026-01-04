package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Service.Admin.FacilityManagementService;

@Controller
public class AdminFacilityManagementController {
	@Autowired
	private FacilityManagementService facilityManagementService;
	@GetMapping("/facilytiesManagement")
	public String showServiceList(Model model) {
	    List<Facility> list = facilityManagementService.findAll() ;// Lấy dữ liệu từ DB
	    model.addAttribute("lstService", list); // Tên "lstService" phải khớp với items="${lstService}" trong JSP
	    return "FacilityManagement"; // Tên file JSP
	}
	@GetMapping("/showaddFacility")
	public String showaddFacility(Model model ) {
		Facility facilities=new Facility();
		model.addAttribute("facility", facilities);
		model.addAttribute("activePage", "facilities");
		return "addFacility";
	}
	@GetMapping("/addFacility")
	public String add(@ModelAttribute("facility") Facility facility) {
		facilityManagementService.addFacility(facility);
		return "redirect:/facilytiesManagement";
	}
	@GetMapping("/editfacility/{id}")
	public String  editFacility(@PathVariable("id") int facilityId, Model model) {
			Facility facility= facilityManagementService.getfacilytiById(facilityId);
			model.addAttribute("facility", facility);
			return "addFacility";
	}
	@GetMapping("/deleteFacility/{id}")
	public String deletefacility(@PathVariable("id") int facilityId) {
		facilityManagementService.deleteFacility(facilityId);
		return "redirect:/facilytiesManagement";
	}
}
