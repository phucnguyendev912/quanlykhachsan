package com.example.Qlykhachsan.Service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Facility;
import com.example.Qlykhachsan.Repository.FacilityRepository;

@Service
public class FacilityService {
	@Autowired
	private FacilityRepository facilityRepository;

	public Page<Facility> getallFacility(int pageNumber) {
		int pageIndex = (pageNumber > 0) ? pageNumber - 1 : 0;
		int pagesize = 8;
		Pageable page = PageRequest.of(pageIndex, pagesize);
		return facilityRepository.findAll(page);
	}

	public Facility getFacilityById(Integer facilityId) {
		return facilityRepository.findById(facilityId).orElse(null);
	}

}
