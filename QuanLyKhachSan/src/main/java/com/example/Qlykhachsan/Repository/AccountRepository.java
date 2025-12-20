package com.example.Qlykhachsan.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Account;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
	// kiem tra xem ten dang nhap da ton tai chua
	boolean existsByAccountName(String accountName);

	Optional<Account> findByAccountName(String accountName);
}
