package com.example.Qlykhachsan.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
	// tim role theo ten(dung optional de tranh loi null
	Optional<Role> findByroleName(String roleName);
}
