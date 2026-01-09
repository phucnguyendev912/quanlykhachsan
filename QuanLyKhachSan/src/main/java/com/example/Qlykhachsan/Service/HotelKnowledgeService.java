package com.example.Qlykhachsan.Service;

import java.io.FileInputStream;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import org.springframework.stereotype.Service;

@Service
public class HotelKnowledgeService {
	public String loadknowledegePrompt(String filepath) {
		StringBuilder result = new StringBuilder();

		try (FileInputStream fis = new FileInputStream(filepath); Workbook wb = new XSSFWorkbook(fis)) {

			DataFormatter formatter = new DataFormatter();

			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				Sheet sheet = wb.getSheetAt(i);
				String sheetName = sheet.getSheetName().toLowerCase();
				System.out.println(" Đang đọc sheet: [" + sheetName + "]");
				if (sheetName.contains("phòng")) {
					result.append(readRoomSheet(sheet, formatter));
				}

				if (sheetName.contains("dịch vụ")) {
					result.append(readServiceSheet(sheet, formatter));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

			System.out.println("loi");
		}

		return result.toString();
	}

	public String readRoomSheet(Sheet sheet, DataFormatter formatter) {
		StringBuilder rooms = new StringBuilder("Phòng\n");
		for (Row row : sheet) {
			if (row.getRowNum() == 0) {
				continue;
			}
			String roomNumber = formatter.formatCellValue(row.getCell(0));
			String name = formatter.formatCellValue(row.getCell(1));
			String status = formatter.formatCellValue(row.getCell(2));
			String price = formatter.formatCellValue(row.getCell(3));
			String quantity = formatter.formatCellValue(row.getCell(4));
			String acreage = formatter.formatCellValue(row.getCell(5));
			String description = formatter.formatCellValue(row.getCell(6));
			if (name.isEmpty())
				continue;
			rooms.append("-").append(name).append("|Phòng: ").append(roomNumber).append("|Giá: ").append(price)
					.append("vnd/đêm").append("|Trạng thái: ").append(status).append("|Số lượng người: ")
					.append(quantity).append("|Diện tích: ").append(acreage).append("m2").append("|Mô tả: ")
					.append(description).append("\n");

		}
		return rooms.append("\n").toString();
	}

	public String readServiceSheet(Sheet sheet, DataFormatter formatter) {
		StringBuilder services = new StringBuilder("Dịch vụ\n");
		for (Row row : sheet) {
			if (row.getRowNum() == 0)
				continue;
			String serviceName = formatter.formatCellValue(row.getCell(0));
			String price = formatter.formatCellValue(row.getCell(1));
			String description = formatter.formatCellValue(row.getCell(2));
			String timeApply = formatter.formatCellValue(row.getCell(3));
			if (serviceName.isEmpty())
				continue;
			services.append("- ").append(serviceName).append(" | Giá: ").append(price).append(" VND")
					.append(" | mô tả: ").append(description).append(" | Thời gian áp dụng: ").append(timeApply)
					.append("\n");
		}
		return services.append("\n").toString();
	}
}
