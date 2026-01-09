package com.example.Qlykhachsan.Repository.Admin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Account;

@Repository
public interface AccountAdminRepository extends JpaRepository<Account, Integer> {

}
