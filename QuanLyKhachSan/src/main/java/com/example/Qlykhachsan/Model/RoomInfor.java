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

@Entity
@Table(name = "roomsinfo")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class RoomInfor {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "roominfo_id")
	private Integer roominfoId;

	@Column(name = "room_id")
	private Integer roomId;

	@Column(name = "client_id")
	private Integer clientId;

	@Column(name = "type_rooms")
	private String typeRooms;

	@Column(name = "rooms_price")
	private double roomsPrice;

	@Column(name = "date_order")
	private Date dateOrder;

	@Column(name = "date_checkout")
	private Date dateCheckout;

	@Column(name = "numberOfclient")
	private Integer numberOfclient;
	@Column(name = "total_amount")
	private double totalPrice;
	@Column(name = "paymentMethod")
	private String paymentMethod;

	// Thêm trường này để quản lý trạng thái thanh toán
	@Column(name = "status_payment")
	private String statusPayment = "Chờ thanh toán";

	// Thêm mã giao dịch để đối chiếu với VNPAY
	@Column(name = "vnp_txn_ref")
	private String vnpTxnRef;
}
