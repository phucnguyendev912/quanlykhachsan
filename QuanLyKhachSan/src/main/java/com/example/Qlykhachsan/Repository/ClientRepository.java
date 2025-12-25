package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Clients;

@Repository
public interface ClientRepository extends JpaRepository<Clients, Integer> {
	public Clients findByClientId(Clients clientId);
}
