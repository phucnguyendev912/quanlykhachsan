package com.example.Qlykhachsan.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "client") // Tên bảng trong Database
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Clients {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "client_id")
	private Integer clientId;

	// Mối quan hệ 1-1: Một người dùng (User) là một Khách hàng (Client)
	@OneToOne
	@JoinColumn(name = "user_id", referencedColumnName = "user_id")
	private User user;

	@Column(name = "point")
	private Integer point = 0;
}