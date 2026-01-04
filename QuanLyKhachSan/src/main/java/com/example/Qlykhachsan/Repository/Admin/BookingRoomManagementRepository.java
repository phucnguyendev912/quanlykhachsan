package com.example.Qlykhachsan.Repository.Admin;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Dto.Statistics;
import com.example.Qlykhachsan.Model.RoomBooking;

@Repository
public interface BookingRoomManagementRepository extends JpaRepository<RoomBooking, Integer>{
	@Query(value = "SELECT MONTH(r.date_checkout) as month, SUM(r.total_amount) as total " + "FROM roomBooking r "
			+ "WHERE YEAR(r.date_checkout) = :year AND r.status_payment = N'Đã thanh toán' " + // Nhớ lọc trạng thái đã thanh toán
			"GROUP BY MONTH(r.date_checkout)", nativeQuery = true)
	//tra ve danh sach cac  doi tuong chua thang va tong tien
	List<Statistics> statisticRoomRevenue(@Param("year") Integer year);
}
