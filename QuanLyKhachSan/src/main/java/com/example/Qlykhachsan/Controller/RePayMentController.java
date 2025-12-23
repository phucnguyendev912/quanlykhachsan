package com.example.Qlykhachsan.Controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Service.RoomBookingService;
import com.example.Qlykhachsan.Service.RoomService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RePayMentController {

	@Autowired
	private RoomBookingService roomBookingService; // Service này phải có hàm createVnPayUrl mà mình đã tạo ở bước trước



	@GetMapping("/retry-payment/{bookingId}")
	public String retypayment(@PathVariable("bookingId") Integer bookingId, HttpServletRequest req,
			HttpSession session) {

		// 1. Lấy thông tin đơn hàng từ DB (Dùng bookingId từ URL)
		RoomBooking booking = roomBookingService.getOrderById(bookingId);

		// 2. Kiểm tra null hoặc trạng thái
		if (booking == null) {
			return "redirect:/error";
		}
		if ("Canceled".equals(booking.getStatusPayment())) {
			return "booking-error"; // Trả về trang báo lỗi nếu đơn đã hủy
		}
		if ("Đã thanh toán".equals(booking.getStatusPayment())) {
			return "redirect:/success";
		}

		// 3. Tạo Mã giao dịch MỚI (Bắt buộc khi thanh toán lại để tránh lỗi trùng lặp
		// bên VNPay)
		String vnp_TxnRef = VNPAYConfig.getRandomNumber(8);

		// 4. QUAN TRỌNG: Cập nhật mã giao dịch mới vào Database
		// Nếu không có dòng này, khi VNPay trả về bạn sẽ không tìm thấy đơn hàng khớp
		booking.setVnpTxnRef(vnp_TxnRef);

		// Reset ngày tạo để Scheduler không hủy đơn (nếu có logic timeout)
		booking.setDatePayment(LocalDate.now());

		// Lưu lại thay đổi vào DB
		roomBookingService.saveBooking(booking);

		// 5. Lấy số tiền (Nên lấy từ Booking đã lưu thay vì tính lại để tránh sai lệch)
		double totalAmount = booking.getTotalPrice();
		String orderInfo = "Thanh toan lai phong don hang " + bookingId;

		// 6. Gọi hàm tạo URL từ Service (Hàm này bạn đã viết ở bước trước)
		String newPaymentUrl = roomBookingService.createVnPayUrl(totalAmount, orderInfo, vnp_TxnRef, req);

		// 7. Chuyển hướng sang VNPay
		return "redirect:" + newPaymentUrl;
	}

}
