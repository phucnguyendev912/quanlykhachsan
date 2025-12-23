<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thanh Toán Dịch Vụ</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', sans-serif;
}

.booking-wrapper {
	max-width: 1000px;
	margin: 50px auto;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
	overflow: hidden; /* Bo góc cho cả khối */
}

/* --- CỘT TRÁI: THÔNG TIN DỊCH VỤ --- */
.left-panel {
	background-color: #7b61ff; /* Màu tím chủ đạo giống ảnh */
	background-image: linear-gradient(135deg, #7b61ff 0%, #5a4bce 100%);
	color: white;
	padding: 0;
	display: flex;
	flex-direction: column;
}

.left-header {
	padding: 20px;
	font-size: 1.4rem;
	font-weight: 700;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.service-img {
	width: 100%;
	height: 220px;
	object-fit: cover;
}

.service-details {
	padding: 20px;
	flex-grow: 1;
	background: #fff; /* Phần dưới ảnh để nền trắng cho dễ đọc text đen */
	color: #333;
}

.service-name {
	text-transform: uppercase;
	font-weight: 800;
	color: #5a4bce;
	margin-bottom: 10px;
}

.service-price {
	font-size: 1.5rem;
	font-weight: 700;
	color: #333;
}

.info-note {
	font-size: 0.85rem;
	color: #666;
	margin-top: 15px;
	font-style: italic;
}

/* --- CỘT PHẢI: FORM ĐẶT --- */
.right-panel {
	padding: 30px 40px;
}

.form-title {
	color: #0d6efd;
	font-weight: 700;
	margin-bottom: 25px;
}

/* Style cho nút chọn phương thức thanh toán */
.payment-btn-group {
	display: flex;
	gap: 15px;
}

.payment-option {
	flex: 1;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	padding: 10px;
	text-align: center;
	cursor: pointer;
	transition: all 0.2s;
	background: #fff;
	color: #555;
	font-weight: 600;
}

.payment-option:hover {
	border-color: #0d6efd;
	background-color: #f0f8ff;
}

.payment-option.active {
	border-color: #0d6efd;
	background-color: #0d6efd;
	color: #fff;
}

.payment-option i {
	margin-right: 5px;
	font-size: 1.1rem;
}

/* Khung tổng tiền màu hồng phấn */
.total-summary-box {
	background-color: #fff0f3; /* Màu hồng nhạt */
	border: 1px dashed #ff4d6d; /* Viền đứt màu đỏ hồng */
	border-radius: 8px;
	padding: 20px;
	margin: 25px 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.total-label {
	color: #666;
	font-size: 0.9rem;
}

.total-value {
	color: #d63384; /* Màu chữ đậm hơn */
	font-size: 1.8rem;
	font-weight: 800;
}

/* Nút thanh toán */
.btn-pay {
	background-color: #0d6efd;
	border: none;
	padding: 15px;
	font-size: 1.1rem;
	font-weight: 700;
	text-transform: uppercase;
	border-radius: 6px;
	width: 100%;
	transition: background 0.3s;
}

.btn-pay:hover {
	background-color: #0b5ed7;
}
</style>
</head>
<body>

	<div class="container">
		<div class="booking-wrapper row g-0">

			<div class="col-md-4 left-panel">
				<div class="left-header">Thông tin dịch vụ</div>
				<img
					src="https://phuquocxanh.com/wp-content/uploads/2019/12/spa-ha-noi.jpg"
					class="service-img" alt="Service">

				<div class="service-details">
					<h5 class="service-name">Massage Body Thụy Điển</h5>
					<div class="mb-2">
						<i class="bi bi-clock-history"></i> Thời lượng: <strong>60
							phút</strong>
					</div>
					<div class="mb-3">
						<i class="bi bi-people-fill"></i> Số phòng: <strong>VIP-01</strong>
					</div>

					<div class="service-price">
						500.000 VNĐ <span
							style="font-size: 0.9rem; font-weight: 400; color: #777;">/
							suất</span>
					</div>

					<div class="info-note">
						<i class="bi bi-info-circle-fill"></i> Giá dịch vụ đã bao gồm thuế
						VAT và phí phục vụ.
					</div>
				</div>
			</div>

			<div class="col-md-8 right-panel">
				<h3 class="form-title">Chi tiết đặt dịch vụ</h3>

				<form action="/confirm-Facilitybooking" method="post"
					id="bookingForm">
					<input type="hidden" name="facilityId"
						value="${service.facilityId}"> <input type="hidden"
						name="paymentMethod" id="selectedPaymentMethod" value="VNPAY">
					<input type="hidden" name="total_amount" id="hiddenTotal"
						value="500000"> <input type="hidden" name="status"
						value="Chờ thanh toán">

					<div class="row mb-3">
						<div class="col-md-6">
							<label class="form-label fw-bold">Ngày sử dụng</label> <input
								type="date" name="bookingDate" required>
						</div>
						<div class="col-md-6">
							<label class="form-label fw-bold">Khung giờ</label> <select
								class="form-select" name="usageTime" required>
								<option value="" disabled selected>-- Chọn giờ --</option>
								<option value="09:00 - 10:00">09:00 - 10:00</option>
								<option value="10:30 - 11:30">10:30 - 11:30</option>
								<option value="14:00 - 15:00">14:00 - 15:00</option>
								<option value="16:00 - 17:00">16:00 - 17:00</option>
								<option value="19:00 - 20:00">19:00 - 20:00</option>
							</select>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label fw-bold">Số lượng khách</label> <input
							type="number" class="form-control" name="numberOf" id="numberOf"
							value="1" min="1" max="10" onchange="updateTotal()"> <small
							class="text-muted"><i class="bi bi-people"></i> Tối đa
							cho phép: 10 người</small>
					</div>

					<div class="mb-3">
						<label class="form-label fw-bold">Ghi chú thêm</label>
						<textarea class="form-control" name="notes" rows="2"
							placeholder="Ví dụ: Dị ứng da, cần phòng đôi..."></textarea>
					</div>

					<label class="form-label fw-bold mt-2">Phương thức thanh
						toán</label>
					<div class="payment-btn-group mb-4">
						<div class="payment-option active"
							onclick="selectPayment(this, 'VNPAY')">
							<i class="bi bi-qr-code"></i> VNPay
						</div>
						<div class="payment-option"
							onclick="selectPayment(this, 'PAYPAL')">
							<i class="bi bi-paypal"></i> PayPal
						</div>
						<div class="payment-option" onclick="selectPayment(this, 'COD')">
							<i class="bi bi-cash-coin"></i> Tại Spa
						</div>
					</div>

					<div class="total-summary-box">
						<div>
							<div class="total-label">
								Tổng cộng (<span id="qtyLabel">1</span> khách)
							</div>
							<div class="text-muted" style="font-size: 0.8rem;">Vui lòng
								kiểm tra kỹ thông tin</div>
						</div>
						<div class="total-value" id="displayTotal">500.000 VNĐ</div>
						<i class="bi bi-receipt text-danger"
							style="font-size: 2rem; opacity: 0.5;"></i>
					</div>

					<button type="submit" class="btn btn-primary btn-pay">
						<i class="bi bi-check-circle-fill me-2"></i> Thanh Toán Ngay
					</button>
				</form>
			</div>
		</div>
	</div>

	<script>
    const basePrice = 500000;

    function updateTotal() {
        let qty = document.getElementById("quantity").value;
        if(qty < 1) { qty = 1; document.getElementById("quantity").value = 1; }
        
        let total = basePrice * qty;
        
        // Cập nhật text hiển thị
        document.getElementById("displayTotal").innerText = total.toLocaleString('vi-VN') + " VNĐ";
        document.getElementById("qtyLabel").innerText = qty;
        
        // Cập nhật vào input ẩn để gửi đi
        document.getElementById("hiddenTotal").value = total;
    }

    function selectPayment(element, methodValue) {
        // Xóa class active ở tất cả các nút
        let options = document.querySelectorAll('.payment-option');
        options.forEach(opt => opt.classList.remove('active'));
        
        // Thêm class active cho nút được chọn
        element.classList.add('active');
        
        // Cập nhật giá trị vào input ẩn
        document.getElementById("selectedPaymentMethod").value = methodValue;
    }
</script>

</body>
</html>