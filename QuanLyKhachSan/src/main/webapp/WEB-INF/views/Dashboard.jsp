<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Dashboard - Quản trị</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
.stat-card {
	border: none;
	border-radius: 10px;
	transition: transform 0.3s;
}

.stat-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.clickable-card {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">

			<c:set var="activePage" value="dashboard" />
			<jsp:include page="Sidebar.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Tổng quan</h1>
					<div class="btn-toolbar mb-2 mb-md-0">
						<div class="btn-group me-2">
							<button type="button" class="btn btn-sm btn-outline-secondary">
								<i class="fas fa-download me-1"></i> Xuất báo cáo
							</button>
						</div>
						<span class="text-muted align-self-center"> Xin chào, <strong
							class="text-dark">${adminName != null ? adminName : 'Admin'}</strong>
						</span>
					</div>
				</div>

				

					<div class="col-md-4">
						<div
							class="card stat-card bg-success text-white h-100 clickable-card"
							data-bs-toggle="modal" data-bs-target="#chartModal">
							<div class="card-body">
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<h6 class="card-title text-white-50">Doanh thu tháng này</h6>

										<h2 class="mb-0 fw-bold">
											<fmt:formatNumber value="${currentTotalRevenue}"
												type="currency" currencySymbol="₫" />
										</h2>

										<div class="mt-2"
											style="font-size: 0.85rem; background: rgba(255, 255, 255, 0.2); padding: 5px 10px; border-radius: 5px;">
											<div>
												<i class="fas fa-bed"></i> Phòng: <strong> <fmt:formatNumber
														value="${currentRoomRevenue}" type="currency"
														currencySymbol="₫" />
												</strong>
											</div>
											<div>
												<i class="fas fa-concierge-bell"></i> Dịch vụ: <strong>
													<fmt:formatNumber value="${currentFacilityRevenue}"
														type="currency" currencySymbol="₫" />
												</strong>
											</div>
										</div>
									</div>
									<i class="fas fa-dollar-sign fa-3x opacity-25"></i>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="modal fade" id="chartModal" tabindex="-1"
					aria-labelledby="chartModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="chartModalLabel">
									<i class="fas fa-chart-bar text-success me-2"></i> Biểu đồ
									doanh thu năm ${currentYear}
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<canvas id="revenueChart" width="100%" height="50"></canvas>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Đóng</button>
							</div>
						</div>
					</div>
				</div>

			</main>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. Lấy dữ liệu Phòng 
        var roomData = [
            <c:if test="${not empty roomData}">
	            <c:forEach items="${roomData}" var="amount" varStatus="status">
	                ${amount}<c:if test="${!status.last}">,</c:if>
	            </c:forEach>
            </c:if>
        ];

        // 2. Lấy dữ liệu Dịch vụ 
        var facilityData = [
			<c:if test="${not empty facilityData}">
	            <c:forEach items="${facilityData}" var="amount" varStatus="status">
	                ${amount}<c:if test="${!status.last}">,</c:if>
	            </c:forEach>
            </c:if>
        ];

        const ctx = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar', // Biểu đồ cột
            data: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                datasets: [
                    {
                        label: 'Doanh thu Phòng',
                        data: roomData,
                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1,
                        stack: 'Stack 0', // Chồng cột
                    },
                    {
                        label: 'Doanh thu Dịch vụ',
                        data: facilityData,
                        backgroundColor: 'rgba(255, 206, 86, 0.7)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1,
                        stack: 'Stack 0', // Chồng cột
                    }
                ]
            },
            options: {
                responsive: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                scales: {
                    x: {
                        stacked: true, 
                    },
                    y: {
                        stacked: true, 
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString('vi-VN') + ' ₫';
                            }
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.dataset.label + ': ' + context.parsed.y.toLocaleString('vi-VN') + ' ₫';
                            },
                            footer: function(tooltipItems) {
                                let total = 0;
                                tooltipItems.forEach(function(tooltipItem) {
                                    total += tooltipItem.parsed.y;
                                });
                                return 'Tổng cộng: ' + total.toLocaleString('vi-VN') + ' ₫';
                            }
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>