package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.RoomBooking;

@Repository
public interface HistoryOrderRepository extends JpaRepository<RoomBooking, Integer> {

}
