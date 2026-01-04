document.addEventListener("DOMContentLoaded", function() {
    
    // Kiểm tra xem biến từ JSP có tồn tại không để tránh lỗi
    if (typeof roomDataGlobal === 'undefined' || typeof facilityDataGlobal === 'undefined') {
        console.error("Không tìm thấy dữ liệu từ JSP!");
        return;
    }

    const ctx = document.getElementById('revenueChart');
    if (!ctx) return; // Nếu không có thẻ canvas thì dừng

    new Chart(ctx.getContext('2d'), {
        type: 'bar', 
        data: {
            labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
            datasets: [
                {
                    label: 'Doanh thu Phòng',
                    data: roomDataGlobal, // <--- Dùng biến toàn cục ở đây
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1,
                    stack: 'Stack 0',
                },
                {
                    label: 'Doanh thu Dịch vụ',
                    data: facilityDataGlobal, // <--- Dùng biến toàn cục ở đây
                    backgroundColor: 'rgba(255, 206, 86, 0.7)',
                    borderColor: 'rgba(255, 206, 86, 1)',
                    borderWidth: 1,
                    stack: 'Stack 0',
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
                x: { stacked: true },
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