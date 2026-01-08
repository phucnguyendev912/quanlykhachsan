<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	min-height: 100vh;
	background: #f6f9ff;
	font-family: system-ui, -apple-system, "Segoe UI", Roboto,
		"Helvetica Neue", Arial;
}

/* 🟦 Tăng kích thước thẻ card */
.login-card {
	width: 100%;
	max-width: 520px; /* trước là 420px → tăng 100px */
	border-radius: 16px; /* bo góc mềm hơn */
	box-shadow: 0 8px 24px rgba(22, 60, 120, 0.1); /* bóng mềm hơn */
	padding: 2.5rem; /* tăng khoảng cách trong card */
	background: #ffffff;
}

/* 🟩 Phần logo trong card */
.brand {
	height: 60px;
	width: 60px;
	border-radius: 12px;
	background: linear-gradient(135deg, #0d6efd, #00c6ff);
	display: inline-flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-weight: 700;
	font-size: 1.3rem;
}

/* 🟨 Font và form */
.login-card h4 {
	font-size: 1.5rem;
}

.form-control {
	font-size: 1.05rem;
	padding: 0.7rem 1rem;
}

.btn-lg {
	padding: 0.8rem 1rem;
	font-size: 1.1rem;
}
</style>

</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">MyHotel</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link"
						href="/register">Đăng ký</a></li>

				</ul>
			</div>
		</div>
	</nav>

	<!-- Main: căn giữa form -->
	<div class="d-flex align-items-center justify-content-center"
		style="min-height: calc(100vh - 56px);">
		<main class="login-card">

			<div class="d-flex align-items-center mb-3">
				<div class="brand me-3">A</div>
				<div>
					<h4 class="mb-0">MyHotel</h4>
					<small class="text-muted">Đăng nhập để tiếp tục</small>
				</div>
			</div>


			<form action="/login" method="post">
				<div class="mb-3">
					<label for="username" class="form-label">Email hoặc
						username</label> <input type="text" class="form-control" id="username"
						name="username" placeholder="nhập email hoặc username" required>
					<div class="invalid-feedback">Vui lòng nhập email hoặc
						username.</div>
				</div>

				<div class="mb-3 position-relative">
					<label for="password" class="form-label">Mật khẩu</label>
					<div class="input-group">
						<input type="password" class="form-control" id="password"
							name="password" placeholder="mật khẩu" required>
						<button class="btn btn-outline-secondary" type="button"
							id="togglePassword" aria-label="Hiện mật khẩu">
							<!-- icon -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                <path
									d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8z" />
                <path d="M8 5.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5z" />
              </svg>
						</button>
					</div>
					<div class="invalid-feedback">Vui lòng nhập mật khẩu.</div>
				</div>

				<div class="d-flex justify-content-between align-items-center mb-3">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" id="remember"
							name="remember"> <label class="form-check-label"
							for="remember">Ghi nhớ tôi</label>
					</div>
					<a href="#" class="small">Quên mật khẩu?</a>
				</div>
				<c:if test="${not empty Error}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						${Error}
						
					</div>
				</c:if>
				<div class="d-grid mb-3">
					<button type="submit" class="btn btn-primary btn-lg">Đăng
						nhập</button>
				</div>

				<div class="text-center small text-muted">
					Chưa có tài khoản? <a href="/register">Đăng ký</a>
				</div>

			</form>
		</main>
	</div>

	<!-- Bootstrap Bundle (JS + Popper) - chỉ include 1 lần -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- JS: toggle password + client validation -->
	<script>
		(function() {
			const pwd = document.getElementById('password');
			const btn = document.getElementById('togglePassword');
			if (btn && pwd) {
				btn
						.addEventListener(
								'click',
								function() {
									const type = pwd.getAttribute('type') === 'password' ? 'text'
											: 'password';
									pwd.setAttribute('type', type);
									btn.innerHTML = type === 'password' ? `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16"><path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8z"/><path d="M8 5.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5z"/></svg>`
											: `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash" viewBox="0 0 16 16"><path d="M13.359 11.238C14.205 10.36 15 9.238 15 8c0-1.238-.795-2.36-1.641-3.238a13.134 13.134 0 0 0-1.9-1.586L1.354 13.292l.708.708 2.143-2.143A7.623 7.623 0 0 0 8 13.5c2.881 0 5.32-1.737 6.87-3.839l-.511-.423z"/><path d="M11.464 9.464A3 3 0 0 1 6.536 4.536L11.464 9.464z"/></svg>`;
								});
			}

			// Bootstrap-like validation
			const form = document.getElementById('loginForm');
			if (form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault();
						event.stopPropagation();
					} else {
						// form will submit to dangnhapcontroller via POST
						// optionally you can handle via AJAX here
					}
					form.classList.add('was-validated');
				}, false);
			}
		})();
		document.addEventListener('DOMContentLoaded', function() {
			const alert = document.querySelector('.alert');
			if (alert) {
				setTimeout(function() {
					// Sử dụng API của Bootstrap để đóng alert mượt mà
					const bsAlert = new bootstrap.Alert(alert);
					bsAlert.close();
				}, 3000); // Bạn có thể thay đổi thời gian ở đây (3000 = 3 giây)
			}
		});
	</script>

</body>
</html>
