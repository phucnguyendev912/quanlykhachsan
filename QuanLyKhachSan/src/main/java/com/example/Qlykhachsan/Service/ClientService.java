package com.example.Qlykhachsan.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Repository.ClientRepository;

@Service
public class ClientService {
	@Autowired
	private ClientRepository clientRepository;

	@Transactional
	public void deductPoint(Clients client, int pointsUsed) {
		int currentPoint = client.getPoint();
		int newPoint = currentPoint - pointsUsed;
		if (newPoint < 0) {
			newPoint = 0;
		}
		client.setPoint(newPoint);
		clientRepository.save(client);
	}
	public Clients findByClientId(Clients clientid) {
		return clientRepository.findByClientId(clientid);
	}
	
}
