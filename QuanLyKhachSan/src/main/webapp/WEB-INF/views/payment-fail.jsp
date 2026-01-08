<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thanh toán thất bại</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<style>
body {
	background: linear-gradient(135deg, #f8d7da, #f5c2c7);
	min-height: 100vh;
	margin: 0;
}

/* wrapper căn giữa */
.page-wrapper {
	min-height: calc(100vh - 80px);
	display: flex;
	align-items: center;
	justify-content: center;
}

.fail-card {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .15);
	padding: 40px;
	max-width: 520px;
	width: 100%;
	text-align: center;
	animation: fadeIn .6s ease-in-out;
}

.icon-fail {
	font-size: 80px;
	color: #dc3545;
	margin-bottom: 20px;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>

<body>

	<!-- HEADER -->
	<jsp:include page="Header.jsp" />

	<!-- CONTENT -->
	<div class="page-wrapper">
		<div class="fail-card">
			<div class="icon-fail">
				<i class="fa-solid fa-circle-xmark"></i>
			</div>

			<h2 class="text-danger fw-bold mb-3">Thanh toán thất bại</h2>

			<p class="text-muted fs-5">
				<c:out value="${message}"
					default="Giao dịch không thành công hoặc đã bị hủy." />
			</p>

			<hr>

			<div class="d-grid gap-2 mt-4">
				<a href="/bookinghistory" class="btn btn-outline-danger btn-lg">
					<i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đặt phòng
				</a> <a href="/LandingPage" class="btn btn-secondary btn-lg"> <i
					class="fa-solid fa-house"></i> Về trang chủ
				</a>
			</div>
		</div>
	</div>

</body>
</html>
