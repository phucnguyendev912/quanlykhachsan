<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh Sách Phòng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
/* Giữ nguyên CSS đẹp của bạn */
.rooms-card {
	background: #fff;
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	transition: all 0.3s ease;
	border: none;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.rooms-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

.card-img-wrapper {
	position: relative;
	overflow: hidden;
	height: 220px;
	flex-shrink: 0;
}

.card-img-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.5s ease;
}

.rooms-card:hover img {
	transform: scale(1.1);
}

.status-badge {
	position: absolute;
	top: 15px;
	right: 15px;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	color: white;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.status-badge.trong {
	background-color: #2ecc71;
}

.status-badge.full {
	background-color: #e74c3c;
}

.rooms-info {
	padding: 20px;
	display: flex;
	flex-direction: column;
	flex-grow: 1;
}

.room-type {
	font-size: 18px;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 15px;
	display: block;
	text-decoration: none;
}

.room-type:hover {
	color: #667eea;
}

.price-tag {
	font-size: 20px;
	font-weight: 800;
	color: #e74c3c;
	margin-bottom: 20px;
	margin-top: auto;
}

.action-buttons {
	display: flex;
	gap: 10px;
}

.btn-detail {
	flex: 1;
	padding: 8px;
	border: 1px solid #667eea;
	color: #667eea;
	background: white;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	text-decoration: none;
	text-align: center;
	transition: all 0.3s;
}

.btn-detail:hover {
	background: #667eea;
	color: white;
}

.btn-book {
	flex: 1;
	padding: 8px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	text-decoration: none;
	text-align: center;
	transition: all 0.3s;
}

.btn-book:hover {
	opacity: 0.9;
	color: white;
	transform: translateY(-2px);
}

.btn-disabled {
	flex: 1;
	padding: 8px;
	background: #bdc3c7;
	color: white;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	text-align: center;
	border: none;
	cursor: not-allowed;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />

	<fmt:setLocale value="vi_VN" />

	<div class="container mt-5 mb-5">

		<div class="text-center mb-5">
			<c:if test="${not empty keyword}">
				<h2 class="text-primary fw-bold">KẾT QUẢ TÌM KIẾM</h2>
				<p class="text-muted">Từ khóa: "${keyword}"</p>
			</c:if>
			<c:if test="${empty keyword}">
				<h2 class="text-primary fw-bold">KHÁM PHÁ PHÒNG NGHỈ</h2>
				<p class="text-muted">Chọn không gian nghỉ dưỡng hoàn hảo cho
					bạn</p>
			</c:if>
		</div>

		<c:set var="roomsToShow"
			value="${not empty keyword ? listRooms : dsRooms}" />

		<div class="row g-4">

			<c:forEach items="${dsRooms}" var="room">
				<div class="col-md-3 col-sm-6 d-flex align-items-stretch">
					<div class="rooms-card w-100">

						<div class="card-img-wrapper">
							<a href="/room-detail?id=${room.roomId}"> <img
								src="${room.image}"
								onerror="this.src='https://via.placeholder.com/300x200?text=Room'">
							</a> <span
								class="status-badge ${room.statusroom == 'Trống' ? 'trong' : 'full'}">
								${room.statusroom == 'Trống' ? 'Còn Trống' : 'Hết Phòng'} </span>
						</div>

						<div class="rooms-info">
							<a href="/room-detail?id=${room.roomId}" class="room-type">
								${room.typeRoom} </a>

							<div class="price-tag">
								<fmt:formatNumber value="${room.priceRoom}" pattern="#,###" />
								<small
									style="font-size: 14px; color: #7f8c8d; font-weight: normal;">/
									đêm</small>
							</div>

							<div class="action-buttons">
								<a href="/room-detail?id=${room.roomId}" class="btn-detail">
									Chi tiết </a>

								<c:if test="${room.statusroom == 'Trống'}">
									<a href="/booking-details/${room.roomId}" class="btn-book">
										Đặt ngay </a>
								</c:if>

								<c:if test="${room.statusroom != 'Trống'}">
									<button class="btn-disabled" disabled>Đã thuê</button>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

			<c:if test="${not empty keyword and empty listRooms}">
				<div class="container text-center mt-5 mb-5">
					<img
						src="https://cdni.iconscout.com/illustration/premium/thumb/search-result-not-found-2130361-1800925.png"
						width="200" alt="Not found" class="mb-3">

					<h4 class="text-muted">Rất tiếc, không tìm thấy kết quả cho
						"${keyword}"</h4>
					<p class="text-muted">Hãy thử tìm kiếm với từ khóa khác như:
						Vip, Đơn, Đôi...</p>

					<a href="/rooms" class="btn btn-primary mt-3 px-4 rounded-pill">
						<i class="fa-solid fa-rotate-right"></i> Xem tất cả phòng
					</a>
				</div>
			</c:if>

		</div>

		<c:if test="${empty keyword}">
			<nav aria-label="Page navigation">
				<ul class="pagination justify-content-center mt-5">
					<li class="page-item ${page == 1 ? 'disabled' : ''}"><a
						class="page-link" href="/rooms?page=${page - 1}">&laquo;</a></li>

					<c:forEach begin="1" end="${sotrang}" var="i">
						<li class="page-item ${i == page ? 'active' : ''}"><a
							class="page-link" href="/rooms?page=${i}">${i}</a></li>
					</c:forEach>

					<li class="page-item ${page == sotrang ? 'disabled' : ''}"><a
						class="page-link" href="/rooms?page=${page + 1}">&raquo;</a></li>
				</ul>
			</nav>
		</c:if>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>