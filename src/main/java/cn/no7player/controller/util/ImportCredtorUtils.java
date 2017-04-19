package cn.no7player.controller.util;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.LocalDate;

import cn.no7player.model.ClaimLoan;

/**
 * Created by veryyoung on 2015/4/15.
 * <p/>
 * 将上传的数据转换为UPlanLoan
 */
public class ImportCredtorUtils {

	/**
	 * 逗号分隔符
	 */
	public static final String SEPARATE = ",";

	/**
	 * 将xls文件内容转成对象
	 */
	public static List<ClaimLoan> changeXls2BeanForClaimLoan(InputStream is) throws Exception {
		List<ClaimLoan> list = new ArrayList<>();
		// 获取工作薄
		Workbook wookbook = new HSSFWorkbook(is);
		// 获取第一张工作表
		Sheet sheet = wookbook.getSheetAt(0);
		// 获取Excel中所有行数
		int rows = sheet.getLastRowNum();
		// 遍历行，从第二行开始
		for (int i = 1; i <= rows; i++) {
			ClaimLoan vo = new ClaimLoan();
			// 获取行数据
			Row row = sheet.getRow(i);
			// 如果行不为空，则获取行中的数据记录
			if (null != row) {
				for (int j = 0; j < row.getLastCellNum(); j++) {
					try {
						vo = parseRow2VOForClaimLoan(j, ConvertCellStr(row.getCell(j)), vo);
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("解析excel模板数据错误！" + "当前操作数据行为：" + i + "，当前操作cell：" + j);
					}
				}
				list.add(vo);
			}
		}

		wookbook.close();

		return list;
	}

	/**
	 * 将xlsx文件内容转成对象
	 */
	public static List<ClaimLoan> changeXlsx2BeanForClaimLoan(InputStream is) throws Exception {
		List<ClaimLoan> list = new ArrayList<>();
		// 获取工作薄
		Workbook wookbook = new XSSFWorkbook(is);
		// 获取第一张工作表
		Sheet sheet = wookbook.getSheetAt(0);
		// 获取Excel中所有行数
		int rows = sheet.getLastRowNum();
		// 遍历行，从第二行开始
		for (int i = 1; i <= rows; i++) {
			ClaimLoan vo = new ClaimLoan();
			// 获取行数据
			Row row = sheet.getRow(i);
			// 如果行不为空，则获取行中的数据记录
			if (null != row) {
				for (int j = 0; j < row.getLastCellNum(); j++) {
					try {
						vo = parseRow2VOForClaimLoan(j, ConvertCellStr(row.getCell(j)), vo);
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("解析excel模板数据错误！" + "当前操作数据行为：" + i + "，当前操作cell：" + j);
					}
				}
				list.add(vo);
			}
		}

		wookbook.close();

		return list;
	}

	/**
	 * 把单元格内的类型转换至String类型
	 */
	private static String ConvertCellStr(Cell cell) {
		String cellStr = null;

		switch (cell.getCellType()) {

		case Cell.CELL_TYPE_STRING:
			// 读取String
			cellStr = cell.getStringCellValue().toString();
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			// 得到Boolean对象的方法
			cellStr = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_NUMERIC:

			// 先看是否是日期格式
			if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
				Date dataTmp = cell.getDateCellValue();
				// 读取日期格式
				cellStr = new LocalDate(DateUtils.dateFormateDate(dataTmp, DateUtils.DATE_SIMPLE_FORMAT))
						.toString(DateUtils.DATE_SIMPLE_FORMAT);
			} else {
				// 读取数字
				cellStr = String.valueOf(cell.getNumericCellValue());
			}
			break;
		case Cell.CELL_TYPE_FORMULA:
			// 读取公式
			cellStr = cell.getCellFormula().toString();
			break;
		}
		return cellStr;
	}

	/**
	 * 将Excel中的行记录转换为对象
	 */
	private static ClaimLoan parseRow2VOForClaimLoan(int j, String cellStr, ClaimLoan vo) {

		switch (j) {

		case 0:

			vo.setCartype(cellStr);
			break;

		case 1:
			vo.setCarnumber(cellStr);
			break;
		case 2:
			vo.setCarpp(cellStr);
			break;

		case 3:
			vo.setCarcjh(cellStr);
			break;
		case 4:

			vo.setPersionid(cellStr);
			break;

		case 5:
			vo.setPersionname(cellStr);
			break;
		case 6:
			vo.setGctime(cellStr);
			break;
		case 7:
			vo.setAddessid(cellStr);
			break;
		case 8:
			vo.setPhone(cellStr);
			break;
		}
		return vo;
	}

}
