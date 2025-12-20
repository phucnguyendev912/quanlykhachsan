package com.example.Qlykhachsan.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

}
