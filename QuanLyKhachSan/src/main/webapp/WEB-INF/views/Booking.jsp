<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác nhận đặt phòng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="/css/Booking.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="Header.jsp" />

	<div class="container booking-container">
		<div class="card">
			<div class="row g-0">
				<div class="col-md-4 room-summary d-flex flex-column">

					<h3 class="fw-bold mb-4">Thông tin phòng</h3>



					<img src="/${room.image}" class="img" alt="Hình ảnh phòng">
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
						<input type="hidden" name="roomNumber" value="${room.roomNumber}">
						<input type="hidden" name="totalPriceParam" id="hiddenTotalPrice">

						<div class="col-md-6 mb-3">
							<label class="form-label fw-bold">Họ và tên</label> <input
								type="text" name="name" class="form-control"
								value=""
								placeholder="Nhập họ tên người nhận phòng" required>
						</div>
						<div class="col-md-6 mb-3">
							<label class="form-label fw-bold">Số điện thoại</label> <input
								type="tel" name="phoneNumber" class="form-control"
								value=""
								placeholder="Nhập số điện thoại liên hệ" required>
						</div>
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

						<c:if test="${not empty sessionScope.currentUser}">
							<div class="card p-3 mb-3 bg-light border-warning">
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<h6 class="fw-bold text-warning mb-1">
											<i class="fa-solid fa-coins"></i> Điểm tích lũy của bạn
										</h6>
										<small>Bạn đang có: <strong id="userPoints"
											data-points="${sessionScope.currentUser.user.client.point}">
												<fmt:formatNumber
													value="${sessionScope.currentUser.user.client.point}"
													type="number" />
										</strong> điểm
										</small>
									</div>

									<div class="form-check form-switch">
										<input class="form-check-input" type="checkbox" id="usePoint"
											name="usePoint" value="true"> <label
											class="form-check-label fw-bold" for="usePoint"> Dùng
											điểm giảm giá </label>
									</div>
								</div>

								<div id="discountInfo" class="mt-2 text-success"
									style="display: none;">
									<i class="fa-solid fa-check"></i> Sẽ trừ <strong><fmt:formatNumber
											value="${sessionScope.currentUser.user.client.point * 1000}" />
										VNĐ</strong> vào hóa đơn.
								</div>
							</div>
						</c:if>
						<div class="mb-4">
							<label class="form-label fw-bold">Phương thức thanh toán</label>
							<div class="row g-2">
								
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

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/Booking.js"></script>

	<script>
		
	</script>
</body>
</html>