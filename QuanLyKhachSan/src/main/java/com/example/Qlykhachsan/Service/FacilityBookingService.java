package com.example.Qlykhachsan.Service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Config.VNPAYConfig;
import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Repository.FacilityBookingRepository;
import com.example.Qlykhachsan.util.VNPayUtil;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class FacilityBookingService {
	@Autowired
	private FacilityBookingRepository facilityBookingRepository;

	public FacilityBooking saveFacilityBooking(FacilityBooking facility) {
		return facilityBookingRepository.save(facility);
	}

	public FacilityBooking findByVnpTxnRef(String VnpTxnRef) {
		return facilityBookingRepository.findByVnpTxnRef(VnpTxnRef);
	}

	public FacilityBooking getOrderById(Integer serviceBookingId) {
		Optional<FacilityBooking> lst = facilityBookingRepository.findById(serviceBookingId);
		return lst.orElse(null);
	}

	public String createVnPayUrl(double totalAmount, String orderInfor, String vnp_TxnRef, HttpServletRequest req) {
		String vnp_Version = "2.1.0";
		String vnp_Command = "pay";
		String vnp_OrderType = "other";

		// Đổi đơn vị tiền tệ
		long amount = (long) (totalAmount * 100);

		String vnp_IpAddr = VNPAYConfig.getIpAddress(req);
		String vnp_TmnCode = VNPAYConfig.vnp_TmnCode;

		Map<String, String> vnp_Params = new HashMap<>();
		vnp_Params.put("vnp_Version", vnp_Version);
		vnp_Params.put("vnp_Command", vnp_Command);
		vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
		vnp_Params.put("vnp_Amount", String.valueOf(amount));
		vnp_Params.put("vnp_CurrCode", "VND");
		vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
		vnp_Params.put("vnp_OrderInfo", orderInfor);
		vnp_Params.put("vnp_OrderType", vnp_OrderType);
		vnp_Params.put("vnp_Locale", "vn");

		// Return Url: Địa chỉ web để VNPay gọi lại khi xong
		vnp_Params.put("vnp_ReturnUrl", VNPAYConfig.vnp_ReturnUrl);
		vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

		Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String vnp_CreateDate = formatter.format(cld.getTime());
		vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

		cld.add(Calendar.MINUTE, 15);
		String vnp_ExpireDate = formatter.format(cld.getTime());
		vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

		List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
		Collections.sort(fieldNames);

		StringBuilder hashData = new StringBuilder();
		StringBuilder query = new StringBuilder();

		Iterator<String> itr = fieldNames.iterator();
		while (itr.hasNext()) {
			String fieldName = itr.next();
			String fieldValue = vnp_Params.get(fieldName);
			if ((fieldValue != null) && (fieldValue.length() > 0)) {
				// Build hash data
				hashData.append(fieldName);
				hashData.append('=');
				try {
					hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
					// Build query
					query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
					query.append('=');
					query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
				} catch (Exception e) {
					e.printStackTrace();
				}

				if (itr.hasNext()) {
					query.append('&');
					hashData.append('&');
				}
			}
		}

		String queryUrl = query.toString();
		// Tạo chữ ký bảo mật
		String vnp_SecureHash = VNPayUtil.hmacSHA512(VNPAYConfig.vnp_HashSecret, hashData.toString());
		queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;

		// Trả về đường dẫn thanh toán hoàn chỉnh
		return VNPAYConfig.vnp_PayUrl + "?" + queryUrl;
	}
}
