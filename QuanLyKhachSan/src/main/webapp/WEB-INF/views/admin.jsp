<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Quản Lý Khách Sạn</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
body {
	background-color: #f8f9fa; /* Màu nền xám nhẹ cho dịu mắt */
}

.sidebar {
	min-height: 100vh;
	background-color: #343a40;
	color: white;
}

.sidebar a {
	color: #adb5bd;
	text-decoration: none;
	padding: 10px 15px;
	display: block;
}

.sidebar a:hover, .sidebar a.active {
	background-color: #495057;
	color: white;
	border-left: 4px solid #0d6efd; /* Điểm nhấn khi hover */
}

.stat-card {
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s;
}

.stat-card:hover {
	transform: translateY(-5px); /* Hiệu ứng nổi lên khi di chuột vào */
}
</style>
</head>
<body>

	<div class="container-fluid">
		<div class="row">
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Tổng quan</h1>
					<div class="btn-toolbar mb-2 mb-md-0">
						<div class="btn-group me-2">
							<button type="button" class="btn btn-sm btn-outline-secondary">Xuất
								báo cáo</button>
						</div>
						<span class="text-muted align-self-center">Xin chào, <strong>${adminName}</strong></span>
					</div>
				</div>

				<div class="row g-4 mb-5">
					<div class="col-md-4">
						<div class="card stat-card bg-primary text-white h-100">
							<div class="card-body">
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<h6 class="card-title">Tổng số phòng</h6>
										<h2 class="mb-0">${totalRooms != null ? totalRooms : 0}</h2>
									</div>
									<i class="fas fa-bed fa-3x opacity-50"></i>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="card stat-card bg-warning text-dark h-100">
							<div class="card-body">
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<h6 class="card-title">Đơn đặt mới</h6>
										<h2 class="mb-0">${newBookings != null ? newBookings : 0}</h2>
									</div>
									<i class="fas fa-bell fa-3x opacity-50"></i>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="card stat-card bg-success text-white h-100">
							<div class="card-body">
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<h6 class="card-title">Doanh thu tháng</h6>
										<h2 class="mb-0">${revenue != null ? revenue : '0 VND'}</h2>
									</div>
									<i class="fas fa-dollar-sign fa-3x opacity-50"></i>
								</div>
							</div>
						</div>
					</div>
				</div>

				<h3>Hoạt động gần đây</h3>
				<div class="table-responsive bg-white rounded shadow-sm p-3">
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>#ID</th>
								<th>Khách hàng</th>
								<th>Ngày đặt</th>
								<th>Trạng thái</th>
								<th>Hành động</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>101</td>
								<td>Nguyễn Văn A</td>
								<td>25/12/2025</td>
								<td><span class="badge bg-warning text-dark">Chờ
										duyệt</span></td>
								<td><button class="btn btn-sm btn-primary">Xem</button></td>
							</tr>
							<tr>
								<td>102</td>
								<td>Trần Thị B</td>
								<td>24/12/2025</td>
								<td><span class="badge bg-success">Đã thanh toán</span></td>
								<td><button class="btn btn-sm btn-primary">Xem</button></td>
							</tr>
						</tbody>
					</table>
				</div>

			</main>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>