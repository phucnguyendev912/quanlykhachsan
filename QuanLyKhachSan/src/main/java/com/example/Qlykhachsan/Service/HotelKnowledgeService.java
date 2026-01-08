package com.example.Qlykhachsan.Service;

import java.io.FileInputStream;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import org.springframework.stereotype.Service;

@Service
public class HotelKnowledgeService {

	public String loadknowledegePrompt(String filepath) {
		StringBuilder rooms = new StringBuilder("Phòng:\n");
		StringBuilder service = new StringBuilder("Dịch vụ:\n");
		try (FileInputStream fis = new FileInputStream(filepath)) {
			Workbook wb = new XSSFWorkbook(fis);
			Sheet sheet = wb.getSheetAt(0);
			System.out.println("Đã mở file Excel");
			System.out.println(" Số dòng: " + sheet.getPhysicalNumberOfRows());
			for (Row row : sheet) {
				if (row.getRowNum() == 0) {
					continue;
				}
				String type = row.getCell(0).getStringCellValue().toLowerCase();
				String name = row.getCell(1).getStringCellValue();
				String price = row.getCell(2).toString();
				String roomNumber = row.getCell(3).toString();
				String time = row.getCell(4).toString();
				String status = row.getCell(5).getStringCellValue();
				System.out.println("---- ROW " + row.getRowNum() + " ----");
				System.out.println("Type: " + type);
				System.out.println("Name: " + name);
				System.out.println("Price: " + price);
				System.out.println("Room: " + roomNumber);
				System.out.println("Time: " + time);
				System.out.println("Status: " + status);
				if ("phòng".equals(type) || "room".equals(type)) {
					rooms.append("- ").append(name).append(" | Giá: ").append(price).append(" VND/đêm")
							.append(" | Phòng: ").append(roomNumber).append(" | Trạng thái: ").append(status)
							.append("\n");
				}

				if ("dịch vụ".equals(type) || "service".equals(type)) {
					service.append("- ").append(name).append(" | Giá: ").append(price).append(" VND")
							.append(" | Thời gian: ").append(time).append(" | Trạng thái: ").append(status)
							.append("\n");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("lôix");
		}
		return rooms.append("\n").append(service).toString();
	}
}
