package com.example.Qlykhachsan.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Map;
import java.util.List;

@Service
public class chatService {
	private final String API_KEY = "sk-3116fc5f05a64f7f96674d2b98a6042e";
	private final String API_URL = "https://api.deepseek.com/chat/completions";
	@Autowired
	private HotelKnowledgeService hotelKnowledgeService;

	public String getChatResponse(String userMsg) throws Exception {
		String knowledge = hotelKnowledgeService.loadknowledegePrompt("D://MyHotelProject//room.xlsx");
		System.out.println("===== KNOWLEDGE =====");
		System.out.println(knowledge);
		System.out.println("=====================");
		String systemPrompt = """
				Bạn là Win – lễ tân ảo của My Hotel.
				Chỉ trả lời dựa trên dữ liệu sau:
				""" + knowledge + """
				Nếu không có thông tin, hãy nói hiện tại không có dịch vụ  hoặc phòng phù hợp.
				""";

		HttpClient client = HttpClient.newHttpClient();
		
		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> body = Map.of("model", "deepseek-chat", "messages",
				List.of(Map.of("role", "system", "content", systemPrompt), Map.of("role", "user", "content", userMsg)));
		
		HttpRequest request = HttpRequest.newBuilder().uri(URI.create(API_URL))
				.header("Content-Type", "application/json").header("Authorization", "Bearer " + API_KEY)
				.POST(HttpRequest.BodyPublishers.ofString(mapper.writeValueAsString(body))).build();//convert map sang json String

		HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());//nhận json response dạng String
		return mapper.readTree(response.body()).path("choices").get(0).path("message").path("content").asText();
	}
}