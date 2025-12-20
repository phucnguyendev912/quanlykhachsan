<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết phòng ${room.typeRoom}</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
/* Ảnh phòng to đẹp */
.room-main-image {
	width: 100%;
	height: 450px;
	object-fit: cover;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

/* Khung thông tin bên phải */
.booking-card {
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.08);
	padding: 30px;
	border: 1px solid #f0f0f0;
	position: sticky; /* Giữ khung này cố định khi cuộn chuột */
	top: 20px;
}

.spec-item {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	font-size: 15px;
	color: #555;
}

.spec-item i {
	width: 30px;
	color: #667eea;
	font-size: 18px;
}

.room-description {
	line-height: 1.8;
	color: #4a4a4a;
	font-size: 16px;
	text-align: justify;
}

/* Các tiện ích giả lập (Icon) */
.amenity-badge {
	display: inline-block;
	padding: 8px 15px;
	background: #f8f9fa;
	border-radius: 8px;
	margin-right: 10px;
	margin-bottom: 10px;
	font-size: 14px;
	color: #666;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />
	<fmt:setLocale value="vi_VN" />

	<div class="container mt-5 mb-5">
		<a href="/rooms"
			class="text-decoration-none text-secondary mb-4 d-inline-block">
			<i class="fa-solid fa-arrow-left"></i> Quay lại danh sách
		</a>

		<div class="row">
			<div class="col-lg-8">
				<img src="${room.image}" class="room-main-image"
					alt="${room.typeRoom}">

				<h2 class="fw-bold text-primary mb-3">${room.typeRoom}</h2>

				<h5 class="fw-bold mt-4 mb-3">Mô tả phòng</h5>
				<div class="room-description mb-4">
					<c:choose>
						<c:when test="${not empty room.description}">
                            ${room.description}
                        </c:when>
						<c:otherwise>
							<p class="text-muted fst-italic">Chưa có mô tả chi tiết cho
								phòng này.</p>
						</c:otherwise>
					</c:choose>
				</div>

				<h5 class="fw-bold mt-4 mb-3">Tiện nghi có sẵn</h5>
				<div class="mb-4">
					<span class="amenity-badge"><i
						class="fa-solid fa-wifi text-primary"></i> Wifi Tốc độ cao</span> <span
						class="amenity-badge"><i
						class="fa-solid fa-tv text-primary"></i> Smart TV</span> <span
						class="amenity-badge"><i
						class="fa-solid fa-snowflake text-primary"></i> Điều hòa 2 chiều</span> <span
						class="amenity-badge"><i
						class="fa-solid fa-mug-hot text-primary"></i> Trà & Café miễn phí</span>
					<span class="amenity-badge"><i
						class="fa-solid fa-bath text-primary"></i> Bồn tắm nằm</span>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="booking-card">
					<div class="border-bottom pb-3 mb-3">
						<small class="text-muted">Giá</small>
						<div class="d-flex align-items-center justify-content-between">
							<h3 class="text-danger fw-bold m-0">
								<fmt:formatNumber value="${room.priceRoom}" pattern="#,###" />
								VNĐ
							</h3>
						</div>
					</div>

					<div class="spec-item">
						<i class="fa-solid fa-door-open"></i> <span>Số phòng: <strong>${room.roomNumber}</strong></span>
					</div>

					<div class="spec-item">
						<i class="fa-solid fa-user-group"></i> <span>Số khách tối
							đa: <strong>${room.numberOfclient} người</strong>
						</span>
					</div>

					<c:if test="${not empty room.acreage}">
						<div class="spec-item">
							<i class="fa-solid fa-maximize"></i> <span>Diện tích: <strong>${room.acreage}
									m²</strong></span>
						</div>
					</c:if>

					<hr>

					<c:if test="${room.statusroom == 'Trống'}">
						<div class="alert alert-success text-center py-2 mb-3">
							<i class="fa-solid fa-circle-check"></i> Phòng đang trống
						</div>
						<a href="/booking-details/${room.roomId}"
							class="btn btn-primary w-100 py-3 fw-bold text-uppercase shadow-sm">
							Đặt Phòng Ngay </a>
						<small class="d-block text-center text-muted mt-2">Không
							cần thanh toán trước</small>
					</c:if>

					<c:if test="${room.statusroom != 'Trống'}">
						<div class="alert alert-danger text-center py-2 mb-3">
							<i class="fa-solid fa-circle-xmark"></i> Đã có khách thuê
						</div>
						<button
							class="btn btn-secondary w-100 py-3 fw-bold text-uppercase"
							disabled>Hết Phòng</button>
						<small class="d-block text-center text-muted mt-2">Vui
							lòng chọn phòng khác</small>
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>