document.addEventListener("DOMContentLoaded", function() {
	const checkInInput = document.getElementById('checkIn');
	const checkOutInput = document.getElementById('checkOut');
	const totalAmountEl = document.getElementById('totalAmount');
	const numNightsEl = document.getElementById('numNights');
	const hiddenTotalPrice = document.getElementById('hiddenTotalPrice');
	const usePointCheckbox = document.getElementById('usePoint'); // Checkbox dùng điểm
	const discountInfoDiv = document.getElementById('discountInfo'); // Div thông báo

	// Lấy giá phòng từ HTML
	const basePrice = parseFloat(document.getElementById('roomPriceDisplay').getAttribute('data-price'));

	// Lấy số điểm hiện có từ HTML (Nếu chưa đăng nhập hoặc không tìm thấy thì gán = 0)
	const pointsElement = document.getElementById('userPoints');
	const availablePoints = pointsElement ? parseInt(pointsElement.getAttribute('data-points')) : 0;

	// Thiết lập ngày tối thiểu là hôm nay
	const today = new Date().toISOString().split('T')[0];
	checkInInput.setAttribute('min', today);
	checkOutInput.setAttribute('min', today);

	function calculateTotal() {
		const checkInDate = new Date(checkInInput.value);
		const checkOutDate = new Date(checkOutInput.value);

		if (checkInInput.value && checkOutInput.value) {
			if (checkOutDate > checkInDate) {
				// 1. Tính số đêm
				const diffTime = Math.abs(checkOutDate - checkInDate);
				const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

				// 2. Tính tổng tiền gốc
				let total = diffDays * basePrice;

				// 3. Logic TRỪ ĐIỂM (Mới thêm)
				if (usePointCheckbox && usePointCheckbox.checked && availablePoints > 0) {
					// Quy đổi 1 điểm = 1000 VNĐ
					const maxDiscount = availablePoints * 1000;

					if (maxDiscount >= total) {
						total = 0; // Nếu điểm nhiều hơn tiền phòng -> Miễn phí
					} else {
						total = total - maxDiscount; // Trừ số tiền tương ứng
					}

					// Hiện thông báo đã giảm
					if (discountInfoDiv) discountInfoDiv.style.display = 'block';
				} else {
					// Ẩn thông báo nếu không dùng
					if (discountInfoDiv) discountInfoDiv.style.display = 'none';
				}

				// Cập nhật giao diện
				numNightsEl.innerText = diffDays;
				totalAmountEl.innerText = total.toLocaleString('vi-VN') + " VNĐ";

				// Cập nhật hidden input để gửi về Controller
				hiddenTotalPrice.value = total;
			} else {
				numNightsEl.innerText = "0";
				totalAmountEl.innerText = "0 VNĐ";
			}
		}
	}

	// --- CÁC SỰ KIỆN ---

	// 1. Khi đổi ngày nhận phòng
	checkInInput.addEventListener('change', function() {
		if (this.value) {
			const nextDay = new Date(this.value);
			nextDay.setDate(nextDay.getDate() + 1);
			const nextDayString = nextDay.toISOString().split('T')[0];
			checkOutInput.setAttribute('min', nextDayString);

			if (checkOutInput.value && checkOutInput.value < nextDayString) {
				checkOutInput.value = nextDayString;
			}
			calculateTotal();
		}
	});

	// 2. Khi đổi ngày trả phòng
	checkOutInput.addEventListener('change', calculateTotal);

	// 3. Khi bấm vào checkbox Dùng điểm -> Phải tính lại tiền ngay
	if (usePointCheckbox) {
		usePointCheckbox.addEventListener('change', calculateTotal);
	}
});