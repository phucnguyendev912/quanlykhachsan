package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.FacilityBooking;
import com.example.Qlykhachsan.Repository.Admin.FacilityBookingManagementAdminRepository;

@Service
public class FacilityBookingManagementAdminService {
	@Autowired
	private FacilityBookingManagementAdminRepository facilityBookingManagementAdminRepository;
	public List<FacilityBooking>getallfacilityBooking(){
		return facilityBookingManagementAdminRepository.findAll();
	}
	public void delete(int facilityId) {
		facilityBookingManagementAdminRepository.deleteById(facilityId);
	}
}
