package com.example.Qlykhachsan.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.RoomInfor;
import com.example.Qlykhachsan.Repository.RoomInfoRepository;

@Service
public class RoomInforService {
	@Autowired
	private RoomInfoRepository roomInfoRepository;

	public RoomInfor saveBooking(RoomInfor roomInfo) {
		return roomInfoRepository.save(roomInfo);
	}

	public RoomInfor getByTxnRef(String txnRef) {
		return roomInfoRepository.findByVnpTxnRef(txnRef);
	}
}
