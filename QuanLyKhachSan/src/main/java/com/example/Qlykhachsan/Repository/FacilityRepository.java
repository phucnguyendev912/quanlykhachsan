package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Facility;

@Repository
public interface FacilityRepository extends JpaRepository<Facility, Integer> {

}
