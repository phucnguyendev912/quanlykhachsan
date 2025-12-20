package com.example.Qlykhachsan.Config;

import java.util.Random;

import jakarta.servlet.http.HttpServletRequest;

public class VNPAYConfig {
	public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
	public static String vnp_ReturnUrl = "http://localhost:8080/vnpay-payment-return";
	public static String vnp_TmnCode = "T8P3O7J6";
	public static String vnp_HashSecret = "681FJJQQMW58HNOOQ3E35V8RPZMTV29Q";

	// Hàm lấy địa chỉ IP của khách hàng
	public static String getIpAddress(HttpServletRequest request) {
		String ipAdress;
		try {
			ipAdress = request.getHeader("X-FORWARDED-FOR");
			if (ipAdress == null) {
				// dung getRemoteAddr để lấy id trực tiếp
				ipAdress = request.getRemoteAddr();
			}
		} catch (Exception e) {
			ipAdress = "Invalid IP:" + e.getMessage();
		}
		return ipAdress;
	}

	// Hàm tạo mã giao dịch ngẫu nhiên
	public static String getRandomNumber(int len) {
		Random rnd = new Random();
		String chars = "0123456789";
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			sb.append(chars.charAt(rnd.nextInt(chars.length())));
		}
		return sb.toString();
	}
}
