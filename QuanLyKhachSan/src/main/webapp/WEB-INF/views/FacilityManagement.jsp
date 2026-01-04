<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản Lý Dịch Vụ</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="/css/SideBar.css">
<style>
/* Thêm CSS cho ảnh dịch vụ nhỏ gọn */
.service-img {
	width: 80px;
	height: 60px;
	object-fit: cover;
	border-radius: 5px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<c:set var="activePage" value="service" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Danh sách Dịch vụ</h1>

					<a href="/showaddFacility" class="btn btn-success"> <i
						class="fas fa-plus"></i> Thêm dịch vụ mới
					</a>
				</div>

				<div class="card shadow-sm">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover align-middle">
								<thead class="table-dark">
									<tr>
										<th>#ID</th>
										<th>Hình ảnh</th>
										<th>Tên dịch vụ</th>
										<th>Giá (VND)</th>
										<th>Mô tả</th>
										<th>Thời gian phục vụ</th>
										<th class="text-center">Hành động</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="s" items="${lstService}">
										<tr>
											<td>${s.facilityId}</td>
											<td><img
												src="${s.image != null ? s.image : '/images/no-service.png'}"
												class="service-img" alt="Service Img"></td>

											<td class="fw-bold text-primary">${s.serviceName}</td>

											<td><fmt:formatNumber value="${s.servicePrice}"
													type="currency" currencySymbol="₫" /></td>

											<td style="max-width: 200px;" class="text-truncate"
												title="${s.description}">${s.description}</td>

											<td>${s.timeapplyService}</td>

											<td class="text-center"><a
												href="/editfacility/${s.facilityId}"
												class="btn btn-warning btn-sm" title="Sửa"> <i
													class="fas fa-edit"></i>
											</a> <a href="/deleteFacility/${s.facilityId}"
												class="btn btn-danger btn-sm"
												onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ ${s.serviceName} không?');"
												title="Xóa"> <i class="fas fa-trash"></i>
											</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>