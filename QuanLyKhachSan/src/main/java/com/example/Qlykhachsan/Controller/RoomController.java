package com.example.Qlykhachsan.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Service.RoomService;

import jakarta.servlet.http.HttpSession;

@Controller
public class RoomController {
	@Autowired
	private RoomService roomService;

	@GetMapping("/rooms")
	// lay ve so trang duoc gui tu url
	public String listRooms(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		// goi ham lay cac phong co trang thai la trong
		Page<Rooms> roomsPage = roomService.getAllRooms("Trống", page);

		// (getContent)lay ra cac du lieu trong page ra va chuyen thanh list
		// dua du lieu len jsp dung
		model.addAttribute("dsRooms", roomsPage.getContent());
		// lay ra togn so trang
		model.addAttribute("sotrang", roomsPage.getTotalPages());
		model.addAttribute("page", page);

		return "rooms";
	}

	@GetMapping("/room-detail")
	public String viewRoomDetail(@RequestParam("id") Integer id, Model model, HttpSession session) {
		
		// 1. Gọi Service lấy thông tin phòng
		Rooms room = roomService.getRoomById(id);

		// 2. Kiểm tra nếu khách gõ ID lung tung không tồn tại
		if (room == null) {
			// Đẩy về lại trang danh sách phòng
			return "redirect:/rooms";
		}

		// 3. Gửi object phòng sang bên JSP
		model.addAttribute("room", room);

		// 4. Trả về tên file JSP (Bạn nhớ đặt tên file JSP là room-detail.jsp nhé)
		return "roomdetail";
	}
}
