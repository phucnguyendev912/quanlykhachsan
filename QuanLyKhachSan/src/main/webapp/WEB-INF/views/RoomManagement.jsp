<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản Lý Phòng</title>
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
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Danh sách phòng</h1>

					<a href="/ShowAddRoom" class="btn btn-success"> <i
						class="fas fa-plus"></i> Thêm phòng mới
					</a>
				</div>

				<div class="card shadow-sm">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover align-middle">
								<thead class="table-dark">
									<tr>
										<th>#ID</th>
										<th>Ảnh</th>
										<th>Số phòng</th>
										<th>Loại phòng</th>
										<th>Giá (VND)</th>
										<th>Diện tích</th>
										<th>Số lượng</th>

										<th>Trạng thái</th>
										<th class="text-center">Hành động</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="room" items="${lstroom}">
										<tr>
											<td>${room.roomId}</td>
											<td><img
												src="${room.image != null ? room.image : '/images/no-image.png'}"
												class="room-img" alt="Room Img"></td>
											<td class="fw-bold text-primary">${room.roomNumber}</td>
											<td>${room.typeRoom}</td>
											<td><fmt:formatNumber value="${room.priceRoom}"
													type="currency" currencySymbol="₫" /></td>
											<td>${room.acreage}m2</td>
											<td>${room.numberOfclient}người</td>

											<td><c:choose>
													<c:when test="${room.statusroom == 'Trống'}">
														<span class="badge bg-success">Trống</span>
													</c:when>
													<c:when test="${room.statusroom == 'Đã đặt'}">
														<span class="badge bg-danger">Đã đặt</span>
													</c:when>
													<c:otherwise>
														<span class="badge bg-secondary">${room.statusroom}</span>
													</c:otherwise>
												</c:choose></td>
											<td class="text-center"><a href="/edit/${room.roomId}"
												class="btn btn-warning btn-sm" title="Sửa"> <i
													class="fas fa-edit"></i>
											</a> <a href="/Delete/${room.roomId}"
												class="btn btn-danger btn-sm"
												onclick="return confirm('Bạn có chắc chắn muốn xóa phòng số ${room.roomNumber} không?');"
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