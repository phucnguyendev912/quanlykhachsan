package com.example.Qlykhachsan.Controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Model.RoomBooking;

import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Repository.ClientRepository;
import com.example.Qlykhachsan.Repository.FacilityBookingRepository;
import com.example.Qlykhachsan.Service.FacilityBookingService;
import com.example.Qlykhachsan.Service.FacilityService;
import com.example.Qlykhachsan.Service.RoomBookingService;
import com.example.Qlykhachsan.Service.RoomService;
import com.example.Qlykhachsan.util.VNPayUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class VNPayReturnController {
	@Autowired
	private RoomBookingService roomoInforService;
	@Autowired
	private RoomService roomService;
	@Autowired
	private ClientRepository clientRepository;
	@Autowired
	private FacilityBookingService facilityBookingService;

//	@GetMapping("/vnpay-payment-return")
//	public String vnpayReturn(HttpServletRequest request, Model model) {
//
//		Map<String, String> vnp_Params = new HashMap<>();
//
//		request.getParameterMap().forEach((key, value) -> {
//			if (value.length > 0) {
//				vnp_Params.put(key, value[0]);
//			}
//		});
//
//		// LẤY SECURE HASH VNPAY TRẢ VỀ
//		String vnp_SecureHash = vnp_Params.remove("vnp_SecureHash");
//
//		// XÓA CÁC FIELD KHÔNG HASH
//		vnp_Params.remove("vnp_SecureHashType");
//
//		// SẮP XẾP
//		List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
//		Collections.sort(fieldNames);
//
//		StringBuilder hashData = new StringBuilder();
//		for (String fieldName : fieldNames) {
//			String fieldValue = vnp_Params.get(fieldName);
//			if (fieldValue != null && !fieldValue.isEmpty()) {
//				hashData.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII))
//						.append("&");
//			}
//		}
//		hashData.deleteCharAt(hashData.length() - 1);
//
//		String signValue = VNPayUtil.hmacSHA512(VNPAYConfig.vnp_HashSecret, hashData.toString());
//
//		// KIỂM TRA KẾT QUẢ
//		if (signValue.equals(vnp_SecureHash)) {
//
//			String responseCode = vnp_Params.get("vnp_ResponseCode");
//
//			if ("00".equals(responseCode)) {
//
//				String vnp_TxnRef = vnp_Params.get("vnp_TxnRef");
//				String vnp_BankCode = vnp_Params.get("vnp_BankCode");
//				String vnp_Amount = vnp_Params.get("vnp_Amount");
//				RoomBooking roomif = roomoInforService.getByTxnRef(vnp_TxnRef);
//				if (roomif != null) {
//					roomif.setStatusPayment("Đã thanh toán");
//					roomoInforService.saveBooking(roomif);
//					System.out.println("Cập nhật thành công đơn hàng: " + vnp_TxnRef);
//				} else {
//					System.out.println("Không tìm thấy đơn hàng với mã: " + vnp_TxnRef);
//				}
//				int roomId = roomif.getRoomId();
//				Rooms room = roomService.getRoomById(roomId);
//				if (room != null) {
//					room.setStatusroom("Đã đặt");
//					roomService.save(room);
//				}
//				long amount = Long.parseLong(vnp_Amount) / 100;
//
//				model.addAttribute("vnp_TxnRef", vnp_TxnRef);
//				model.addAttribute("amount", amount);
//				model.addAttribute("vnp_BankCode", vnp_BankCode);
//
//				return "payment-success";
//
//			} else {
//				model.addAttribute("message", "Thanh toán thất bại");
//				return "payment-fail";
//			}
//
//		} else {
//			model.addAttribute("message", "Sai chữ ký");
//			return "payment-fail";
//		}
//	}
	@GetMapping("/vnpay-payment-return")
	public String vnpayReturn(HttpServletRequest request, Model model, HttpSession session) {

		Map<String, String> vnp_Params = new HashMap<>();
		request.getParameterMap().forEach((key, value) -> {
			if (value.length > 0) {
				vnp_Params.put(key, value[0]);
			}
		});

		String vnp_SecureHash = vnp_Params.remove("vnp_SecureHash");
		vnp_Params.remove("vnp_SecureHashType");

		List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
		Collections.sort(fieldNames);

		StringBuilder hashData = new StringBuilder();
		for (String fieldName : fieldNames) {
			String fieldValue = vnp_Params.get(fieldName);
			if (fieldValue != null && !fieldValue.isEmpty()) {
				hashData.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII))
						.append("&");
			}
		}
		hashData.deleteCharAt(hashData.length() - 1);

		String signValue = VNPayUtil.hmacSHA512(VNPAYConfig.vnp_HashSecret, hashData.toString());

		if (!signValue.equals(vnp_SecureHash)) {
			model.addAttribute("message", "Sai chữ ký VNPay");
			return "payment-fail";
		}

		if (!"00".equals(vnp_Params.get("vnp_ResponseCode"))) {
			model.addAttribute("message", "Thanh toán thất bại");
			return "payment-fail";
		}

		String vnp_TxnRef = vnp_Params.get("vnp_TxnRef");
		String vnp_BankCode = vnp_Params.get("vnp_BankCode");
		long amount = Long.parseLong(vnp_Params.get("vnp_Amount")) / 100;
		int pointsToAdd = 0;
		Clients clientToUpdate = null;
		if (vnp_TxnRef.startsWith("_Room")) {
			RoomBooking room = roomoInforService.getByTxnRef(vnp_TxnRef);
			if (room != null) {
				room.setStatusPayment("Đã thanh toán");
				roomoInforService.saveBooking(room);
				if (room.getPointsUsed() > 0) {
					Clients clients = room.getClientId();
					clients.setPoint(clients.getPoint() - room.getPointsUsed());
					if (clients.getPoint() < 0) {
						clients.setPoint(0);
					}
					clientRepository.save(clients);
				}
				clientToUpdate = room.getClientId();
				Rooms r = roomService.getRoomById(room.getRoomId());
				if (r != null) {
					r.setStatusroom("Đã đặt");
					roomService.save(r);
				}
				if (!room.isPointRewarded() && room.getPointsUsed() == 0) {
					pointsToAdd = (int) (amount / 100000);
					room.setPointRewarded(true);
					roomoInforService.saveBooking(room);
				}

			}
		}

		if (vnp_TxnRef.startsWith("_Fac")) {
			FacilityBooking fb = facilityBookingService.findByVnpTxnRef(vnp_TxnRef);
			if (fb != null) {
				fb.setStatusPayment("Đã thanh toán");
				facilityBookingService.saveFacilityBooking(fb);
				clientToUpdate = fb.getClient();
			}
		}
		if (clientToUpdate != null && pointsToAdd > 0) {

			clientToUpdate.setPoint(clientToUpdate.getPoint() + pointsToAdd);
			clientRepository.save(clientToUpdate);
			Account currentUser = (Account) session.getAttribute("currentUser");
			if (currentUser != null
					&& currentUser.getUser().getClient().getClientId() == clientToUpdate.getClientId()) {
				currentUser.getUser().setClient(clientToUpdate);
				session.setAttribute("currentUser", currentUser);
			}
		}

		model.addAttribute("vnp_TxnRef", vnp_TxnRef);
		model.addAttribute("amount", amount);
		model.addAttribute("vnp_BankCode", vnp_BankCode);
		return "payment-success";
	}

}
