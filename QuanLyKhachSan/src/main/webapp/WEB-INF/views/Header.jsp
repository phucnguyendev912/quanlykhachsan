<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<header>
		<nav
			class="navbar navbar-expand-lg bg-dark navbar-dark shadow-sm py-3">
			<div class="container">
				<a class="navbar-brand fw-bold text-warning text-uppercase" href="/"
					style="letter-spacing: 2px;"> <i class="fa-solid fa-hotel"></i>
					MyHotel
				</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="collapsibleNavbar">

					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="/LandingPage">Trang
								chủ</a></li>
						<li class="nav-item"><a class="nav-link" href="/rooms">Phòng</a></li>
						<li class="nav-item"><a class="nav-link" href="/facilitys">Dịch
								vụ</a></li>

						<c:if test="${not empty sessionScope.currentUser}">
							<li class="nav-item"><a class="nav-link"
								href="/bookinghistory">Lịch sử</a></li>
						</c:if>
					</ul>

					<form action="/search" method="get" class="d-flex me-3"
						role="search">
						<div class="input-group input-group-sm">
							<input type="text" name="keyword" class="form-control"
								placeholder="Tìm phòng..." value="${keyword}"
								style="min-width: 200px;">
							<button class="btn btn-warning text-dark fw-bold" type="submit">
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>
						</div>
					</form>

					<ul class="navbar-nav align-items-center">
						<c:choose>
							
							<c:when test="${empty sessionScope.currentUser}">
								<li class="nav-item"><a class="nav-link text-white"
									href="/login"> Đăng nhập </a></li>
								<li class="nav-item"><a
									class="btn btn-outline-warning btn-sm ms-2 px-3 rounded-pill fw-bold"
									href="/register"> Đăng ký </a></li>
							</c:when>

						
							<c:otherwise>
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle text-white" href="#"
									role="button" data-bs-toggle="dropdown"> <span
										class="badge bg-warning text-dark me-2 rounded-pill"> <i
											class="fa-solid fa-coins"></i> <fmt:formatNumber
												value="${sessionScope.currentUser.user.client.point}"
												type="number" /> điểm
									</span> <i class="bi bi-person-circle"></i>
										${sessionScope.currentUser.user.fullname}
								</a>
									<ul class="dropdown-menu dropdown-menu-end">
										<li><a class="dropdown-item" href="/profile">Hồ sơ cá
												nhân</a></li>
										<li><hr class="dropdown-divider"></li>
										<li><a class="dropdown-item text-danger" href="/logout">Đăng
												xuất</a></li>
									</ul></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
	</header>

</body>
</html>