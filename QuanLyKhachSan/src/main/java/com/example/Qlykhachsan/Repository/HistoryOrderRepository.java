package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.Qlykhachsan.Model.RoomInfor;

@Repository
public interface HistoryOrderRepository extends JpaRepository<RoomInfor, Integer> {

}
