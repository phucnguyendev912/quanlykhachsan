<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm Dịch Vụ Mới</title>
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
			<c:set var="activePage" value="service" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Thêm Dịch Vụ Mới</h1>
				</div>

				<div class="row justify-content-center">
					<div class="col-md-8">
						<div class="card shadow-sm">
							<div class="card-header bg-success text-white">
								<h5 class="mb-0">
									<i class="fas fa-plus-circle me-2"></i>Điền thông tin dịch vụ
								</h5>
							</div>
							<div class="card-body">
								<form action="/addFacility" method="get"
									enctype="multipart/form-data">
									<input type="hidden" name="facilityId"
										value="${facility.facilityId}">
									<div class="mb-3">
										<label for="serviceName" class="form-label fw-bold">Tên
											dịch vụ <span class="text-danger">*</span>
										</label> <input type="text" class="form-control" id="serviceName"
											name="serviceName" value="${ facility.serviceName}" required
											placeholder="Ví dụ: Massage toàn thân, Giặt ủi...">
									</div>

									<div class="row">
										<div class="col-md-6 mb-3">
											<label for="servicePrice" class="form-label fw-bold">Giá
												tiền (VND) <span class="text-danger">*</span>
											</label>  
												<input
												type="number" class="form-control" id="servicePrice"
												name="servicePrice"
												value="${ facility.servicePrice}"  required placeholder="0">
										</div>

										<div class="col-md-6 mb-3">
											<label for="timeApply" class="form-label fw-bold">Thời
												gian áp dụng</label> <input type="text" class="form-control"
												id="timeApply_Service" name="timeapplyService"
												value="${facility.timeapplyService }"
												placeholder="VD: 08:00 - 22:00 hoặc 24/7">
										</div>
									</div>

									<div class="mb-3">
										<label for="imageFile" class="form-label fw-bold">Hình
											ảnh mô tả</label> <input type="text" class="form-control" id="image"
											name="image" value="${facility.image }" accept="image/*">

									</div>

									<div class="mb-3">
										<label for="description" class="form-label fw-bold">Mô
											tả chi tiết</label>
										<textarea class="form-control" id="description"
											name="description" rows="4"
											placeholder="Nhập mô tả về dịch vụ...">${facility.description} </textarea>
									</div>

									<div class="d-flex justify-content-end gap-2 mt-4">
										<a href="/serviceManagement" class="btn btn-secondary"> <i
											class="fas fa-arrow-left me-1"></i> Quay lại
										</a>
										<button type="submit" class="btn btn-success">
											<i class="fas fa-save me-1"></i> Lưu dịch vụ
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