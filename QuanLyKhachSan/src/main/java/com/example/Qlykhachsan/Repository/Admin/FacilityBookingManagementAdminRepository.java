package com.example.Qlykhachsan.Repository.Admin;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Dto.Statistics;
import com.example.Qlykhachsan.Model.FacilityBooking;

@Repository
public interface FacilityBookingManagementAdminRepository extends JpaRepository<FacilityBooking, Integer> {
	@Query(value = "SELECT MONTH(f.booking_date) as month, SUM(f.total_amount) as total FROM ServiceBookings f "
		+ "WHERE YEAR(f.booking_date) = :year and f.status_payment=N'Đã thanh toán'  GROUP BY MONTH(f.booking_date)", nativeQuery = true)
	List<Statistics> statisticFacilityRevenue(@Param("year") Integer year);
}
