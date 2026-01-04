package com.example.Qlykhachsan.Controller.Admin;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Service.Admin.StatisticsService;

@Controller
public class StatisticsController {
	@Autowired
	private StatisticsService statisticsService;

	@GetMapping("/statistics") // Hoặc admin/dashboard
	public String showDashboard(Model model) {
		int currentYear = LocalDate.now().getYear();
		int currentMonthIndex = LocalDate.now().getMonthValue() - 1;

		// 1. Lấy dữ liệu riêng lẻ
		List<Double> roomRevenueList = statisticsService.getRoomRevenueOnly(currentYear);
		List<Double> facilityRevenueList = statisticsService.getFacilityRevenueOnly(currentYear);

		// 2. Tính tổng (bằng cách cộng 2 list lại)
		List<Double> totalRevenueList = new ArrayList<>();
		for (int i = 0; i < 12; i++) {
			totalRevenueList.add(roomRevenueList.get(i) + facilityRevenueList.get(i));
		}

		// 3. Lấy số liệu tháng hiện tại
		Double currentRoomRev = roomRevenueList.get(currentMonthIndex);
		Double currentFacilityRev = facilityRevenueList.get(currentMonthIndex);
		Double currentTotalRev = totalRevenueList.get(currentMonthIndex);

		// 4. Gửi sang View
		model.addAttribute("roomData", roomRevenueList); // Dữ liệu biểu đồ Phòng
		model.addAttribute("facilityData", facilityRevenueList); // Dữ liệu biểu đồ Dịch vụ

		// Dữ liệu hiển thị Text
		model.addAttribute("currentTotalRevenue", currentTotalRev);
		model.addAttribute("currentRoomRevenue", currentRoomRev);
		model.addAttribute("currentFacilityRevenue", currentFacilityRev);

		model.addAttribute("currentYear", currentYear);

		return "Dashboard";
	}
}
