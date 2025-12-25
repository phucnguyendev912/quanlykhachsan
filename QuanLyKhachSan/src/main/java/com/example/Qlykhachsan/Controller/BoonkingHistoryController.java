package com.example.Qlykhachsan.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Dto.BookingHistory;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Service.BookingHistoryService;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoonkingHistoryController {
	@Autowired
	private BookingHistoryService bookingHistoryService;

	@GetMapping("/bookinghistory")
	public String bookingHistory(HttpSession session, Model model) {
		Account acc = (Account) session.getAttribute("currentUser");
		if (acc == null) {
			return "redirect:/login";
		}
		User user = (User) session.getAttribute("userId");
		Clients client = user.getClient();
		BookingHistory bk = new BookingHistory();
		System.out.println("id booking " + bk.getId());

		List<BookingHistory> histories = bookingHistoryService.getBookingHistory(client);
		model.addAttribute("histories", histories);

		return "BookingHistory";
	}
}
