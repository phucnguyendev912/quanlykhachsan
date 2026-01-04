<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/css/SideBar.css">

<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block sidebar collapse show">
	<div class="position-sticky pt-3 px-2">
		<h4 class="text-center mb-4 border-bottom border-secondary pb-3">Admin Panel</h4>
		
		<ul class="nav flex-column">

			<li class="nav-item">
                <a class="nav-link ${activePage == 'dashboard' ? 'active' : ''}" href=statistics> 
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
			    </a>
            </li>

			<li class="nav-item">
                <a class="nav-link ${activePage == 'rooms' ? 'active' : ''}" href="/roomManagement"> 
                    <i class="fas fa-bed me-2"></i> Quản lý Phòng
			    </a>
            </li>

			<li class="nav-item">
                <a class="nav-link ${activePage == 'bookings' ? 'active' : ''}" href="/bookingroomManagement"> 
                    <i class="fas fa-calendar-check me-2"></i> Đặt phòng (Booking)
			    </a>
            </li>
            
			<li class="nav-item">
                <a class="nav-link ${activePage == 'serviceBooking' ? 'active' : ''}" href="/facilytiesManagement"> 
                     <i class="fas fa-spa me-2"></i>Quản lý dịch vụ
			    </a> 	
            </li>

			<li class="nav-item">
                <a class="nav-link ${activePage == 'users' ? 'active' : ''}" href="/usermanagement"> 
                    <i class="fas fa-users me-2"></i> Khách hàng
			    </a>
            </li>

			<li class="nav-item">
                <a class="nav-link ${activePage == 'service' ? 'active' : ''}" href="/showbookingfacility"> 
                     <i class="fas fa-receipt me-2"></i>Đặt dịch vụ
			    </a>
            </li>

            <li class="nav-item mt-4 border-top border-secondary pt-3">
                <a class="nav-link text-danger fw-bold" href="/logout" style="background-color: rgba(220, 53, 69, 0.1);"> 
                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
			    </a>
            </li>
		</ul>
	</div>
</nav>