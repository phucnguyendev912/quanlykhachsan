package com.example.Qlykhachsan.Service;

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
		Pageable pageable = PageRequest.of(pageNumber - 1, pagesize, Sort.by("sortOrder").ascending());
		return roomRepository.findBystatusroom(statusroom, pageable);

	}

	public Rooms getRoomById(Integer roomId) {
		Optional<Rooms> listRoom = roomRepository.findById(roomId);
		return listRoom.orElse(null);
	}

	public Rooms save(Rooms roomid) {
		return roomRepository.save(roomid);
	}
}
