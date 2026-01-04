<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản Lý Đặt Dịch Vụ</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* CSS trạng thái thanh toán */
.badge-paid {
	background-color: #198754;
} /* Xanh lá - Đã thanh toán */
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
			<c:set var="activePage" value="serviceBooking" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Danh sách Đặt Dịch Vụ</h1>
				</div>

				<div class="card shadow-sm">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover align-middle">
								<thead class="table-dark">
									<tr>
										<th>#ID</th>
										<th>Khách hàng</th>
										<th>Tên Dịch vụ</th>
										<th>Ngày đặt</th>
										<th>Thời gian dùng</th>
										<th>Số lượng</th>
										<th>Tổng tiền</th>
										<th>Trạng thái TT</th>
										<th class="text-center">Hành động</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="b" items="${lstfacility}">
										<tr>
											<td><strong>${b.serviceBookingId}</strong></td>

											<td>${b.client.user.fullname}</td>

											<td>
												<div class="fw-bold text-primary">${b.facilityName}</div> <small
												class="text-muted"> Đơn giá: <fmt:formatNumber
														value="${b.facilityPrice}" type="currency"
														currencySymbol="₫" />
											</small>
											</td>

											<td><fmt:formatDate value="${b.bookingDate}"
													pattern="dd/MM/yyyy HH:mm" /></td>

											<td>${b.usageTime}</td>

											<td class="text-center fw-bold">${b.numberOf}</td>

											<td class="fw-bold text-danger"><fmt:formatNumber
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
													data-id="${b.serviceBookingId}"
													data-service-name="${b.facilityName}"
													data-quantity="${b.numberOf}" data-notes="${b.notes}"
													data-vnpay="${b.vnpTxnRef}"
													data-method="${b.paymentMethod}"
													data-datepay="${b.datePayment}"
													data-total="${b.totalPrice}" title="Xem chi tiết">
													<i class="fas fa-eye"></i>
												</button> <c:if test="${b.statusPayment != 'Đã hủy'}">
													<a href="/deleteFacilityBooking/${b.serviceBookingId}"
														class="btn btn-danger btn-sm ms-1"
														onclick="return confirm('Bạn có chắc chắn muốn hủy đơn dịch vụ này?')"
														title="Hủy đơn"> <i class="fas fa-times"></i>
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
						Chi tiết đơn dịch vụ #<span id="modalBookingId"></span>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><span class="fw-bold">Tên
								dịch vụ:</span> <span id="modalServiceName"
							class="text-primary float-end"></span></li>
						<li class="list-group-item"><span class="fw-bold">Số
								lượng:</span> <span id="modalQuantity" class="float-end"></span></li>
						<li class="list-group-item"><span class="fw-bold">Ghi
								chú của khách:</span>
							<p id="modalNotes"
								class="text-muted mt-1 mb-0 fst-italic border p-2 rounded bg-light"></p>
						</li>
						<hr>
						<li class="list-group-item d-flex justify-content-between"><span>Mã
								giao dịch (VNPAY):</span> <strong id="modalVnpay"></strong></li>
						<li class="list-group-item d-flex justify-content-between"><span>Phương
								thức TT:</span> <strong id="modalMethod"></strong></li>
						<li class="list-group-item d-flex justify-content-between"><span>Thời
								gian thanh toán:</span> <strong id="modalDatePay"></strong></li>
						<li
							class="list-group-item d-flex justify-content-between bg-light">
							<span class="fw-bold">TỔNG TIỀN:</span> <strong id="modalTotal"
							class="text-danger fs-5"></strong>
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
        // Xử lý sự kiện hiển thị Modal
        const detailModal = document.getElementById('detailModal');
        detailModal.addEventListener('show.bs.modal', event => {
            const button = event.relatedTarget;
            
            // Lấy dữ liệu từ data attributes
            const id = button.getAttribute('data-id');
            const serviceName = button.getAttribute('data-service-name');
            const quantity = button.getAttribute('data-quantity');
            const notes = button.getAttribute('data-notes');
            const vnpay = button.getAttribute('data-vnpay');
            const method = button.getAttribute('data-method');
            const datepay = button.getAttribute('data-datepay');
            const total = button.getAttribute('data-total');

            // Format tiền tệ
            const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });
            const formattedTotal = total ? formatter.format(total) : '0 ₫';

            // Gán dữ liệu vào Modal
            document.getElementById('modalBookingId').textContent = id;
            document.getElementById('modalServiceName').textContent = serviceName;
            document.getElementById('modalQuantity').textContent = quantity;
            document.getElementById('modalNotes').textContent = notes || 'Không có ghi chú';
            
            document.getElementById('modalVnpay').textContent = vnpay || '---';
            document.getElementById('modalMethod').textContent = method || '---';
            document.getElementById('modalDatePay').textContent = datepay || 'Chưa thanh toán';
            document.getElementById('modalTotal').textContent = formattedTotal;
        });
    </script>
</body>
</html>