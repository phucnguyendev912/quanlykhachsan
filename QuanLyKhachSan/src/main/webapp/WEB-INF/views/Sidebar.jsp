<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="col-md-3 col-lg-2 d-md-block sidebar collapse show">
	<div class="position-sticky pt-3">
		<h4 class="text-center mb-4 border-bottom pb-3">Admin Panel</h4>
		<ul class="nav flex-column">

			<li class="nav-item"><a
				class="nav-link ${activePage == 'dashboard' ? 'active' : ''}"
				href="/admin/dashboard"> <i class="fas fa-tachometer-alt me-2"></i>
					Dashboard
			</a></li>

			<li class="nav-item"><a
				class="nav-link ${activePage == 'rooms' ? 'active' : ''}"
				href="/roomManagement"> <i class="fas fa-bed me-2"></i> Quản lý
					Phòng
			</a></li>

			<li class="nav-item"><a
				class="nav-link ${activePage == 'bookings' ? 'active' : ''}"
				href="/admin/bookings"> <i class="fas fa-calendar-check me-2"></i>
					Đặt phòng (Booking)
			</a></li>

			<li class="nav-item"><a
				class="nav-link ${activePage == 'users' ? 'active' : ''}"
				href="/admin/users"> <i class="fas fa-users me-2"></i> Khách
					hàng
			</a></li>

			<li class="nav-item"><a
				class="nav-link ${activePage == 'services' ? 'active' : ''}"
				href="/admin/services"> <i class="fas fa-spa me-2"></i> Dịch vụ
					Spa
			</a></li>

			<li class="nav-item mt-4 border-top pt-2"><a
				class="nav-link text-danger" href="/logout"> <i
					class="fas fa-sign-out-alt me-2"></i> Đăng xuất
			</a></li>
		</ul>
	</div>
</nav>