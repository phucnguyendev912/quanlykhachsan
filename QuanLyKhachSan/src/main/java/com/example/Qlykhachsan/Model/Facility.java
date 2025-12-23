package com.example.Qlykhachsan.Model;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "service")
public class Facility {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Service_id", nullable = false)
	private int facilityId;
	@Column(name = "Service_name", nullable = true)
	private String serviceName;
	@Column(name = "Service_price")
	private double servicePrice;
	@Column(name = "Image", nullable = true, length = 50)
	private String image;
	@Column(name = "Description", nullable = true, length = 250)
	private String description;
	@Column(name = "TimeApply_Service", nullable = true, length = 50)
	private String timeapplyService;
}
