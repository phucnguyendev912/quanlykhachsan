<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Trang Quản Trị (Admin)</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-dark text-white">
	<div class="container mt-5">
		<h1>Dashboard Quản Lý</h1>
		<h3 class="text-success">Xin chào Admin: ${adminName}</h3>

		<div class="mt-4">
			<button class="btn btn-primary">Quản lý Phòng</button>
			<button class="btn btn-warning">Quản lý Khách hàng</button>
			<button class="btn btn-info">Thống kê doanh thu</button>
		</div>

		<a href="/logout" class="btn btn-danger mt-5">Đăng xuất</a>
	</div>
</body>
</html>