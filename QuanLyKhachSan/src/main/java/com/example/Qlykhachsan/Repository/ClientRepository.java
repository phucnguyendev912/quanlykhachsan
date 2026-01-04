package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Clients;
import com.example.Qlykhachsan.Model.User;

@Repository
public interface ClientRepository extends JpaRepository<Clients, Integer> {
	public Clients findByClientId(Integer clientId);
	 Clients findByUser(User user);
}
