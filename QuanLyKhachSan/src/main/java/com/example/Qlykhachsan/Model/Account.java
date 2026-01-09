package com.example.Qlykhachsan.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "account")
public class Account {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "account_id")
	private Integer accountId; 

	@Column(name = "account_name", length = 50, nullable = false)
	private String accountName;

	@Column(name = "password", length = 50, nullable = false)
	private String password;

	@ManyToOne
	@JoinColumn(name = "role_id")
	private Role role;

	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;
}
