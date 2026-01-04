package com.example.Qlykhachsan.Service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Dto.BookingHistory;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Model.RoomBooking;

import com.example.Qlykhachsan.Repository.FacilityBookingRepository;
import com.example.Qlykhachsan.Repository.RoomBookingRepository;

@Service
public class BookingHistoryService {
	@Autowired
	private RoomBookingRepository roomBookingRepository;
	@Autowired
	private FacilityBookingRepository facilityBookingRepository;

	public List<BookingHistory> getBookingHistory(Clients clientId) {
		List<BookingHistory> result = new ArrayList<BookingHistory>();
		for (RoomBooking rb : roomBookingRepository.findByClientId(clientId)) {
			result.add(new BookingHistory("Room", rb.getRoominfoId(), rb.getTypeRooms(), rb.getDateOrder(),
					rb.getDateCheckout(), null, rb.getNumberOfclient(), rb.getTotalPrice(), rb.getStatusPayment()));
		}
		for (FacilityBooking fb : facilityBookingRepository.findByClient(clientId)) {
			result.add(
					new BookingHistory("Facility", fb.getServiceBookingId(), fb.getFacilityName(), fb.getBookingDate(),
							null, fb.getUsageTime(), fb.getNumberOf(), fb.getTotalPrice(), fb.getStatusPayment()));
		}
		return result;

	}
}
