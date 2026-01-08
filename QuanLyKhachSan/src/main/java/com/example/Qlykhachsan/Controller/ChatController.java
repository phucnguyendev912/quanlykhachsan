package com.example.Qlykhachsan.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.Qlykhachsan.Dto.ChatMessage;

import com.example.Qlykhachsan.Service.chatService;

@RestController
@RequestMapping("/api/chat")
public class ChatController {

	@Autowired
	private chatService chatService;

	@PostMapping("/ask")
	public String ask(@RequestBody ChatMessage request) {
		try {
			String reply = chatService.getChatResponse(request.getContent());
			System.out.println("ai reply: " + reply);
			return reply;
		} catch (Exception e) {
			return "Dạ, hệ thống đang bận, Anh/Chị vui lòng thử lại sau ạ!";
		}
	}
}
