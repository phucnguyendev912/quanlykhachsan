package com.example.Qlykhachsan.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.RoomBooking;

@Repository
public interface RoomBookingRepository extends JpaRepository<RoomBooking, Integer> {
	RoomBooking findByVnpTxnRef(String vnpTxnRef);
//lich su dat phong
	List<RoomBooking> findByClientId(Clients clientId);
	

}
