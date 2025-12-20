<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thanh toán thành công</title>
</head>
<body>
	<h2 style="color: green;">🎉 Thanh toán thành công!</h2>

	<p>Mã giao dịch: ${vnp_TxnRef}</p>
	<p>Số tiền: ${amount} VND</p>
	<p>Ngân hàng: ${vnp_BankCode}</p>

	<br>
	<a href="/LandingPage">Về trang chủ</a>
</body>
</html>
