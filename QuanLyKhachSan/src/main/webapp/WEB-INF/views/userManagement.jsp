<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản lý Người dùng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* CSS badge trạng thái */
.badge-active { background-color: #198754; }
.badge-locked { background-color: #dc3545; }
.badge-secondary { background-color: #6c757d; }
</style>
</head>
<body>
    <div class="container-fluid">
		<div class="row">
            
            <c:set var="activePage" value="users" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Danh sách Khách hàng</h1>
					<a href="/addUser" class="btn btn-primary btn-sm"> 
                        <i class="fas fa-plus me-2"></i>Thêm mới
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
										<th>SĐT</th>
										<th>Điểm tích lũy</th>
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
                                                <small class="text-muted">
                                                    <i class="fas fa-birthday-cake me-1"></i>
                                                    <fmt:formatDate value="${u.dob}" pattern="dd/MM/yyyy"/>
                                                </small>
											</td>

											<td>${u.email}</td>

											<td>${u.phoneNumber}</td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.client != null && u.client.point != null}">
														<span class="badge bg-warning text-dark"> 
                                                            <i class="fas fa-star me-1"></i>${u.client.point}
														</span>
													</c:when>
													<c:otherwise>
														<span class="badge bg-light text-muted border">0</span>
													</c:otherwise>
												</c:choose>
                                            </td>

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
													data-id="${u.userId}" 
                                                    data-fullname="${u.fullname}"
													data-email="${u.email}" 
                                                    data-phone="${u.phoneNumber}"
													data-sex="${u.sex}" 
                                                    data-dob="${u.dob}"
													data-address="${u.address}" 
                                                    data-status="${u.status}"
													data-point="${u.client != null ? u.client.point : 0}"
													title="Xem chi tiết">
													<i class="fas fa-eye"></i>
												</button> 
                                                
                                                <a href="/editUser/${u.userId}" class="btn btn-primary btn-sm ms-1"> 
                                                    <i class="fas fa-edit"></i>
											    </a> 
                                                
                                                <a href="/deleteUser/${u.userId}" class="btn btn-danger btn-sm ms-1"
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
		</div> </div> <div class="modal fade" id="userDetailModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title">
						Hồ sơ người dùng #<span id="modalUserId"></span>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="text-center mb-3">
						<i class="fas fa-user-circle fa-4x text-secondary"></i>
						<h5 class="mt-2" id="modalFullName"></h5>
						<span class="badge bg-warning text-dark fs-6"> 
                            <i class="fas fa-star text-white"></i> Điểm tích lũy: <span id="modalPoint"></span>
						</span>
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><strong>Email:</strong> <span
							id="modalEmail"></span></li>
						<li class="list-group-item"><strong>SĐT:</strong> <span
							id="modalPhone"></span></li>
						<li class="list-group-item d-flex justify-content-between">
                            <span><strong>Ngày sinh:</strong> <span id="modalDob"></span></span> 
                            <span><strong>Giới tính:</strong> <span id="modalSex"></span></span>
                        </li>
						<li class="list-group-item"><strong>Địa chỉ:</strong> <span
							id="modalAddress"></span></li>
						<li class="list-group-item"><strong>Trạng thái:</strong> <span
							id="modalStatus"></span></li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // Script xử lý Modal
        const userDetailModal = document.getElementById('userDetailModal');
        userDetailModal.addEventListener('show.bs.modal', event => {
            const button = event.relatedTarget;
            
            // Lấy dữ liệu
            const id = button.getAttribute('data-id');
            const fullname = button.getAttribute('data-fullname');
            const email = button.getAttribute('data-email');
            const phone = button.getAttribute('data-phone');
            const sex = button.getAttribute('data-sex');
            const dob = button.getAttribute('data-dob');
            const address = button.getAttribute('data-address');
            const status = button.getAttribute('data-status');
            const point = button.getAttribute('data-point'); 

            // Gán dữ liệu vào Modal
            document.getElementById('modalUserId').textContent = id;
            document.getElementById('modalFullName').textContent = fullname;
            document.getElementById('modalEmail').textContent = email;
            document.getElementById('modalPhone').textContent = phone;
            document.getElementById('modalDob').textContent = dob; // Modal hiện chuỗi ngày gốc
            document.getElementById('modalAddress').textContent = address;
            document.getElementById('modalStatus').textContent = status;
            document.getElementById('modalPoint').textContent = point; 

            document.getElementById('modalSex').textContent = (sex === 'true') ? 'Nam' : 'Nữ';
        });
    </script>
</body>
</html>