package com.example.Qlykhachsan.Service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.Qlykhachsan.Dto.LoginRequest;
import com.example.Qlykhachsan.Dto.RegisterRequest;
import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.Role;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Repository.AccountRepository;
import com.example.Qlykhachsan.Repository.ClientRepository;
import com.example.Qlykhachsan.Repository.RoleRepository;
import com.example.Qlykhachsan.Repository.UserRepository;

@Service
public class AuthService {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private AccountRepository accountRepository;
	@Autowired
	private ClientRepository clientRepository;
	@Autowired
	private RoleRepository roleRepository;

	@Transactional
	public boolean register(RegisterRequest request) {
		// 1 kiem tra xem username da ton tai chua
		if (accountRepository.existsByAccountName(request.getUsername())) {
			throw new RuntimeException("Tên đăng nhập đã tồn tại, vui lòng chọn tên đăng nhập khác");
		}
		// 2 tạo user(lưu thông tin cá nhân trước để lấy id)
		User users = new User();
		users.setFullname(request.getFullname());
		users.setDob(request.getDob());
		users.setSex(request.getSex());
		users.setPhoneNumber(request.getPhoneNumber());
		users.setAddress(request.getAddress());
		users.setEmail(request.getEmail());
		users.setStatus("Active");
		User savedUser = userRepository.save(users);
		// 3.tạo role nếu chưa có trong db
		// dung lambada expession
		Role roleUser = roleRepository.findByroleName("client").orElseGet(() -> {
			Role newRole = new Role();
			newRole.setRoleName("client");
			newRole.setDescription("Khách hàng");
			newRole.setStatus("Active");
			return roleRepository.save(newRole);
		});
		// 4.Tao account
		Account newAccount = new Account();
		newAccount.setAccountName(request.getUsername());
		newAccount.setPassword(request.getPassword()); // chua ma hoa
		newAccount.setUser(savedUser);
		newAccount.setRole(roleUser);
		accountRepository.save(newAccount);
		// 5.tao client new role la client thì tao ho so tich diem
		if (roleUser.getRoleName().equalsIgnoreCase("client")) {
			Clients newClients = new Clients();
			newClients.setUser(savedUser);
			newClients.setPoint(0);
			clientRepository.save(newClients);
		}
		return true;
	}

	// login
	public Account login(LoginRequest loginRequest) {
		// dung optional de tranh null
		// lay ten nguoi dung tu form ve thong qua pakage dto sau do ham
		// finByAccountName se tim trong database co trung voi ten dang
		// nhap duoc lay ve khong
		Optional<Account> opAccount = accountRepository.findByAccountName(loginRequest.getUsername());
		if (opAccount.isPresent()) {
			// lay doi tuong account
			Account account = opAccount.get();
			if (account.getPassword().equals(loginRequest.getPassword())) {
				return account;
			}
		}
		return null;
	}

}
