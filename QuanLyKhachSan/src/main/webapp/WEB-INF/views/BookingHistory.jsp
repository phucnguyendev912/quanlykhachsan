<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking History</title>
<link href="/css/BookingHistory.css" rel="styleSheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<jsp:include page="Header.jsp" />

	<div class="main-content">
		<h2>Lịch sử đặt dịch vụ / phòng</h2>

		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>Loại</th>
						<th>Tên</th>
						<th>Ngày đặt</th>
						<th>Ngày trả</th>
						<th>Thời gian</th>
						<th>Số lượng</th>
						<th>Tổng tiền</th>
						<th>Trạng thái</th>
						<th>Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="b" items="${histories}">
						<tr>
							<td>${b.type}</td>
							<td>${b.itemName}</td>
							<td>${b.bookingDate}</td>
							<td>${b.dateCheckout}</td>
							<td>${b.usageTime}</td>
							<td>${b.quantity}</td>

							<td><fmt:formatNumber value="${b.totalPirce}" type="number" />
								VNĐ</td>

							<td>${b.status}</td>

							<td><c:if test="${b.status eq 'Chờ thanh toán'}">
									<c:if test="${b.type == 'Room'}">
										<a
											href="${pageContext.request.contextPath}/retry-payment/${b.id}"
											class="btn btn-warning">Thanh toán</a>
									</c:if>

									<c:if test="${b.type == 'Facility'}">
										<a
											href="${pageContext.request.contextPath}/retry-payment-facility/${b.id}"
											class="btn btn-warning">Thanh toán</a>
									</c:if>
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>