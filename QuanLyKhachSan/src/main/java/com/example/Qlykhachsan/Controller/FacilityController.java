
package com.example.Qlykhachsan.Controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Service.FacilityBookingService;
import com.example.Qlykhachsan.Service.FacilityService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class FacilityController {

	@Autowired
	private FacilityService facilityService;
	@Autowired
	private FacilityBookingService facilityBookingService;

	@GetMapping("/facilitys")
	public String listFacility(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		Page<Facility> dsFacility = facilityService.getallFacility(page);
		model.addAttribute("dsFacility", dsFacility.getContent());
		model.addAttribute("sotrang", dsFacility.getTotalPages());
		model.addAttribute("page", page);
		return "Facility";
	}

	@GetMapping("/bookingService")
	public String showBookingPage(@RequestParam("id") int id, Model model) {
		// Lấy thông tin dịch vụ để hiển thị tên
		Facility facility = facilityService.getFacilityById(id);
		model.addAttribute("service", facility);
		return "bookingFacility";
	}

//	@PostMapping("/confirm-Facilitybooking")
//	public String handleBooking(HttpServletRequest req, FacilityBooking facilitybooking, HttpSession session) {
//		Account currentUser = (Account) session.getAttribute("currentUser");
//		if (currentUser == null) {
//			return "redirect:/login";
//		}
//		User userId = (User) session.getAttribute("userId");
//		if (userId == null || userId.getUserId() == null) {
//			throw new RuntimeException("USER hoặc CLIENT NULL – kiểm tra session");
//		}
//		Clients clientId = userId.getClient();
//		if (clientId != null) {
//			System.out.println("id nguoi dung là: " + clientId);
//		} else {
////			System.out.println("clientid null");
////		}
//
//		Facility facility = facilitybooking.getFacility();
//		if (facility != null) {
//			System.out.println(" co facility");
//		} else {
//			System.out.println("khong co facility");
//		}
//		Facility facilityId = facilityService.getFacilityById(facility.getFacilityId());
//
//		// nếu số lượng khách là null hoặc <1 thì mặc định là 1
//		int turn = (facilitybooking.getNumberOf() != null && facilitybooking.getNumberOf() > 0)
//				? facilitybooking.getNumberOf()
//				: 1;
//		double totalAmount = facility.getServicePrice() * turn;
//		// tạo mã giao dịch để định danh cho giao dịch này
//		String vnp_TxnRef = VNPAYConfig.getRandomNumber(8);
//		FacilityBooking fcbooking = new FacilityBooking();
//
//		fcbooking.setFacility(facilityId);
//		fcbooking.setClientId(clientId);
//		fcbooking.setBookingDate(facilitybooking.getBookingDate());
//		fcbooking.setUsageTime(facility.getTimeapplyService());
//		fcbooking.setNumberOf(facilitybooking.getNumberOf());
//		fcbooking.setFacilityPrice(facility.getServicePrice());
//		fcbooking.setTotalPrice(facilitybooking.getTotalPrice());
//		fcbooking.setDatePayment(facilitybooking.getDatePayment());
//		fcbooking.setPaymentMethod(facilitybooking.getPaymentMethod());
//		fcbooking.setVnpTxnRef(facilitybooking.getVnpTxnRef());
//		fcbooking.setStatusPayment("Chờ thanh toán ");
//		fcbooking.setNotes(facilitybooking.getNotes());
//		facilityBookingService.saveFacilityBooking(fcbooking);
//		if ("VNPay".equals(facilitybooking.getPaymentMethod())) {
//			String orderInfo = "Thanh toan dich vu " + facility.getServiceName();
//			String paymentUrl = facilityBookingService.createVnPayUrl(totalAmount, orderInfo, vnp_TxnRef, req);
//			return "redirect:" + paymentUrl;
//		}
//		return "redirect:/success";
//	}
	@PostMapping("/confirm-Facilitybooking")
	public String handleBooking(HttpServletRequest req, @RequestParam("facilityId") int facilityId,
			FacilityBooking facilitybooking, HttpSession session) {

		Account currentUser = (Account) session.getAttribute("currentUser");
		if (currentUser == null) {
			return "redirect:/login";
		}

		User user = (User) session.getAttribute("userId");
		Clients clientId = currentUser.getUser().getClient();
		

		Facility facility = facilityService.getFacilityById(facilityId);
		if (facility == null) {
			throw new RuntimeException("Facility not found: " + facilityId);
		}

		int turn = (facilitybooking.getNumberOf() != null && facilitybooking.getNumberOf() > 0)
				? facilitybooking.getNumberOf()
				: 1;

		double totalAmount = facility.getServicePrice() * turn;

		String vnpTxnRef = "_Fac" + VNPAYConfig.getRandomNumber(8);

		FacilityBooking booking = new FacilityBooking();
		booking.setFacility(facility);
		booking.setClient(clientId);
		booking.setBookingDate(facilitybooking.getBookingDate());
		booking.setUsageTime(facilitybooking.getUsageTime());
		booking.setNumberOf(turn);
		booking.setFacilityName(facility.getServiceName());
		booking.setFacilityPrice(facility.getServicePrice());
		booking.setTotalPrice(totalAmount);
		booking.setPaymentMethod(facilitybooking.getPaymentMethod());
		booking.setStatusPayment("Chờ thanh toán");
		booking.setNotes(facilitybooking.getNotes());
		booking.setVnpTxnRef(vnpTxnRef);
		booking.setDatePayment(LocalDate.now());

		facilityBookingService.saveFacilityBooking(booking);

		if ("VNPAY".equals(facilitybooking.getPaymentMethod())) {
			String orderInfo = "Thanh toán dịch vụ " + facility.getServiceName();
			String paymentUrl = facilityBookingService.createVnPayUrl(totalAmount, orderInfo, vnpTxnRef, req);
			return "redirect:" + paymentUrl;
		}

		return "redirect:/success";
	}

}
