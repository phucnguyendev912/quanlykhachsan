package com.example.Qlykhachsan.Controller;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Repository.ClientRepository;
import com.example.Qlykhachsan.Service.ClientService;
import com.example.Qlykhachsan.Service.RoomBookingService;
import com.example.Qlykhachsan.Service.RoomService;
import com.example.Qlykhachsan.util.VNPayUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Controller
public class BookingController {

	@Autowired
	private RoomService roomService;

	@Autowired
	private RoomBookingService roombookingrService;

	@Autowired
	private ClientService clientService;

	@GetMapping("/booking-details/{id}")
	public String showBookingDetails(@PathVariable("id") Integer id, Model model, HttpSession session) {

		Account acc = (Account) session.getAttribute("currentUser");
		if (acc == null) {
			return "redirect:/login";
		}
		// 1. Lấy thông tin phòng dựa trên ID từ URL
		Rooms room = roomService.getRoomById(id);
		System.out.println(room.getImage());
		model.addAttribute("room", room);

		return "Booking";
	}

	@PostMapping("/confirm-booking")
	public String handleBooking(HttpServletRequest req, RoomBooking Booking, HttpSession session,
			@RequestParam(value = "usePoint", defaultValue = "false") boolean usePoint) throws Exception {
		Account currentUser = (Account) session.getAttribute("currentUser");
		if (currentUser == null) {
			return "redirect:/login";
		}

		Clients clientId = currentUser.getUser().getClient();

		// tinh gia cua phong theo ngay dem

		Rooms room = roomService.getRoomById(Booking.getRoomId());
		long nights = ChronoUnit.DAYS.between(Booking.getDateOrder().toLocalDate(),
				Booking.getDateCheckout().toLocalDate());
		if (nights <= 0)
			nights = 1;
		double totalAmount = room.getPriceRoom() * nights;
		double finalPrice = totalAmount;
		int pointUsed = 0;
		if (usePoint && clientId.getPoint() > 0) {
			long maxDiscount = clientId.getPoint() * 1000L;// quy doi diem
			// neu ma du diem de thanh toan het so phong thi giam gia phong ve 0
			if (maxDiscount >= totalAmount) {
				finalPrice = 0;
				pointUsed = (int) (totalAmount / 1000);
			} else {
				// neu khong du diem thi se tru het diem
				finalPrice = totalAmount - maxDiscount;
				pointUsed = clientId.getPoint();
			}
		}
		// tạo mã giao dịch để định danh cho giao dịch này
		String vnp_TxnRef = "_Room" + VNPAYConfig.getRandomNumber(8);

		// 2. LƯU DATABASE
		RoomBooking booking = new RoomBooking();
		booking.setClientId(clientId);
		booking.setRoomId(Booking.getRoomId());
		booking.setDateOrder(Booking.getDateOrder());
		booking.setDateCheckout(Booking.getDateCheckout());
		booking.setNumberOfclient(Booking.getNumberOfclient());
		booking.setRoomsPrice(room.getPriceRoom());
		booking.setName(Booking.getName());
		booking.setPhoneNumber(Booking.getPhoneNumber());
		booking.setTypeRooms(room.getTypeRoom());
		booking.setRoomNumber(Booking.getRoomNumber());
		booking.setDatePayment(LocalDate.now());
		booking.setTotalPrice(finalPrice);
		booking.setPaymentMethod(Booking.getPaymentMethod());
		booking.setStatusBooking("Chưa check in ");
		booking.setVnpTxnRef(vnp_TxnRef);
		if (finalPrice <= 0) {
			booking.setStatusPayment("Đã thanh toán(Dùng điểm)");
		} else {
			booking.setStatusPayment("Chờ thanh toán");
		}

		roombookingrService.saveBooking(booking);

		// 3. TẠO URL VNPAY
		if ("VNPAY".equals(Booking.getPaymentMethod()) && finalPrice > 0) {

			// Chuẩn bị thông tin
			String orderInfo = "Thanh toan phong " + room.getRoomNumber();

			// Gọi Service
			String paymentUrl = roombookingrService.createVnPayUrl((long) finalPrice, orderInfo, vnp_TxnRef, req);

			return "redirect:" + paymentUrl;
		} else {
			clientService.deductPoint(clientId, pointUsed);
			currentUser.getUser().getClient().setPoint(clientId.getPoint() - pointUsed);
			session.setAttribute("currentUser", currentUser);
			return "redirect:/BookingHistoryController";
		}

	}
}