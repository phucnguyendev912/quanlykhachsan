<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Chủ - Quản Lý Khách Sạn</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

<style>
/* CSS tủy chỉnh cho Banner đẹp hơn */
.hero-section {
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');
	background-size: cover;
	background-position: center;
	height: 450px;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	text-align: center;
}

.feature-card:hover {
	transform: translateY(-5px);
	transition: 0.3s;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
	cursor: pointer;
}
</style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

	<nav
		class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top shadow-sm">
		<div class="container">
			<a class="navbar-brand fw-bold text-uppercase" href="/"> <i
				class="bi bi-buildings-fill"></i> Hotel Manager
			</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active" href="/">Trang
							chủ</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Đặt
							phòng</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Dịch vụ</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Liên hệ</a></li>
				</ul>

				<div class="d-flex align-items-center text-white">
					<div class="me-3 text-end">
						<div class="fw-bold">Xin chào, ${myName}</div>
						<small class="badge bg-warning text-dark">Role: ${myRole}</small>
					</div>
					<a href="/logout" class="btn btn-outline-light btn-sm fw-bold">
						<i class="bi bi-box-arrow-right"></i> Đăng xuất
					</a>
				</div>
			</div>
		</div>
	</nav>

	<header class="hero-section mb-5">
		<h1 class="display-3 fw-bold">Nghỉ Dưỡng Đẳng Cấp 5 Sao</h1>
		<p class="lead fs-4">Trải nghiệm không gian sang trọng và dịch vụ
			hoàn hảo.</p>
		<div class="mt-3">
			<button class="btn btn-warning btn-lg fw-bold me-2">Đặt
				Phòng Ngay</button>
			<button class="btn btn-outline-light btn-lg fw-bold">Xem Chi
				Tiết</button>
		</div>
	</header>

	<div class="container mb-5">
		<h3
			class="text-primary fw-bold mb-4 border-start border-4 border-primary ps-3">Dịch
			Vụ Nổi Bật</h3>

		<div class="row g-4">
			<div class="col-md-4">
				<div class="card h-100 border-0 shadow-sm feature-card">
					<div class="card-body text-center p-4">
						<div class="text-primary display-4 mb-3">
							<i class="bi bi-house-heart"></i>
						</div>
						<h5 class="card-title fw-bold">Phòng Tổng Thống</h5>
						<p class="card-text text-muted">View biển trọn vẹn, nội thất
							dát vàng, phục vụ riêng 24/7.</p>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card h-100 border-0 shadow-sm feature-card">
					<div class="card-body text-center p-4">
						<div class="text-success display-4 mb-3">
							<i class="bi bi-cup-hot"></i>
						</div>
						<h5 class="card-title fw-bold">Nhà Hàng Á - Âu</h5>
						<p class="card-text text-muted">Thực đơn đa dạng từ các đầu
							bếp hàng đầu thế giới.</p>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card h-100 border-0 shadow-sm feature-card">
					<div class="card-body text-center p-4">
						<div class="text-info display-4 mb-3">
							<i class="bi bi-water"></i>
						</div>
						<h5 class="card-title fw-bold">Hồ Bơi Vô Cực</h5>
						<p class="card-text text-muted">Hồ bơi nước mặn view biển,
							quầy bar tích hợp sang trọng.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer class="bg-dark text-white text-center py-4 mt-auto">
		<div class="container">
			<p class="mb-1">
				&copy; 2025 Hotel Management System. Design by <strong>Thien
					Phuc</strong>.
			</p>
			<small class="text-muted">Địa chỉ: Huế, Việt Nam | Hotline:
				0349xxxxxx</small>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>