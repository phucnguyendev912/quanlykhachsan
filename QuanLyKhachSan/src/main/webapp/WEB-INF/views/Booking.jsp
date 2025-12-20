<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác nhận đặt phòng và Thanh toán</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
body {
	background-color: #f4f7f6;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.booking-container {
	max-width: 900px;
	margin: 50px auto;
}

.card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.room-summary {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 40px;
}

.payment-method {
	border: 2px solid #eee;
	border-radius: 10px;
	padding: 15px;
	cursor: pointer;
	transition: 0.3s;
}

.payment-method:hover {
	border-color: #667eea;
	background: #f8f9ff;
}

.total-price-box {
	background: #fff3f3;
	border: 1px dashed #e74c3c;
	border-radius: 10px;
	padding: 20px;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />

	<div class="container booking-container">
		<div class="card">
			<div class="row g-0">
				<div
					class="col-md-4 room-summary d-flex flex-column justify-content-center">
					<h3 class="fw-bold mb-4">Thông tin phòng</h3>

					<c:choose>
						<c:when test="${not empty room.image}">
							<img src="/${room.image}"
								class="img-fluid rounded mb-3 shadow-sm" alt="Hình ảnh phòng">
						</c:when>
						<c:otherwise>
							<img src="https://via.placeholder.com/300x200?text=No+Image"
								class="img-fluid rounded mb-3" alt="No Image">
						</c:otherwise>
					</c:choose>

					<h5 class="mb-2 fw-bold text-uppercase">${room.typeRoom}</h5>
					<p class="mb-1">
						<i class="fa-solid fa-door-open me-2"></i>Số phòng: <strong>${room.roomNumber}</strong>
					</p>

					<p class="mb-4" id="roomPriceDisplay"
						data-price="${room.priceRoom}">
						<i class="fa-solid fa-tag me-2"></i> <span class="fs-5 fw-bold">
							<fmt:formatNumber value="${room.priceRoom}" type="currency"
								currencySymbol="VNĐ" />
						</span> / đêm
					</p>
					<hr>
					<p class="small fst-italic">
						<i class="fa-solid fa-circle-info me-1"></i> Giá phòng đã bao gồm
						thuế và phí dịch vụ.
					</p>
				</div>

				<div class="col-md-8 p-5 bg-white">
					<h2 class="text-primary fw-bold mb-4">Chi tiết đặt phòng</h2>

					<form action="${pageContext.request.contextPath}/confirm-booking"
						method="post" id="bookingForm">
						<input type="hidden" name="roomId" value="${room.roomId}">

						<input type="hidden" name="totalPriceParam" id="hiddenTotalPrice">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label fw-bold">Ngày nhận phòng</label> <input
									type="date" name="dateOrder" id="checkIn" class="form-control"
									required>
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label fw-bold">Ngày trả phòng</label> <input
									type="date" name="dateCheckout" id="checkOut"
									class="form-control" required>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label fw-bold">Số lượng khách</label> <input
								type="number" name="numberOfclient" class="form-control" min="1"
								max="${room.numberOfclient}" value="1" required> <small
								class="text-muted"> <i
								class="fa-solid fa-user-group me-1"></i>Tối đa cho phép:
								${room.numberOfclient} người
							</small>
						</div>

						<div class="mb-4">
							<label class="form-label fw-bold">Phương thức thanh toán</label>
							<div class="row g-2">
								<div class="col-6">
									<input type="radio" class="btn-check" name="paymentMethod"
										id="payPal" value="PayPal" checked> <label
										class="btn btn-outline-primary w-100 py-3 shadow-sm"
										for="payPal"> <i
										class="fa-brands fa-paypal fa-lg me-2"></i> PayPal
									</label>
								</div>
								<div class="col-6">
									<input type="radio" class="btn-check" name="paymentMethod"
										id="vnpay" value="VNPAY"> <label
										class="btn btn-outline-primary w-100 py-3 shadow-sm"
										for="vnpay"> <i class="fa-solid fa-qrcode fa-lg me-2"></i>
										VNPay
									</label>
								</div>
							</div>
						</div>

						<div class="total-price-box mb-4">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<span class="text-muted">Tổng cộng (<span id="numNights"
										class="fw-bold">0</span> đêm)
									</span>
									<h3 class="text-danger fw-bold mb-0 mt-1" id="totalAmount">0
										VNĐ</h3>
								</div>
								<i class="fa-solid fa-receipt fa-3x text-danger opacity-25"></i>
							</div>
						</div>

						<button type="submit"
							class="btn btn-primary w-100 py-3 fw-bold fs-5 shadow-sm transition-all">
							<i class="fa-solid fa-check-circle me-2"></i>THANH TOÁN
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const checkInInput = document.getElementById('checkIn');
			const checkOutInput = document.getElementById('checkOut');
			const totalAmountEl = document.getElementById('totalAmount');
			const numNightsEl = document.getElementById('numNights');
			const hiddenTotalPrice = document
					.getElementById('hiddenTotalPrice');

			// Lấy giá tiền từ attribute data-price (an toàn hơn là chèn trực tiếp vào script)
			const basePrice = parseFloat(document.getElementById(
					'roomPriceDisplay').getAttribute('data-price'));

			// Thiết lập ngày tối thiểu là hôm nay
			const today = new Date().toISOString().split('T')[0];
			checkInInput.setAttribute('min', today);
			checkOutInput.setAttribute('min', today);

			function calculateTotal() {
				const checkInDate = new Date(checkInInput.value);
				const checkOutDate = new Date(checkOutInput.value);

				// Logic: Nếu đã chọn cả 2 ngày
				if (checkInInput.value && checkOutInput.value) {
					if (checkOutDate > checkInDate) {
						const diffTime = Math.abs(checkOutDate - checkInDate);
						const diffDays = Math.ceil(diffTime
								/ (1000 * 60 * 60 * 24));

						const total = diffDays * basePrice;

						// Cập nhật giao diện
						numNightsEl.innerText = diffDays;
						totalAmountEl.innerText = total.toLocaleString('vi-VN')
								+ " VNĐ";

						// Cập nhật hidden input (nếu cần gửi giá trị thô)
						hiddenTotalPrice.value = total;
					} else {
						// Nếu ngày trả phòng <= ngày nhận phòng (thường đã bị chặn bởi min attribute, nhưng check thêm cho chắc)
						numNightsEl.innerText = "0";
						totalAmountEl.innerText = "0 VNĐ";
					}
				}
			}

			// Sự kiện: Khi thay đổi ngày nhận phòng -> Cập nhật ngày tối thiểu của ngày trả phòng
			checkInInput.addEventListener('change', function() {
				if (this.value) {
					// Ngày trả phòng ít nhất phải là ngày hôm sau của ngày nhận phòng
					const nextDay = new Date(this.value);
					nextDay.setDate(nextDay.getDate() + 1);

					const nextDayString = nextDay.toISOString().split('T')[0];
					checkOutInput.setAttribute('min', nextDayString);

					// Nếu ngày trả phòng hiện tại nhỏ hơn ngày min mới -> reset
					if (checkOutInput.value
							&& checkOutInput.value < nextDayString) {
						checkOutInput.value = nextDayString;
					}
					calculateTotal();
				}
			});

			checkOutInput.addEventListener('change', calculateTotal);
		});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>