package com.example.Qlykhachsan.Controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.RoomInfor;
import com.example.Qlykhachsan.Repository.RoomInfoRepository;
import com.example.Qlykhachsan.Service.RoomInforService;
import com.example.Qlykhachsan.util.VNPayUtil;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class VNPayReturnController {
	@Autowired
	private RoomInforService roomoInforService;

	@GetMapping("/vnpay-payment-return")
	public String vnpayReturn(HttpServletRequest request, Model model) {

		Map<String, String> vnp_Params = new HashMap<>();

		request.getParameterMap().forEach((key, value) -> {
			if (value.length > 0) {
				vnp_Params.put(key, value[0]);
			}
		});

		// LẤY SECURE HASH VNPAY TRẢ VỀ
		String vnp_SecureHash = vnp_Params.remove("vnp_SecureHash");

		// XÓA CÁC FIELD KHÔNG HASH
		vnp_Params.remove("vnp_SecureHashType");

		// SẮP XẾP
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

		// TÍNH LẠI HASH
		String signValue = VNPayUtil.hmacSHA512(VNPAYConfig.vnp_HashSecret, hashData.toString());

		// KIỂM TRA KẾT QUẢ
		if (signValue.equals(vnp_SecureHash)) {

			String responseCode = vnp_Params.get("vnp_ResponseCode");

			if ("00".equals(responseCode)) {

				String vnp_TxnRef = vnp_Params.get("vnp_TxnRef");
				String vnp_BankCode = vnp_Params.get("vnp_BankCode");
				String vnp_Amount = vnp_Params.get("vnp_Amount");
				RoomInfor roomif = roomoInforService.getByTxnRef(vnp_TxnRef);
				if (roomif != null) {
					roomif.setStatusPayment("Đã thanh toán");
					roomoInforService.saveBooking(roomif);
					System.out.println("Cập nhật thành công đơn hàng: " + vnp_TxnRef);
				} else {
					System.out.println("Không tìm thấy đơn hàng với mã: " + vnp_TxnRef);
				}
				long amount = Long.parseLong(vnp_Amount) / 100;

				model.addAttribute("vnp_TxnRef", vnp_TxnRef);
				model.addAttribute("amount", amount);
				model.addAttribute("vnp_BankCode", vnp_BankCode);

				return "payment-success";

			} else {
				model.addAttribute("message", "Thanh toán thất bại");
				return "payment-fail";
			}

		} else {
			model.addAttribute("message", "Sai chữ ký");
			return "payment-fail";
		}
	}
}
