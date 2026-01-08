<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thanh toán thành công</title>

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
	background: linear-gradient(135deg, #d1e7dd, #badbcc);
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

.success-card {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .15);
	padding: 40px;
	max-width: 520px;
	width: 100%;
	text-align: center;
	animation: fadeIn .6s ease-in-out;
}

.icon-success {
	font-size: 80px;
	color: #198754;
	margin-bottom: 20px;
}

.info-row {
	font-size: 1.05rem;
	margin-bottom: 10px;
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
		<div class="success-card">
			<div class="icon-success">
				<i class="fa-solid fa-circle-check"></i>
			</div>

			<h2 class="text-success fw-bold mb-3">Thanh toán thành công 🎉</h2>

			<p class="text-muted fs-5">Cảm ơn bạn đã sử dụng dịch vụ của
				chúng tôi.</p>

			<hr>

			<div class="text-start mt-3">
				<p class="info-row">
					<i class="fa-solid fa-receipt me-2 text-success"></i> <strong>Mã
						giao dịch:</strong> ${vnp_TxnRef}
				</p>
				<p class="info-row">
					<i class="fa-solid fa-money-bill-wave me-2 text-success"></i> <strong>Số
						tiền:</strong> ${amount} VND
				</p>
				<p class="info-row">
					<i class="fa-solid fa-building-columns me-2 text-success"></i> <strong>Ngân
						hàng:</strong> ${vnp_BankCode}
				</p>
			</div>

			<div class="d-grid gap-2 mt-4">
				<a href="/bookinghistory" class="btn btn-success btn-lg"> <i
					class="fa-solid fa-clock-rotate-left"></i> Lịch sử đặt phòng
				</a> <a href="/LandingPage" class="btn btn-outline-secondary btn-lg">
					<i class="fa-solid fa-house"></i> Về trang chủ
				</a>
			</div>
		</div>
	</div>

</body>
</html>
