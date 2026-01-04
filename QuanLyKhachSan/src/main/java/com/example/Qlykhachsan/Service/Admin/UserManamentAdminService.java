package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Account;
import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.User;
import com.example.Qlykhachsan.Repository.AccountRepository;
import com.example.Qlykhachsan.Repository.ClientRepository;
import com.example.Qlykhachsan.Repository.UserRepository;

@Service
public class UserManamentAdminService {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private ClientRepository clientRepository;
	@Autowired
    private AccountRepository accountRepository;
	public List<User> getall() {
		return userRepository.findAll();
	}

	public void saveUser(User user) {
		// 1.luu o bang user dau tien
		boolean isNewUser = (user.getUserId() == null);// kiem tra xem co phai tao moi khong
		User savedUser = userRepository.save(user);
		if (isNewUser) {
			Clients newClient = new Clients();
			newClient.setUser(savedUser);
			newClient.setPoint(0);
			clientRepository.save(newClient);
		}
	}
	public User getuserById(int userId) {
		return userRepository.findById(userId).orElse(null);
	}

	public void deleteUser(Integer id) {
		User user = getuserById(id); // Hàm lấy user
        if (user != null) {
            //Xóa Client trước 
            Clients client = clientRepository.findByUser(user);
            if (client != null) {
                clientRepository.delete(client);
            }
            //Xóa Account 
            Account account = accountRepository.findByUser(user);
            if (account != null) {
                accountRepository.delete(account);
            }
            // xoa user
            userRepository.deleteById(id);
        }
	}
}
