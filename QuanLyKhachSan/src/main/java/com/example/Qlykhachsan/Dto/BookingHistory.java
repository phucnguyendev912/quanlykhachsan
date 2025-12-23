package com.example.Qlykhachsan.Dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class BookingHistory {
	private String type;
	private int id;
	private String itemName;
	private Date bookingDate;
	private Date useDate;
	private double totalPirce;
	private String status;
}
