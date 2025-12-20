<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>My Hotel - Trang Chủ</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

<style>
.hero {
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
	height: 600px;
	background-size: cover;
	background-position: center;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
}
</style>
</head>
<body class="bg-light">

	<jsp:include page="Header.jsp" />

	<header class="hero">
		<div>
			<h1 class="display-1 fw-bold">Kỳ Nghỉ Trong Mơ</h1>
			<p class="fs-4 mb-4">Trải nghiệm dịch vụ đẳng cấp 5 sao tại hệ
				thống khách sạn hàng đầu.</p>

			<c:if test="${!isLoggedIn}">
				<a href="/register"
					class="btn btn-warning btn-lg px-5 py-3 fw-bold rounded-pill">Đặt
					Phòng Ngay</a>
			</c:if>
			<c:if test="${isLoggedIn}">
				<button
					class="btn btn-warning btn-lg px-5 py-3 fw-bold rounded-pill">Tìm
					Phòng Trống</button>
			</c:if>
		</div>
	</header>

	<footer class="bg-dark text-white text-center py-4">
		<p>&copy; 2025 Luxury Hotel Management.</p>
	</footer>

</body>
</html>