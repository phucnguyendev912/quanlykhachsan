package com.example.Qlykhachsan.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "role") // Tên bảng trong database
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Role {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "role_id")
	private Integer roleId;

	@Column(name = "rolename", length = 255, nullable = false)
	private String roleName;

	@Column(name = "Description", length = 100)
	private String description;

	@Column(name = "status", length = 50)
	private String status;
}