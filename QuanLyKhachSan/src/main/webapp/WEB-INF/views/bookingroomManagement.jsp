<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản Lý Đặt Phòng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
/* CSS chỉnh lại màu badge trạng thái */
.badge-paid {
	background-color: #198754;
} /* Màu xanh lá - Đã thanh toán */
.badge-pending {
	background-color: #ffc107;
	color: #000;
} /* Vàng - Chờ thanh toán */
.badge-cancel {
	background-color: #dc3545;
} /* Đỏ - Đã hủy */
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<c:set var="activePage" value="bookings" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Danh sách Đặt phòng</h1>
				</div>

				<div class="card shadow-sm">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover align-middle">
								<thead class="table-dark">
									<tr>
										<th>#ID</th>
										<th>Khách hàng</th>
										<th>Phòng / Loại</th>
										<th>Check-in</th>
										<th>Check-out</th>
										<th>Tổng tiền</th>
										<th>Trạng thái</th>
										<th class="text-center" style="min-width: 150px;">Hành
											động</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="b" items="${lstroombooking}">
										<tr>
											<td><strong>${b.roominfoId}</strong></td>

											<td> ${b.clientId.clientId}</td>

											<td>
												<div class="fw-bold">${b.typeRooms}</div> <small
												class="text-muted">Phòng số: ${b.roomId}</small>
											</td>

											<td>${b.dateOrder}</td>
											<td>${b.dateCheckout}</td>

											<td class="fw-bold text-primary"><fmt:formatNumber
													value="${b.totalPrice}" type="currency" currencySymbol="₫" />
											</td>

											<td><c:choose>
													<c:when test="${b.statusPayment == 'Đã thanh toán'}">
														<span class="badge badge-paid">Đã thanh toán</span>
													</c:when>
													<c:when test="${b.statusPayment == 'Chờ thanh toán'}">
														<span class="badge badge-pending">Chờ thanh toán</span>
													</c:when>
													<c:otherwise>
														<span class="badge badge-cancel">${b.statusPayment}</span>
													</c:otherwise>
												</c:choose></td>

											<td class="text-center">
												<button type="button"
													class="btn btn-info btn-sm text-white btn-view-detail"
													data-bs-toggle="modal" data-bs-target="#detailModal"
													data-id="${b.roominfoId}" data-vnpay="${b.vnpTxnRef}"
													data-method="${b.paymentMethod}"
													data-datepay="${b.datePayment}"
													data-points="${b.pointsUsed}"
													data-price-per-room="${b.roomsPrice}"
													data-statusBooking="${b.statusBooking}"
													data-num-client="${b.numberOfclient}" title="Xem chi tiết">
													<i class="fas fa-eye"></i>
												</button> <c:if
													test="${b.statusPayment != 'Đã hủy' && b.statusPayment != 'Đã trả phòng'}">
													<a href="/checkin?id=${b.roominfoId}"
														class="btn btn-warning btn-sm ms-1"
														title="Check-in khách"
														onclick="return confirm('Xác nhận làm thủ tục nhận phòng (Check-in) cho phòng ${b.roomId}?')">
														<i class="fa-solid fa-key"></i>
													</a>
													<a href="/checkout?id=${b.roominfoId}"
														class="btn btn-warning btn-sm ms-1"
														title="Check-out khách"
														onclick="return confirm('Xác nhận làm thủ tục trả phòng (Check-out) cho phòng ${b.roomId}?')">
														<i class="fa-solid fa-right-from-bracket"></i>
													</a>
													
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<div class="modal fade" id="detailModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title">
						Chi tiết đơn đặt phòng #<span id="modalBookingId"></span>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<ul class="list-group list-group-flush">
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Mã giao dịch (VNPAY): <strong id="modalVnpay"
							class="text-primary"></strong>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Phương thức thanh toán: <strong id="modalMethod"></strong>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Thời gian thanh toán: <strong id="modalDatePay"></strong>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Giá gốc phòng (1 đêm): <strong id="modalPriceRoom"></strong>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Trạng thái đặt phòng: <strong id="modalstatusBooking"></strong>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Số lượng khách: <strong id="modalNumClient"></strong>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							Điểm tích lũy sử dụng: <span
							class="badge bg-secondary rounded-pill" id="modalPoints"></span>
						</li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        // Lắng nghe sự kiện khi Modal chuẩn bị hiện lên
        const detailModal = document.getElementById('detailModal');
        detailModal.addEventListener('show.bs.modal', event => {
            // Nút nào đã kích hoạt modal?
            const button = event.relatedTarget;
            
            // Lấy dữ liệu từ các thuộc tính data- (data attributes) của nút đó
            const id = button.getAttribute('data-id');
            const vnpay = button.getAttribute('data-vnpay');
            const method = button.getAttribute('data-method');
            const datepay = button.getAttribute('data-datepay');
            const points = button.getAttribute('data-points');
            const priceRoom = button.getAttribute('data-price-per-room'); // Đang là số thô
            const statusBooking=button.getAttribute('data-statusBooking');
            const numClient = button.getAttribute('data-num-client');

            // Format lại tiền tệ cho đẹp (VND)
            const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });
            const formattedPrice = priceRoom ? formatter.format(priceRoom) : '0 ₫';

            // Điền dữ liệu vào các thẻ trong Modal
            document.getElementById('modalBookingId').textContent = id;
            document.getElementById('modalVnpay').textContent = vnpay || 'Không có';
            document.getElementById('modalMethod').textContent = method;
            document.getElementById('modalDatePay').textContent = datepay || 'Chưa thanh toán';
            document.getElementById('modalPriceRoom').textContent = formattedPrice;
            document.getElementById('modalNumClient').textContent = numClient + ' người';
            document.getElementById('modalPoints').textContent = points;
            document.getElementById("modalstatusBooking").textContent=statusBooking;
        });
    </script>
</body>
</html>