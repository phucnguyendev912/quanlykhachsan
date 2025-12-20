package com.example.Qlykhachsan.Model;

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
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "service")
public class services {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Service_id", nullable = false)
	private int serviceId;
	@Column(name = "Service_name", nullable = true, length = 50)
	private String serviceName;
	@Column(name = "Service_price", nullable = true)
	private double servicePrice;
	@Column(name = "Image", nullable = true, length = 50)
	private String image;
	@Column(name = "Description", nullable = true, length = 250)
	private String description;
	@Column(name = "TimeApply_Service", nullable = true)
	private String timeApplyService;

}
