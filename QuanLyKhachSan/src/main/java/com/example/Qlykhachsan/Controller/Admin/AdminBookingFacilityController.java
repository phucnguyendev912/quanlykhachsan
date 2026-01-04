package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Service.Admin.FacilityBookingManagementAdminService;

@Controller
public class AdminBookingFacilityController {
	@Autowired
	private FacilityBookingManagementAdminService facilityBookingManagementAdminService;
	@GetMapping("/showbookingfacility")
	public String showallbookingFacility(Model model) {
		List<FacilityBooking>lst=facilityBookingManagementAdminService.getallfacilityBooking();
		model.addAttribute("lstfacility",lst);
		return "BookingFacilityManagement";
	}
	@GetMapping("/deleteFacilityBooking/{id}")
	public String deletefacility(@PathVariable("id") int facilityId) {
		facilityBookingManagementAdminService.delete(facilityId);
		return "redirect:/showbookingfacility";
	}
	
}
