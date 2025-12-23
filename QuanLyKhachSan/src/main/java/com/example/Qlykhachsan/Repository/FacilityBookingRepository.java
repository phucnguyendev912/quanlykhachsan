package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Model.FacilityBooking;

@Repository
public interface FacilityBookingRepository extends JpaRepository<FacilityBooking, Integer> {
	FacilityBooking findByVnpTxnRef(String vnpTxnRef);
}
