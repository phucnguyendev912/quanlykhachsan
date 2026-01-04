<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>${user.userId == null ? 'Thêm Người Dùng' : 'Cập Nhật Người Dùng'}</title>
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
			<c:set var="activePage" value="users" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">${user.userId == null ? 'Thêm Người Dùng Mới' : 'Cập Nhật Thông Tin'}</h1>
				</div>

				<div class="row justify-content-center">
					<div class="col-md-8">
						<div class="card shadow-sm">
							<div class="card-header bg-primary text-white">
								<h5 class="mb-0">
									<i class="fas fa-user-edit me-2"></i>Thông tin người dùng
								</h5>
							</div>
							<div class="card-body">
								<form action="/saveUser" method="post">
									<input type="hidden" name="userId" value="${user.userId}">

									<div class="mb-3">
										<label class="form-label fw-bold">Họ và Tên <span
											class="text-danger">*</span></label> <input type="text"
											class="form-control" name="fullname" value="${user.fullname}"
											required placeholder="VD: Nguyễn Văn A">
									</div>

									<div class="row">
										<div class="col-md-6 mb-3">
											<label class="form-label fw-bold">Email</label> <input
												type="email" class="form-control" name="email"
												value="${user.email}" placeholder="abc@gmail.com">
										</div>
										<div class="col-md-6 mb-3">
											<label class="form-label fw-bold">Số điện thoại <span
												class="text-danger">*</span></label> <input type="text"
												class="form-control" name="phoneNumber"
												value="${user.phoneNumber}" required>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6 mb-3">
											<label class="form-label fw-bold">Ngày sinh <span
												class="text-danger">*</span></label> <input type="date"
												class="form-control" name="dob" value="${user.dob}" required>
										</div>
										<div class="col-md-6 mb-3">
											<label class="form-label fw-bold">Giới tính</label> <select
												class="form-select" name="sex">
												<option value="true" ${user.sex == true ? 'selected' : ''}>Nam</option>
												<option value="false" ${user.sex == false ? 'selected' : ''}>Nữ</option>
											</select>
										</div>
									</div>

									<div class="mb-3">
										<label class="form-label fw-bold">Địa chỉ</label> <input
											type="text" class="form-control" name="address"
											value="${user.address}" placeholder="Nhập địa chỉ...">
									</div>

									<div class="mb-3">
										<label class="form-label fw-bold">Trạng thái</label> <select
											class="form-select" name="status">
											<option value="ACTIVE"
												${user.status == 'ACTIVE' ? 'selected' : ''}>Hoạt
												động</option>
											<option value="LOCKED"
												${user.status == 'LOCKED' ? 'selected' : ''}>Khóa</option>
										</select>
									</div>

									<div class="d-flex justify-content-end gap-2 mt-4">
										<a href="/usermanagement" class="btn btn-secondary"> <i
											class="fas fa-arrow-left me-1"></i> Quay lại
										</a>
										<button type="submit" class="btn btn-success">
											<i class="fas fa-save me-1"></i> Lưu lại
										</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>