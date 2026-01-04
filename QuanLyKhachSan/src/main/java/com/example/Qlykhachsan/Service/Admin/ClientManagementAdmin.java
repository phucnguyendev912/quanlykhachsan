package com.example.Qlykhachsan.Service.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Repository.ClientRepository;

@Service
public class ClientManagementAdmin {
	@Autowired
	private ClientRepository clientRepository;
	public List<Clients>getall(){
		return clientRepository.findAll();
	}
}
