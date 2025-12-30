package com.example.Qlykhachsan.Controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Dto.BookingHistory;
import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Service.FacilityBookingService;
import com.example.Qlykhachsan.Service.RoomBookingService;
import com.example.Qlykhachsan.Service.RoomService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RePayMentController {

	@Autowired
	private RoomBookingService roomBookingService;

	// Service này phải có hàm createVnPayUrl mà mình đã tạo ở bước trước
	@Autowired
	private FacilityBookingService facilityBookingService;

	@GetMapping("/retry-payment/{bookingId}")
	public String retypaymentroom(@PathVariable("bookingId") Integer bookingId, HttpServletRequest req,
			HttpSession session) {

		// 1. Lấy thông tin đơn hàng từ DB
		RoomBooking booking = roomBookingService.getOrderById(bookingId);

		// 3. Tạo Mã giao dịch MỚI
		String vnp_TxnRef = "_Room" + VNPAYConfig.getRandomNumber(8);

		booking.setVnpTxnRef(vnp_TxnRef);
		booking.setStatusPayment("Đã thanh toán");

		// Reset ngày tạo để Scheduler không hủy đơn
		booking.setDatePayment(LocalDate.now());

		// Lưu lại thay đổi vào DB
		roomBookingService.saveBooking(booking);

		// 5. Lấy số tiền
		double totalAmount = booking.getTotalPrice();
		String orderInfo = "Thanh toan lai phong don hang " + bookingId;

		// 6. Gọi hàm tạo URL từ Service
		String newPaymentUrl = roomBookingService.createVnPayUrl(totalAmount, orderInfo, vnp_TxnRef, req);

		// 7. Chuyển hướng sang VNPay
		return "redirect:" + newPaymentUrl;
	}

	@GetMapping("/retry-payment-facility/{bookingId}")
	public String retryPaymentFacility(@PathVariable("bookingId") Integer bookingId, HttpServletRequest req,
			HttpSession session) {

		// 1. Lấy thông tin đơn hàng từ DB
		FacilityBooking fcbooking = facilityBookingService.getOrderById(bookingId);

		// 3. Tạo Mã giao dịch MỚI
		String vnp_TxnRef = "_Fac" + VNPAYConfig.getRandomNumber(8);
		fcbooking.setVnpTxnRef(vnp_TxnRef);
		fcbooking.setStatusPayment("Đã thanh toán");
		// Reset ngày tạo để Scheduler không hủy đơn
		fcbooking.setDatePayment(LocalDate.now());
		// Lưu lại thay đổi vào DB
		facilityBookingService.saveFacilityBooking(fcbooking);
		// 5. Lấy số tiền
		double totalAmount = fcbooking.getTotalPrice();
		String orderInfo = "Thanh toan lai dich vu " + bookingId;
		// 6. Gọi hàm tạo URL từ Service
		String newPaymentUrl = roomBookingService.createVnPayUrl(totalAmount, orderInfo, vnp_TxnRef, req);
		// 7. Chuyển hướng sang VNPay
		return "redirect:" + newPaymentUrl;
	}

}
