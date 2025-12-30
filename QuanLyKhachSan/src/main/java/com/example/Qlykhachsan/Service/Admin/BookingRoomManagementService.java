package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.RoomBooking;
import com.example.Qlykhachsan.Repository.RoomBookingRepository;

@Service
public class BookingRoomManagementService {
	@Autowired
	private RoomBookingRepository roomBookingRepository;

	public List<RoomBooking> getRoomBooking() {
		return roomBookingRepository.findAll();
	}
}
