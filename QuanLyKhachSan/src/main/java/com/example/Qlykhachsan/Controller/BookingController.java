package com.example.Qlykhachsan.Controller;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.RoomInfor;
import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Service.RoomInforService;
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
	private RoomInforService roomInforService;

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
	public String handleBooking(HttpServletRequest req, RoomInfor Booking, HttpSession session) throws Exception {
		Account currentUser = (Account) session.getAttribute("currentUser");
		if (currentUser == null) {
			return "redirect:/login";
		}
		// 1. Tính toán
		Rooms room = roomService.getRoomById(Booking.getRoomId());
		long nights = ChronoUnit.DAYS.between(Booking.getDateOrder().toLocalDate(),
				Booking.getDateCheckout().toLocalDate());
		if (nights <= 0)
			nights = 1;
		double totalAmount = room.getPriceRoom() * nights;
		// tạo mã giao dịch để định danh cho giao dịch này
		String vnp_TxnRef = VNPAYConfig.getRandomNumber(8);

		// 2. LƯU DATABASE
		RoomInfor booking = new RoomInfor();
		booking.setClientId(currentUser.getAccountId());
		booking.setRoomId(Booking.getRoomId());
		booking.setDateOrder(Booking.getDateOrder());
		booking.setDateCheckout(Booking.getDateCheckout());
		booking.setNumberOfclient(Booking.getNumberOfclient());
		booking.setRoomsPrice(room.getPriceRoom());
		booking.setTypeRooms(room.getTypeRoom());

		booking.setTotalPrice(totalAmount);
		booking.setPaymentMethod(Booking.getPaymentMethod());
		booking.setVnpTxnRef(vnp_TxnRef);
		booking.setStatusPayment("Chờ thanh toán");
		roomInforService.saveBooking(booking);

		// 3. TẠO URL VNPAY
		if ("VNPAY".equals(Booking.getPaymentMethod())) {
			Map<String, String> vnp_Params = new HashMap<>();
			vnp_Params.put("vnp_Version", "2.1.0");
			vnp_Params.put("vnp_Command", "pay");
			vnp_Params.put("vnp_TmnCode", VNPAYConfig.vnp_TmnCode);
			vnp_Params.put("vnp_Amount", String.valueOf((long) (totalAmount * 100)));
			vnp_Params.put("vnp_CurrCode", "VND");
			vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
			vnp_Params.put("vnp_OrderInfo", "Thanh toan phong " + room.getRoomNumber());
			vnp_Params.put("vnp_OrderType", "other");
			vnp_Params.put("vnp_Locale", "vn");
			vnp_Params.put("vnp_ReturnUrl", VNPAYConfig.vnp_ReturnUrl);
			vnp_Params.put("vnp_IpAddr", VNPAYConfig.getIpAddress(req));

			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			vnp_Params.put("vnp_CreateDate", formatter.format(new Date()));
			TimeZone tz = TimeZone.getTimeZone("Asia/Ho_Chi_Minh");
			Calendar cld = Calendar.getInstance(tz);
			cld.add(Calendar.MINUTE, 15);

			SimpleDateFormat expireFormatter = new SimpleDateFormat("yyyyMMddHHmmss");

			vnp_Params.put("vnp_ExpireDate", expireFormatter.format(cld.getTime()));

			// SẮP XẾP VÀ BĂM
			List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
			Collections.sort(fieldNames);

			StringBuilder hashData = new StringBuilder();
			StringBuilder query = new StringBuilder();

			for (String fieldName : fieldNames) {
				String fieldValue = vnp_Params.get(fieldName);

				if (fieldValue != null && fieldValue.length() > 0) {

					// HASH DATA — ENCODE (US_ASCII)
					hashData.append(fieldName).append('=')
							.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII)).append('&');

					// QUERY STRING — CŨNG ENCODE
					query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII)).append('=')
							.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII)).append('&');
				}
			}

			// XÓA & CUỐI
			hashData.deleteCharAt(hashData.length() - 1);
			query.deleteCharAt(query.length() - 1);

			// HASH
			String vnp_SecureHash = VNPayUtil.hmacSHA512(VNPAYConfig.vnp_HashSecret, hashData.toString());

			String paymentUrl = VNPAYConfig.vnp_PayUrl + "?" + query + "&vnp_SecureHash=" + vnp_SecureHash;

			return "redirect:" + paymentUrl;
		}
		return "redirect:/success";
	}
}