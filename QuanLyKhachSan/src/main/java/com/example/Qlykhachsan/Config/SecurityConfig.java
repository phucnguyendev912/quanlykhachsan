//package com.example.Qlykhachsan.Config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.web.SecurityFilterChain;
//
//@Configuration
//@EnableWebSecurity
//public class SecurityConfig {
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http
//            .csrf(csrf -> csrf.disable()) // Tắt CSRF để tránh lỗi 403 khi dùng form
//            .authorizeHttpRequests(auth -> auth
//                // CỰC KỲ QUAN TRỌNG: Cho phép truy cập không cần login vào các trang này
//                .requestMatchers("/Landingpage", "/login", "/register", "/css/**", "/js/**").permitAll()
//                .anyRequest().authenticated() // Các trang khác mới cần login
//            )
//            .formLogin(login -> login
//                .loginPage("/login") // Chỉ định trang login của bạn
//                .loginProcessingUrl("/login")
//                .defaultSuccessUrl("/Landingpage", true) // Login xong quay lại Landingpage
//                .permitAll() // Phải có dòng này để mở khóa trang login
//            )
//            .logout(logout -> logout
//                .logoutSuccessUrl("/Landingpage")
//                .permitAll()
//            );
//
//        return http.build();
//    }
//}