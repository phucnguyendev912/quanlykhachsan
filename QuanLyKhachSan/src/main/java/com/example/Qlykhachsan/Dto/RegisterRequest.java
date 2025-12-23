package com.example.Qlykhachsan.Dto;

import lombok.Data;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

@Data
public class RegisterRequest {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	// Thông tin đăng nhập
	private String username; 
	private String password;
	private String fullname; 
	private String email;
	private String phoneNumber;
	private String address;
	private Boolean sex;
	private String status;
	private Date dob;
}