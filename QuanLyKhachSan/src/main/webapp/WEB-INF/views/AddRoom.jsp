<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm Phòng Mới</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="/css/SideBar.css">

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<c:set var="activePage" value="room" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<h2>Thêm Phòng Mới</h2>

				<div class="card shadow-sm mt-3">
					<div class="card-body">
						<form action="/add" method="post">
							<input type="hidden" name="roomId" value="${room.roomId}">
							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Số phòng (*)</label> <input
										type="number" class="form-control" name="roomNumber"
										value="${room.roomNumber}" required placeholder="Ví dụ: 101">
								</div>
								<div class="col-md-6">
									<label class="form-label">Giá phòng (VNĐ)</label> <input
										type="number" class="form-control" name="priceRoom"
										value="${room.priceRoom}" required>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Loại phòng</label> <input type="text"
										name="typeRoom" value="${room.typeRoom }" required
										placeholder="Ví dụ: Phòng couple">
								</div>
								<div class="col-md-6">
									<label class="form-label">Số lượng (Người)</label> <input
										type="number" class="form-control" name="numberOfclient"
										value="${room.numberOfclient}">
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Diện tích (m2)</label> <input
										type="number" step="0.1" class="form-control" name="acreage"
										value="${room.acreage }">
								</div>
								<div class="col-md-6">
									<label class="form-label">Trạng thái ban đầu</label> <select
										class="form-select" name="statusroom">
										<option value="Trống">Trống</option>
										<option value="Trống">Đã đặt</option>
									</select>
								</div>
							</div>
							<div class="mb-3">
								<label class="form-label">Link Ảnh</label> <input
									type="text" class="form-control" name="image"
									value="${room.image}" placeholder="https://...">
							</div>

							<div class="mb-3">
								<label class="form-label">Mô tả</label>
								<textarea class="form-control" name="description" rows="3">${room.description}</textarea>
							</div>

							<button type="submit" class="btn btn-primary">Lưu Phòng</button>
							<a href="/add" class="btn btn-secondary">Hủy bỏ</a>
						</form>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>