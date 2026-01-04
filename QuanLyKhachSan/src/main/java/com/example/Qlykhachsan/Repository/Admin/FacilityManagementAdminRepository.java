package com.example.Qlykhachsan.Repository.Admin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Facility;

@Repository
public interface FacilityManagementAdminRepository extends JpaRepository<Facility, Integer>{

}
