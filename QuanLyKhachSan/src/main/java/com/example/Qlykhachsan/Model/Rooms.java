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
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "room")
public class Rooms {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "room_id", nullable = false)
	private int roomId;
	@Column(name = "room_number", nullable = true)
	private int roomNumber;
	@Column(name = "type_room", nullable = true)
	private String typeRoom;
	@Column(name = "status_room", nullable = true, length = 50)
	private String statusroom;
	@Column(name = "price_room", nullable = true)
	private double priceRoom;
	@Column(name = "number_of_client", nullable = true)
	private int numberOfclient;
	@Column(name = "image", nullable = true, length = 250)
	private String image;
	@Column(name = "acreage", nullable = true)
	private float acreage;
	@Column(name = "description", nullable = true)
	private String description;
	@Column(name = "sort_order")
	private Double sortOrder;

}
