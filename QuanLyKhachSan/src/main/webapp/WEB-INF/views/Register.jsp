<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Form</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container mt-5 mb-5">
		<div class="card shadow-sm mx-auto" style="max-width: 600px;">
			<div class="card-header bg-primary text-white">
				<h4 class="mb-0">Đăng Ký Tài Khoản</h4>
			</div>
			<div class="card-body">
				<form action="/register" method="POST">

					<div class="mb-3">
						<label for="username" class="form-label">Tên đăng nhập
							(Username)</label> <input type="text" class="form-control" id="username"
							name="username" placeholder="Ví dụ: thienphuc2004" required>
					</div>

					<div class="mb-3">
						<label for="password" class="form-label">Mật khẩu</label> <input
							type="password" class="form-control" id="password"
							name="password" placeholder="Nhập mật khẩu..." required>
					</div>

					<div class="mb-3">
						<label for="fullname" class="form-label">Họ và Tên</label> <input
							type="text" class="form-control" id="fullname" name="fullname"
							placeholder="Ví dụ: Nguyen Hoang Thien Phuc" required>
					</div>

					<div class="mb-3">
						<label for="email" class="form-label">Email</label> <input
							type="email" class="form-control" id="email" name="email"
							placeholder="name@example.com" required>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="dob" class="form-label">Ngày sinh</label> <input
								type="date" class="form-control" id="dob" name="dob" required>
						</div>

						<div class="col-md-6 mb-3">
							<label for="phonenumber" class="form-label">Số điện thoại</label>
							<input type="tel" class="form-control" id="phonenumber"
								name="phoneNumber" placeholder="034..." required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label d-block">Giới tính</label>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="sex" id="male"
								value="true" checked> <label class="form-check-label"
								for="male">Nam</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="sex"
								id="female" value="false"> <label
								class="form-check-label" for="female">Nữ</label>
						</div>
					</div>

					<div class="mb-3">
						<label for="address" class="form-label">Địa chỉ</label>
						<textarea class="form-control" id="address" name="address"
							rows="2" placeholder="Nhập địa chỉ..."></textarea>
					</div>

					<div class="d-grid gap-2">
						<button type="submit" class="btn btn-primary">Đăng kí</button>
					</div>

				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>