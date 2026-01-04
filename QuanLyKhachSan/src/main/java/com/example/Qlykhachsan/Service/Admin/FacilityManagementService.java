package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Repository.Admin.FacilityManagementAdminRepository;

@Service
public class FacilityManagementService {
	@Autowired
	private FacilityManagementAdminRepository facilityManagementAdminRepository;

	public List<Facility> findAll() {
		return facilityManagementAdminRepository.findAll();
	}

	public Facility getfacilytiById(Integer facilytiId) {
		return facilityManagementAdminRepository.findById(facilytiId).orElse(null);
	}

	public Facility addFacility(Facility facilityId) {
		return facilityManagementAdminRepository.save(facilityId);
	}

	public void deleteFacility(int facilityId) {
		 facilityManagementAdminRepository.deleteById(facilityId);
	}
}
