package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Service.Admin.RoomManagementService;

@Controller
public class AdminRoomManagementController {
	@Autowired
	private RoomManagementService roomManagementService;

	@GetMapping("/roomManagement")
	public String roomManagement(Model model) {
		List<Rooms> lstrooms = roomManagementService.listroom();
		model.addAttribute("lstroom", lstrooms);
		model.addAttribute("activePage", "room");
		return "RoomManagement";
	}

	@GetMapping("/ShowAddRoom")
	public String showAddroom(Model model) {
		Rooms room = new Rooms();
		model.addAttribute("room", room);
		model.addAttribute("activePage", "room");
		return "AddRoom";
	}

	@PostMapping("/add")
	public String saveRoom(@ModelAttribute("room") Rooms room) {
		roomManagementService.addroom(room);
		return "redirect:/roomManagement";
	}

	@GetMapping("/edit/{id}")
	public String editRoom(@PathVariable("id") int roomid, Model model) {
		Rooms room = roomManagementService.getRoomById(roomid);
		model.addAttribute("room", room);
		model.addAttribute("activePage", "room");
		return "AddRoom";

	}

	@GetMapping("/Delete/{id}")
	public String deleteRoom(@PathVariable("id") int roomId) {
		roomManagementService.DeleteRoom(roomId);
		return "redirect:/roomManagement";
	}

}
