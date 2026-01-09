<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh Sách Tiện Nghi & Dịch Vụ</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
/* CSS giữ nguyên như cũ */
.text-center {
	padding: 20px;
}

.service-card {
	background: #fff;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
	margin-bottom: 30px;
	border: 1px solid #e0e0e0;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.service-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}

.service-card img {
	width: 100%;
	height: 220px;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.service-card:hover img {
	transform: scale(1.05);
}

.service-info {
	padding: 20px 15px;
	background: linear-gradient(to bottom, #f8f9fa, #ffffff);
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.service-title {
	font-size: 18px;
	color: #2c3e50;
	display: block;
	margin-bottom: 8px;
	font-weight: 700;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	height: 54px;
}

.service-time {
	font-size: 14px;
	color: #7f8c8d;
	display: block;
	margin-bottom: 5px;
}

.service-desc {
	font-size: 13px;
	color: #666;
	margin-bottom: 10px;
	font-style: italic;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.price-tag {
	display: block;
	font-size: 20px;
	font-weight: 700;
	color: #d4af37;
	margin: 10px 0;
}

.btn-book {
	width: 100%;
	padding: 10px 20px;
	background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	text-transform: uppercase;
}

.btn-book:hover {
	background: linear-gradient(135deg, #38ef7d 0%, #11998e 100%);
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(56, 239, 125, 0.4);
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />
	<fmt:setLocale value="vi_VN" />

	<div class="container py-5">
		<div class="text-center mb-5">
			<h2 class="fw-bold text-primary">DỊCH VỤ</h2>
			<p class="text-muted">Trải nghiệm những dịch vụ đẳng cấp tại
				khách sạn của chúng tôi</p>
		</div>

		<div class="row">
			<c:forEach items="${dsFacility}" var="s">
				<div class="col-md-3 col-sm-6 mb-4">
					<div
						class="service-card h-100 shadow-sm border-0 rounded-3 overflow-hidden">

						<img src="${s.image}" alt="${s.serviceName}" class="w-100"
							style="height: 200px; object-fit: cover;"
							onerror="this.src='https://placehold.co/600x400?text=Service'">

						<div class="p-3 text-center d-flex flex-column h-100">
							<h5 class="fw-bold text-primary">${s.serviceName}</h5>
							<p class="text-muted small text-truncate">${s.description}</p>

							<div class="mt-auto">
								<span class="d-block fw-bold text-danger fs-5 mb-2"> <fmt:formatNumber
										value="${s.servicePrice}" pattern="#,###" /> VNĐ
								</span>

								<button type="button"
									class="btn btn-outline-primary w-100 rounded-pill"
									data-bs-toggle="modal"
									data-bs-target="#modalService${s.facilityId}">Xem chi
									tiết</button>
							</div>
						</div>
					</div>
				</div>

				<div class="modal fade" id="modalService${s.facilityId}"
					tabindex="-1" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header bg-primary text-white">
								<h5 class="modal-title fw-bold">${s.serviceName}</h5>
								<button type="button" class="btn-close btn-close-white"
									data-bs-dismiss="modal"></button>
							</div>

							<div class="modal-body">
								<img src="${s.image}" class="img-fluid rounded mb-3 w-100"
									style="height: 250px; object-fit: cover;">

								<p>
									<strong><i class="fa-solid fa-clock"></i> Thời gian:</strong>
									${s.timeapplyService}
								</p>
								<p>
									<strong><i class="fa-solid fa-money-bill"></i> Giá
										tiền:</strong> <span class="text-danger fw-bold"> <fmt:formatNumber
											value="${s.servicePrice}" pattern="#,###" /> VNĐ
									</span>
								</p>

								<hr>
								<p class="text-secondary" style="text-align: justify;">
									${s.description}</p>
							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Đóng</button>

								<a href="/bookingService?id=${s.facilityId}"
									class="btn btn-primary"> <i class="fa-solid fa-cart-plus"></i>
									Đặt Dịch Vụ
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<c:if test="${sotrang > 1}">
			<nav aria-label="Page navigation" class="mt-5">
				<ul class="pagination justify-content-center">
					<li class="page-item ${page == 1 ? 'disabled' : ''}"><a
						class="page-link" href="/facilitys?page=${page - 1}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>

					<c:forEach begin="1" end="${sotrang}" var="i">
						<li class="page-item ${i == page ? 'active' : ''}"><a
							class="page-link" href="/facilitys?page=${i}">${i}</a></li>
					</c:forEach>

					<li class="page-item ${page == sotrang ? 'disabled' : ''}"><a
						class="page-link" href="/facilitys?page=${page + 1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
		</c:if>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>