<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>My Hotel - Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            height: 600px;
            background-size: cover;
            background-position: center;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .chat-launcher {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 60px;
            height: 60px;
            background: #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 9999;
            transition: transform 0.3s;
        }
        .chat-launcher:hover { transform: scale(1.1); }

        .chat-container {
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 350px;
            height: 500px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            display: none;
            flex-direction: column;
            z-index: 9999;
            overflow: hidden;
        }

        .chat-header {
            background: #212529;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #chat-messages {
            flex: 1;
            padding: 15px;
            overflow-y: auto;
            background: #f8f9fa;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .msg { padding: 8px 12px; border-radius: 15px; max-width: 80%; font-size: 14px; }
        .msg-user { align-self: flex-end; background: #ffc107; color: black; }
        .msg-bot { align-self: flex-start; background: white; border: 1px solid #ddd; }

        .chat-footer { padding: 10px; border-top: 1px solid #eee; display: flex; gap: 5px; }
    </style>
</head>
<body class="bg-light">

    <jsp:include page="Header.jsp" />

    <header class="hero">
        <div>
            <h1 class="display-1 fw-bold">Kỳ Nghỉ Trong Mơ</h1>
            <p class="fs-4 mb-4">Trải nghiệm dịch vụ đẳng cấp 5 sao tại hệ thống khách sạn hàng đầu.</p>
            <c:if test="${!isLoggedIn}">
                <a href="/register" class="btn btn-warning btn-lg px-5 py-3 fw-bold rounded-pill">Đặt Phòng Ngay</a>
            </c:if>
            <c:if test="${isLoggedIn}">
                <button class="btn btn-warning btn-lg px-5 py-3 fw-bold rounded-pill">Tìm Phòng Trống</button>
            </c:if>
        </div>
    </header>

    <div class="chat-launcher" onclick="toggleChat()">
        <i class="bi bi-chat-dots-fill fs-3 text-dark"></i>
    </div>

    <div class="chat-container" id="chatBox">
        <div class="chat-header">
            <span><i class="bi bi-robot"></i> Trợ lý Win</span>
            <button class="btn-close btn-close-white" onclick="toggleChat()"></button>
        </div>
        <div id="chat-messages">
            <div class="msg msg-bot">Dạ, Win xin chào! Em có thể giúp gì cho Anh/Chị ạ? ✨</div>
        </div>
        <div class="chat-footer">
            <input type="text" id="userInput" class="form-control" placeholder="Hỏi Win về giá phòng...">
            <button class="btn btn-warning" onclick="sendToWin()"><i class="bi bi-send"></i></button>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-4">
        <p>&copy; 2025 Luxury Hotel Management.</p>
    </footer>

    <script>
        function toggleChat() {
            const box = document.getElementById('chatBox');
            box.style.display = (box.style.display === 'flex') ? 'none' : 'flex';
        }

        async function sendToWin() {
            const input = document.getElementById('userInput');
            const container = document.getElementById('chat-messages');
            const text = input.value.trim();
            if(!text) return;

            // Hiển thị tin User
            container.innerHTML += '<div class="msg msg-user">' + text + '</div>';
            input.value = '';
            container.scrollTop = container.scrollHeight;

            try {
                const response = await fetch('/api/chat/ask', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ content: text })
                });
                const data = await response.text();
                
                // Hiển thị tin Bot
              container.innerHTML += '<div class="msg msg-bot">' + data + '</div>';
                container.scrollTop = container.scrollHeight;
            } catch (e) {
                container.innerHTML += `<div class="msg msg-bot text-danger">Lỗi kết nối máy chủ...</div>`;
            }
        }

        // Gửi bằng phím Enter
        document.getElementById('userInput').addEventListener('keypress', function(e) {
            if(e.key === 'Enter') sendToWin();
        });
    </script>
    <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>