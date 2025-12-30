package com.example.Qlykhachsan.Model;

import java.sql.Date;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "roomBooking")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class RoomBooking {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "roominfo_id")
	private Integer roominfoId;

	@Column(name = "room_id")
	private Integer roomId;

	@ManyToOne
	@JoinColumn(name = "client_id")
	private Clients clientId;

	@Column(name = "type_rooms")
	private String typeRooms;

	@Column(name = "rooms_price")
	private double roomsPrice;

	@Column(name = "date_order")
	private Date dateOrder;
	@Column(name = "Name")
	private String name;
	@Column(name = "phoneNumber")
	private String phoneNumber;
	@Column(name = "date_checkout")
	private Date dateCheckout;
	@Column(name = "roomNumber")
	private Integer roomNumber;
	@Column(name = "numberOfclient")
	private Integer numberOfclient;
	@Column(name = "total_amount")
	private double totalPrice;
	@Column(name = "paymentMethod")
	private String paymentMethod;
	@Column(name = "status_payment")
	private String statusPayment;
	// Thêm mã giao dịch để đối chiếu với VNPAY
	@Column(name = "vnp_txn_ref")
	private String vnpTxnRef;
	@Column(name = "datePayment")
	private LocalDate datePayment;
	@Column(name = "points_used")
	private int pointsUsed = 0;

}