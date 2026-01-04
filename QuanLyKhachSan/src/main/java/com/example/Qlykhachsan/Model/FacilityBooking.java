package com.example.Qlykhachsan.Model;

import java.sql.Date;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "ServiceBookings")
public class FacilityBooking {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "booking_id", nullable = false)
	private Integer serviceBookingId;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Service_id", nullable = false)
	private Facility facility;
	@Column(name = "service_name", nullable = false)
	private String facilityName;
	@ManyToOne
	@JoinColumn(name = "client_id", nullable = false)
	private Clients client;
	@Column(name = "booking_date", nullable = true)
	private Date bookingDate;
	@Column(name = "servicePrice", nullable = true)
	private double facilityPrice;
	@Column(name = "usage_time", nullable = true)
	private String usageTime;
	@Column(name = "quantity", nullable = true)
	private Integer numberOf;
	@Column(name = "notes", nullable = true)
	private String notes;
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
}
