package com.example.Qlykhachsan.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Service.RoomService;
import com.example.Qlykhachsan.Service.Admin.BookingRoomManagementService;

@Controller
public class AdminBookingRoomManagementController {
	@Autowired
	private BookingRoomManagementService bookingRoomManagementService;
	@Autowired
	private RoomService roomService;
	@GetMapping("/bookingroomManagement")
	public String lstroomBooking(Model model) {
		List<RoomBooking> listbookingRoom = bookingRoomManagementService.getRoomBooking();
		model.addAttribute("lstroombooking", listbookingRoom);
		return "bookingroomManagement";
	}
	@GetMapping("/checkin")
	public String checkin(@RequestParam("id") int roombookingId ) {
		RoomBooking booking=bookingRoomManagementService.getRoomBookingById(roombookingId);
		booking.setStatusBooking("Đã checkin");
		bookingRoomManagementService.saveBooking(booking);
		return "redirect:/bookingroomManagement";
	}
	@GetMapping("/checkout")
	public String checkout(@RequestParam("id") int roombookingId) {
		RoomBooking booking=bookingRoomManagementService.getRoomBookingById(roombookingId);
		booking.setStatusBooking("Đã checkout");
		bookingRoomManagementService.saveBooking(booking);
		Rooms  room=roomService.getRoomById(booking.getRoomId());
		room.setStatusroom("Trống");
		roomService.save(room);
		return "redirect:/bookingroomManagement";
	}
}
