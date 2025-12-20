package com.example.Qlykhachsan.util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import com.example.Qlykhachsan.Config.VNPAYConfig;

import java.nio.charset.StandardCharsets;
import java.util.*;

public class VNPayUtil {
// luồng chạy của hàm
	/*
	 * gom tất cả thông tin đơn hàng(mã đơn...) thành một chuỗi dài (data) Sau đó
	 * đưa chuỗi vào khóa bí mật là vpn_hashSecret) hàm trả về 1 chuỗi mã hóa Sau đó
	 * gửi chuỗi đó kèm theo url cho VNPay VNPay sẽ dùng khóa bí mật đã cấp để băm
	 * lại dữ liệu đã được gửi sang , nếu chuỗi của VNPay khớp với chuỗi được gửi
	 * sang thì dữ liệu an toán
	 */
	public static String hmacSHA512(final String key, final String data) {
		try {
			// yeu cầu cung cấp thuật toán dùng hàm băm sha-512
			Mac hmac512 = Mac.getInstance("HmacSHA512");
			// khởi tạo khóa bí mật
			SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
			// đưa khóa bí mật vào thuật toán băm
			hmac512.init(secretKey);
			// thực hiện băm
			// chuyển dữ liệu về dạng byte , và thực hiện tính toán băm
			byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
			// chuyển sang chuỗi hex, biến ngôn ngữ băm thành một chuỗi kí tự sạch và đẹp
			StringBuilder hash = new StringBuilder(bytes.length * 2);
			for (byte b : bytes) {
				// Định dạng mỗi byte thành 2 ký tự hex viết thường
				hash.append(String.format("%02x", b & 0xff));
			}
			return hash.toString();
		} catch (Exception e) {
			throw new RuntimeException("Error while hashing with HmacSHA512", e);
		}
	}

	public static String buildHashData(Map<String, String> params) {

		List<String> fieldNames = new ArrayList<>(params.keySet());
		// Collections
		// sắp xếp danh sách tham số theo bảng chữ cái
		Collections.sort(fieldNames);
		// nói chuỗi
		StringBuilder hashData = new StringBuilder();
		// Iterator: dùng để duyệt collection
		// Tạo 1 con trỏ kiểu string để trỏ qua các phần tử trong danh sách đã được sắp
		// xếp
		Iterator<String> itr = fieldNames.iterator();

		while (itr.hasNext()) {
			// Lấy tên tham số hiện tại
			String fieldName = itr.next();
			// lấy ra giá trị tương ứng với mỗi tham số
			String fieldValue = params.get(fieldName);

			if (fieldValue != null && fieldValue.length() > 0 && !fieldName.equals("vnp_SecureHash")
					&& !fieldName.equals("vnp_SecureHashType")) {
				// nối tên và giá trị vào chuỗi
				hashData.append(fieldName).append('=').append(fieldValue);

				if (itr.hasNext()) {
					// nếu còn tham số ở sau thì thêm & để ngăn cách
					hashData.append('&');
				}
			}
		}
		return hashData.toString();
	}

	// Hàm tạo chữ kí
	public static boolean verifySignature(Map<String, String> params) {
		String vnp_SecureHash = params.get("vnp_SecureHash");
		String hashData = buildHashData(params);
		String myHash = hmacSHA512(VNPAYConfig.vnp_HashSecret, hashData);
		return myHash.equalsIgnoreCase(vnp_SecureHash);
	}
}
