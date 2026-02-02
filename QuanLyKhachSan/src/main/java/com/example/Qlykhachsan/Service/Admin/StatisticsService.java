package com.example.Qlykhachsan.Service.Admin;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Dto.Statistics;
import com.example.Qlykhachsan.Repository.Admin.BookingRoomManagementRepository;
import com.example.Qlykhachsan.Repository.Admin.FacilityBookingManagementAdminRepository;

@Service
public class StatisticsService {
	@Autowired
	private FacilityBookingManagementAdminRepository facilityBookingManagementAdminRepository;
	@Autowired
	private BookingRoomManagementRepository bookingRoomManagementRepository;

	public List<Double> getRoomRevenueOnly(int year) {
		//lay danh sach cac thang co doanh thu
		List<Statistics> stats = bookingRoomManagementRepository.statisticRoomRevenue(year);
		//dung de ve chart dung dinh dang khong bi lech nhung thang co doanh thu vao nhung thang hong co doanh thu
		List<Double> result = new ArrayList<>(Collections.nCopies(12, 0.0));
		mergeRevenue(result, stats);
		return result;
	}

	// 2. Hàm lấy riêng doanh thu DỊCH VỤ
	public List<Double> getFacilityRevenueOnly(int year) {
		List<Statistics> stats = facilityBookingManagementAdminRepository.statisticFacilityRevenue(year);
		List<Double> result = new ArrayList<>(Collections.nCopies(12, 0.0));
		mergeRevenue(result, stats);
		return result;
	}

	// Hàm phụ trợ 
	//truyen vao 2 list: sourceStats: de chua cac du lieu lay tu db gui len
	//targetList : dung de chua 12 so 0 cua 12 thang
	private void mergeRevenue(List<Double> targetList, List<Statistics> sourceStats) {
		//duyet tung ban ghi duoc lay tu db len
		for (Statistics s : sourceStats) {
			// kiem tra thang
			if (s.getMonth() != null && s.getMonth() >= 1 && s.getMonth() <= 12) {
				// neu thang 1 index la 0...
				int index = s.getMonth() - 1;
				// gan doanh thu vao cac thang cho dung voi thang do
				targetList.set(index, sourceStats.get(sourceStats.indexOf(s)).getTotal());
			}
		}
	}
}
