package com.example.Qlykhachsan.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Repository.RoomRepository;

@Service
public class RoomService {
	@Autowired
	private RoomRepository roomRepository;

	public Page<Rooms> getAllRooms(String statusroom, int pageNumber) {
		// trang bat dau tu 0
		// neu bam trang 1 thi se lay 0-1
		int pageindex = (pageNumber > 0) ? pageNumber - 1 : 0;
		int pagesize = 8;
		// lay bao nhieu trang va bao nhieu dong
		// tuong tu lenh limit va offset
		Pageable pageable = PageRequest.of(pageindex, pagesize, Sort.by("sortOrder").ascending());
		return roomRepository.findBystatusroom(statusroom, pageable);

	}

	public Rooms getRoomById(Integer roomId) {
		Optional<Rooms> listRoom = roomRepository.findById(roomId);
		return listRoom.orElse(null);
	}

	public Rooms save(Rooms roomid) {
		return roomRepository.save(roomid);
	}

	public List<Rooms> getRelatedRooms(int currentRoomId) {
		Rooms currentRoom = getRoomById(currentRoomId);
		if (currentRoom == null) {
			return new ArrayList<>();
		}
		double price = currentRoom.getPriceRoom();
		double minprice = price * 0.8;
		double maxprice = price * 1.2;
		return roomRepository.findRelatedRooms(minprice, maxprice, currentRoomId);
	}

	public List<Rooms> searchRoom(String keyword) {
		if (keyword != null) {
			return roomRepository.searchRooms(keyword);
		}
		return roomRepository.findAll(); // Nếu không tìm gì thì trả về tất cả
	}
}
