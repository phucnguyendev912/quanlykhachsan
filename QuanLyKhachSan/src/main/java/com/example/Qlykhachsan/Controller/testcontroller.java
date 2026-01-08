package com.example.Qlykhachsan.Controller;


import org.springframework.stereotype.Controller;

import com.example.Qlykhachsan.Service.HotelKnowledgeService;

@Controller
public class testcontroller {
	
	
	public static void main(String[] args) {
		HotelKnowledgeService ht= new HotelKnowledgeService();
		ht.loadknowledegePrompt("C:/Users/nguye/OneDrive/Desktop/room.xlsx");
	}
}
