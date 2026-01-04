<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Client Management</title>
</head>
<body>
	<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
		<div
			class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			<h1 class="h2">Danh sách Người dùng</h1>
			<a href="/addUser" class="btn btn-primary btn-sm"> <i
				class="fas fa-plus me-2"></i>Thêm mới
			</a>
		</div>

		<div class="card shadow-sm">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-hover align-middle">
						<thead class="table-dark">
							<tr>
								<th>#ID</th>
								<th>Họ và Tên</th>
								<th>Email</th>
								<th>Số điện thoại</th>
								<th>Giới tính</th>
								<th>Trạng thái</th>
								<th class="text-center">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="u" items="${lstUser}">
								<tr>
									<td><strong>${u.userId}</strong></td>

									<td>
										<div class="fw-bold text-primary">${u.fullname}</div>
									</td>

									<td>${u.email}</td>

									<td>${u.phoneNumber}</td>

									<td><c:choose>
											<c:when test="${u.sex == true}">
												<span class="badge bg-info text-dark">Nam</span>
											</c:when>
											<c:otherwise>
												<span class="badge bg-warning text-dark">Nữ</span>
											</c:otherwise>
										</c:choose></td>

									<td><c:choose>
											<c:when
												test="${u.status == 'ACTIVE' || u.status == 'Hoạt động'}">
												<span class="badge badge-active">Hoạt động</span>
											</c:when>
											<c:when
												test="${u.status == 'LOCKED' || u.status == 'Đã khóa'}">
												<span class="badge badge-locked">Đã khóa</span>
											</c:when>
											<c:otherwise>
												<span class="badge badge-secondary">${u.status}</span>
											</c:otherwise>
										</c:choose></td>

									<td class="text-center">
										<button type="button"
											class="btn btn-info btn-sm text-white btn-view-detail"
											data-bs-toggle="modal" data-bs-target="#userDetailModal"
											data-id="${u.userId}" data-fullname="${u.fullname}"
											data-email="${u.email}" data-phone="${u.phoneNumber}"
											data-sex="${u.sex}" data-dob="${u.dob}"
											data-address="${u.address}" data-status="${u.status}"
											title="Xem chi tiết">
											<i class="fas fa-eye"></i>
										</button> <a href="/editUser?id=${u.userId}"
										class="btn btn-primary btn-sm ms-1"> <i
											class="fas fa-edit"></i>
									</a> <a href="/deleteUser?id=${u.userId}"
										class="btn btn-danger btn-sm ms-1"
										onclick="return confirm('Bạn có chắc chắn muốn xóa/khóa người dùng này?')">
											<i class="fas fa-trash"></i>
									</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
</body>
</html>