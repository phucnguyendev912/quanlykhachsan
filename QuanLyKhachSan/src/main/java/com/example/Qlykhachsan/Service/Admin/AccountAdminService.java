package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Repository.Admin.AccountAdminRepository;

@Service
public class AccountAdminService {
	@Autowired
	private AccountAdminRepository accountAdminRepository;

	public List<Account> findAll() {
		return accountAdminRepository.findAll();
	}
}
