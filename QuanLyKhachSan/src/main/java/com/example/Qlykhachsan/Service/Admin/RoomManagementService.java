package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Rooms;
import com.example.Qlykhachsan.Repository.Admin.RoomManagementAdminRepository;

@Service
public class RoomManagementService {
	@Autowired
	private RoomManagementAdminRepository roomManagementAdminRepository;

	public List<Rooms> listroom() {
		return roomManagementAdminRepository.findAll();
	}

	public Rooms addroom(Rooms r) {
		return roomManagementAdminRepository.save(r);
	}
	public Rooms getRoomById(int roomid) {
	    // Hàm này tìm phòng trong DB, 
	    return roomManagementAdminRepository.findById(roomid).get(); 
	}

	public void DeleteRoom(int roomId) {
		roomManagementAdminRepository.deleteById(roomId);
	}
}
