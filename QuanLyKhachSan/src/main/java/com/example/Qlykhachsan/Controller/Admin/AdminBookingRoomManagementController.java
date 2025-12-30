package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Service.Admin.BookingRoomManagementService;

@Controller
public class AdminBookingRoomManagementController {
	@Autowired
	private BookingRoomManagementService bookingRoomManagementService;

	@GetMapping("/bookingroomManagement")
	public String lstroomBooking(Model model) {
		List<RoomBooking> listbookingRoom = bookingRoomManagementService.getRoomBooking();
		model.addAttribute("lstroombooking", listbookingRoom);
		return "bookingroomManagement";
	}
}
