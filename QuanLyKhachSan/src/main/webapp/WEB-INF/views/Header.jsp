<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark shadow-sm">
			<div class="container-fluid">
				<a class="navbar-brand fw-bold text-warning" href="/">MyHotel</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="collapsibleNavbar">
					<ul class="navbar-nav mx-auto">
						<li class="nav-item"><a class="nav-link" href="/LandingPage">Trang
								chủ</a></li>
						<li class="nav-item"><a class="nav-link" href="/rooms">Phòng</a></li>
						<li class="nav-item"><a class="nav-link" href="/facilitys">Dịch
								vụ</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Lịch sử
								đặt phòng</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Hỗ trợ</a></li>
					</ul>

					<ul class="navbar-nav ms-auto align-items-center">

						<c:choose>

							<%-- TRƯỜNG HỢP 1: Chưa đăng nhập (Session rỗng) --%>
							<c:when test="${empty sessionScope.currentUser}">
								<li class="nav-item"><a class="nav-link" href="/login">
										<i class="bi bi-box-arrow-in-right"></i> Đăng nhập
								</a></li>
								<li class="nav-item"><a
									class="nav-link btn btn-outline-light btn-sm ms-2 px-3 rounded-pill"
									href="/register"> Đăng ký </a></li>
							</c:when>

							<%-- TRƯỜNG HỢP 2: Đã đăng nhập (Session có dữ liệu) --%>
							<c:otherwise>
								<li class="nav-item me-3 text-white"><span
									class="nav-link disabled text-light"> <i
										class="bi bi-person-circle"></i> Xin chào, <strong>${sessionScope.currentUser.user.fullname}</strong>
								</span></li>
								<li class="nav-item"><a
									class="nav-link text-danger fw-bold" href="/logout"> Đăng
										xuất </a></li>
							</c:otherwise>

						</c:choose>

					</ul>
				</div>
			</div>
		</nav>
	</header>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>