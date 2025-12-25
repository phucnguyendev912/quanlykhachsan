package com.example.Qlykhachsan.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Model.FacilityBooking;

@Repository
public interface FacilityBookingRepository extends JpaRepository<FacilityBooking, Integer> {
	FacilityBooking findByVnpTxnRef(String vnpTxnRef);

	List<FacilityBooking> findByClientId(Clients clientId);

}
