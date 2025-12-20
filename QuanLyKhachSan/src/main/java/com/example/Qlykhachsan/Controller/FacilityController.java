
package com.example.Qlykhachsan.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Service.FacilityService;

@Controller
public class FacilityController {
	@Autowired
	private FacilityService facilityService;

	@GetMapping("/facilitys")
	public String listFacility(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		Page<Facility> dsFacility = facilityService.getallFacility(page);
		model.addAttribute("dsFacility", dsFacility.getContent());
		model.addAttribute("sotrang", dsFacility.getTotalPages());
		model.addAttribute("page", page);
		return "Facility";
	}
}
