package com.example.Qlykhachsan.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;

@Entity
@Table(name = "[user]")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id", nullable = false) 
	private Integer userId; 

	@Column(name = "fullname", length = 250, nullable = false)
	private String fullname; 

	@Column(name = "dob", nullable = false)
	private Date dob;

	@Column(name = "sex", nullable = false)
	private Boolean sex;

	@Column(name = "phonenumber", length = 15, nullable = false)
	private String phoneNumber;

	@Column(name = "address", length = 250, nullable = false)
	private String address;

	@Column(name = "status", length = 50)
	private String status;
	@Column(name = "email", length = 50)
	private String email;
}