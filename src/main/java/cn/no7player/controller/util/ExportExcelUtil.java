package cn.no7player.controller.util;


import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

/**
 * 导出Excel文档
 *
 * @author whs
 */
public class ExportExcelUtil {

    private static final int cloumn_with = 15;

    private static HSSFCellStyle style;

    /**
     * 你下载指定的文件名,需带扩展名
     *
     * @param fileName
     * @param response mybatis返回的数据源的封装 例如:List<Map<String,Object>>
     * @param dataset  每一个sheet显示的标题
     * @param headerss 你sql语句select的column 的name,要和header对应
     * @param keys     页脚显示的文字
     * @param sheets
     */
    @SuppressWarnings("rawtypes")
    public static void exportExcel(String fileName,
                                   HttpServletResponse response, Collection[] dataset,
                                   String[][] headers, String[][] keys, String[] sheets) {
        try {
            OutputStream ouputStream = response.getOutputStream();
            /**
             * 建立一个导出excel工程
             */
            HSSFWorkbook workbook = new HSSFWorkbook();

            // 设置标题单元格样式
            HSSFCellStyle style = workbook.createCellStyle();
//            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
//            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//            style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//            style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//            style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//            style.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            // 设置标题单元格内容字体样式
            HSSFFont font = workbook.createFont();
//            font.setColor(HSSFColor.VIOLET.index);
//            font.setFontHeightInPoints((short) 12);
//            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            // 把字体应用到当前的样式
            style.setFont(font);
            // 设置内容单元格样式
            HSSFCellStyle style2 = workbook.createCellStyle();
//            style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
//            style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//            style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//            style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//            style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
//            style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

            // 生成另一个字体
            HSSFFont font2 = workbook.createFont();
            font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
            // 把字体应用到当前的样式
            style2.setFont(font2);

            for (int sheetIndex = 0; sheetIndex < dataset.length; sheetIndex++) {
                // 指定页脚
                HSSFSheet sheet = workbook.createSheet(sheets[sheetIndex]);
                sheet.setDefaultColumnWidth(cloumn_with);
                /**
                 * 开始生成每一个sheet 先完成标题部分
                 */
                System.out.println("开始画sheet" + (sheetIndex + 1));
                String[] titles = headers[sheetIndex];
                // 产生表格标题行
                HSSFRow row = sheet.createRow(0);
                for (int cellIndex = 0; cellIndex < titles.length; cellIndex++) {
                    HSSFCell cell = row.createCell(cellIndex);
                    cell.setCellStyle(style);
                    HSSFRichTextString text = new HSSFRichTextString(
                            titles[cellIndex]);
//                    System.out.print(titles[cellIndex] + "\t");
                    cell.setCellValue(text);
                }
                /**
                 * 标题制造完毕
                 */
                List datasetList = (List) dataset[sheetIndex];

                String[] keyss = keys[sheetIndex];

                int rowIndex = 1;
                for (int i = 0; i < datasetList.size(); i++, rowIndex++) {
                    row = sheet.createRow(rowIndex);
                    Map dataMap = (Map) datasetList.get(i);
                    for (int k = 0; k < keyss.length; k++) {
                        HSSFCell cellContext = row.createCell(k);
                        cellContext.setCellStyle(style2);
                        if (dataMap.get(keyss[k]) == null) {
                            cellContext.setCellValue("");
                        } else {
                            if (dataMap.get(keyss[k]) instanceof Date) {
                                SimpleDateFormat fmt = new SimpleDateFormat(
                                        "yyyy-MM-dd");
                                cellContext.setCellValue(fmt.format(
                                        dataMap.get(keyss[k])).toString());
                            } else if(dataMap.get(keyss[k]) instanceof Integer){
                            	cellContext.setCellValue((Integer)dataMap.get(keyss[k]));
                            }else if (dataMap.get(keyss[k]) instanceof Number) {
                                DecimalFormat df2 = (DecimalFormat) DecimalFormat
                                        .getInstance();
                                df2.applyPattern("0.00");
                                cellContext.setCellValue(df2.format(
                                        dataMap.get(keyss[k])).toString());
                            } else {
                                cellContext.setCellValue(dataMap.get(keyss[k])
                                        .toString());
                            }
                        }
                    }

                }
            }

            response.setCharacterEncoding("GBK");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("GBK"), "ISO8859-1"));

            workbook.write(ouputStream);
            ouputStream.flush();
            ouputStream.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
/*
    *//**
     * 你下载指定的文件名,需带扩展名
     *
     * @param fileName
     * @param response mybatis返回的数据源的封装 例如:List<Map<String,Object>>
     * @param dataset  每一个sheet显示的标题
     * @param keys     页脚显示的文字
     * @param sheets
     *//*
    @SuppressWarnings("rawtypes")
    public static void exportExcel(String fileName,
                                   HttpServletResponse response, Collection[] dataset,
                                   String[][] headers, String[][] keys, String[] sheets, String type) {
        try {
            OutputStream ouputStream = response.getOutputStream();
            *//**
             * 建立一个导出excel工程
             *//*
            HSSFWorkbook workbook = new HSSFWorkbook();

            // 设置标题单元格样式
            HSSFCellStyle style = workbook.createCellStyle();
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            // 设置标题单元格内容字体样式
            HSSFFont font = workbook.createFont();
            // 把字体应用到当前的样式
            style.setFont(font);
            // 设置内容单元格样式
            HSSFCellStyle style2 = workbook.createCellStyle();
            style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

            // 生成另一个字体
            HSSFFont font2 = workbook.createFont();
            font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
            // 把字体应用到当前的样式
            style2.setFont(font2);

            for (int sheetIndex = 0; sheetIndex < dataset.length; sheetIndex++) {
                // 指定页脚
                HSSFSheet sheet = workbook.createSheet(sheets[sheetIndex]);
                sheet.setDefaultColumnWidth(cloumn_with);
                *//**
                 * 开始生成每一个sheet 先完成标题部分
                 *//*
                System.out.println("开始画sheet" + (sheetIndex + 1));
                String[] titles = headers[sheetIndex];
                HSSFRow row = sheet.createRow(0);

                int headLength = 0;
                if (StringUtils.isNotEmpty(type)) {
                    headLength = dueHeaderByType(workbook, sheet, type);
                }

                *//**
                 * 标题制造完毕
                 *//*
                List datasetList = (List) dataset[sheetIndex];

                String[] keyss = keys[sheetIndex];

                int rowIndex = headLength;
                for (int i = 0; i < datasetList.size(); i++, rowIndex++) {
                    row = sheet.createRow(rowIndex);
                    Map dataMap = (Map) datasetList.get(i);
                    for (int k = 0; k < keyss.length; k++) {
                        HSSFCell cellContext = row.createCell(k);
                        cellContext.setCellStyle(style2);
                        if (dataMap.get(keyss[k]) == null) {
                            cellContext.setCellValue("");
                        } else {
                            if (dataMap.get(keyss[k]) instanceof Date) {
                                SimpleDateFormat fmt = new SimpleDateFormat(
                                        "yyyy-MM-dd");
                                cellContext.setCellValue(fmt.format(
                                        dataMap.get(keyss[k])).toString());
                            } else if(dataMap.get(keyss[k]) instanceof Integer){
                                cellContext.setCellValue((Integer)dataMap.get(keyss[k]));
                            }else if (dataMap.get(keyss[k]) instanceof Number) {
                                DecimalFormat df2 = (DecimalFormat) DecimalFormat
                                        .getInstance();
                                df2.applyPattern("0.00");
                                cellContext.setCellValue(df2.format(
                                        dataMap.get(keyss[k])).toString());
                            } else {
                                cellContext.setCellValue(dataMap.get(keyss[k])
                                        .toString());
                            }
                        }
                    }

                }
            }

            response.setCharacterEncoding("GBK");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("GBK"), "ISO8859-1"));

            workbook.write(ouputStream);
            ouputStream.flush();
            ouputStream.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    *//**
     * 确保数据库的每一列都有值时使用这个比较简单
     * <p/>
     * 导出文件名字,需添加扩展名
     *
     * @param fileName
     * @param response mybatis返回的数据源的封装 例如:List<Map<String,Object>>
     * @param dataset  没一个sheet显示的标题
     * @param headerss 页脚显示的文字
     * @param sheets
     *//*
    @SuppressWarnings("rawtypes")
    public static void exportExcel(String fileName,
                                   HttpServletResponse response,
                                   Collection<List<Map<String, Object>>>[] dataset,
                                   String[][] headers, String[] sheets) {
        try {
            OutputStream ouputStream = response.getOutputStream();
            *//**
             * 建立一个导出excel工程
             *//*
            HSSFWorkbook workbook = new HSSFWorkbook();

            // 设置标题单元格样式
            HSSFCellStyle style = workbook.createCellStyle();
            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            // 设置标题单元格内容字体样式
            HSSFFont font = workbook.createFont();
            font.setColor(HSSFColor.VIOLET.index);
            font.setFontHeightInPoints((short) 12);
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            // 把字体应用到当前的样式
            style.setFont(font);
            // 设置内容单元格样式
            HSSFCellStyle style2 = workbook.createCellStyle();
            style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
            style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

            // 生成另一个字体
            HSSFFont font2 = workbook.createFont();
            font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
            // 把字体应用到当前的样式
            style2.setFont(font2);

            for (int sheetIndex = 0; sheetIndex < dataset.length; sheetIndex++) {
                // 指定页脚
                HSSFSheet sheet = workbook.createSheet(sheets[sheetIndex]);
                sheet.setDefaultColumnWidth(cloumn_with);
                System.out.println("");
                *//**
                 * 开始生成每一个sheet 先完成标题部分
                 *//*
                System.out.println("开始画sheet" + (sheetIndex + 1));
                String[] titles = headers[sheetIndex];
                // 产生表格标题行
                HSSFRow row = sheet.createRow(0);
                for (int cellIndex = 0; cellIndex < titles.length; cellIndex++) {
                    HSSFCell cell = row.createCell(cellIndex);
                    cell.setCellStyle(style);
                    HSSFRichTextString text = new HSSFRichTextString(
                            titles[cellIndex]);
                    System.out.print(titles[cellIndex] + "\t");
                    cell.setCellValue(text);
                }
                *//**
                 * 标题制造完毕
                 *//*
                System.out.println("\r\n");
                List datasetList = (List) dataset[sheetIndex];
                Iterator<?> it = datasetList.iterator();
                int rowIndex = 0;

                while (it.hasNext()) {
                    rowIndex++;
                    row = sheet.createRow(rowIndex);
                    Map mapInList = (Map) it.next();
                    int cellXIndex = 0;
                    for (Object o : mapInList.keySet()) {
                        HSSFCell cellContext = row.createCell(cellXIndex);
                        cellContext.setCellStyle(style2);
                        cellXIndex++;
                        System.out.print(mapInList.get(o) + "\t");
                        if (mapInList.get(o) != null) {
                            cellContext.setCellValue(mapInList.get(o)
                                    .toString());
                        } else {
                            cellContext.setCellValue("");
                        }
                    }
                    System.out.println("\r\n");
                }
            }

            response.setCharacterEncoding("GBK");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("GBK"), "ISO8859-1"));

            workbook.write(ouputStream);
            ouputStream.flush();
            ouputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static int dueHeaderByType(HSSFWorkbook workbook, HSSFSheet sheet, String type) {
        style = workbook.createCellStyle();
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平

        HSSFFont font = workbook.createFont();
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示
        font.setFontHeightInPoints((short) 12);//设置字体大小
        style.setFont(font);//选择需要用到的字体格式

        if ("activityWEB".equals(type)) {
            HSSFRow row0 = sheet.createRow(0);// 1行
            HSSFRow row1 = sheet.createRow(1);// 2行
            HSSFRow row2 = sheet.createRow(2);// 3行
            HSSFRow row3 = sheet.createRow(3);// 4行
            HSSFRow row4 = sheet.createRow(4);// 5行

            int index = 0;
            dueMargeRegion(row0, "时间", index, 1, 5);

            dueMargeRowWithOther(row0, row1, "活动成本", new String[]{"奖品成本","综合成本","合计"}, ++index, 4);
            dueMargeRowWithOther(row0, row1, "参与人数", new String[]{"线上","线下","合计"}, index+=3, 4);
            dueMargeRowWithOther(row0, row1, "注册人数", new String[]{"线上","线下","合计"}, index+=3, 4);
            dueMargeRowWithOther(row0, row1, "实名人数", new String[]{"线上","线下","合计"}, index+=3, 4);
            dueMargeRowWithOther(row0, row1, "绑卡人数", new String[]{"线上","线下","合计"}, index+=3, 4);

            dueMargeRegion(row0, "充值情况", index+=3, 10, 1);
            dueMargeRegion(row1, "人数", index, 5, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, index+=2, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row1, "金额", ++index, 5, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, index+=2, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row0, "投资情况", ++index, 25, 1);
            dueMargeRegion(row1, "人数", index, 5, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, index+=2, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row1, "规模", ++index, 4, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRegion(row2, "老用户", index+=2, 1, 3);
            dueMargeRegion(row2, "合计", ++index, 1, 3);

            dueMargeRegion(row1, "活期", ++index, 4, 1);
            dueMargeRegion(row2, "新用户", index, 1, 3);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, ++index, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row1, "标业", ++index, 12, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下","合计"}, index, 2);
            dueMargeRegion(row2, "老用户", index+=3, 8, 1);

            dueMargeRegion(row3, "线上", index, 4, 1);
            dueMargeRegion(row4, "A", index, 1, 1);
            dueMargeRegion(row4, "B", ++index, 1, 1);
            dueMargeRegion(row4, "C+", ++index, 1, 1);
            dueMargeRegion(row4, "合计", ++index, 1, 1);

            dueMargeRegion(row3, "线下", ++index, 4, 1);
            dueMargeRegion(row4, "A", index, 1, 1);
            dueMargeRegion(row4, "B", ++index, 1, 1);
            dueMargeRegion(row4, "C+", ++index, 1, 1);
            dueMargeRegion(row4, "合计", ++index, 1, 1);

            dueMargeRegion(row2, "合计", ++index, 1, 3);

            dueMargeRegion(row0, "转化情况", ++index, 8, 1);

            dueMargeRowWithOther(row1, row2, "注册转化", new String[]{"线上","线下"}, index, 3);
            dueMargeRowWithOther(row1, row2, "实名转化", new String[]{"线上","线下"}, index+=2, 3);
            dueMargeRowWithOther(row1, row2, "充值转化", new String[]{"线上","线下"}, index+=2, 3);
            dueMargeRowWithOther(row1, row2, "投资转化", new String[]{"线上","线下"}, index+=2, 3);

            dueMargeRegion(row0, "CPA", index+=2, 1, 5);
            dueMargeRegion(row0, "CPI", ++index, 1, 5);
            dueMargeRegion(row0, "ROI", ++index, 1, 5);

            dueMargeRowWithOther(row0, row1, "后期投资转化率", new String[]{"人数","金额","转化率"}, ++index, 4);
            return 5;
        } else if ("activityAPP".equals(type)) {
            HSSFRow row0 = sheet.createRow(0);// 1行
            HSSFRow row1 = sheet.createRow(1);// 2行
            HSSFRow row2 = sheet.createRow(2);// 3行
            HSSFRow row3 = sheet.createRow(3);// 4行
            HSSFRow row4 = sheet.createRow(4);// 5行

            int index = 0;
            dueMargeRegion(row0, "时间", index, 1, 5);

            dueMargeRowWithOther(row0, row1, "活动成本", new String[]{"奖品成本","综合成本","合计"}, ++index, 4);

            dueMargeRowWithOther(row0, row1, "参与人数", new String[]{"线上","线下","合计"}, index+=3, 4);

            dueMargeRegion(row0, "点击人数", index+=3, 1, 5);
            dueMargeRegion(row0, "激活人数", ++index, 1, 5);

            dueMargeRowWithOther(row0, row1, "注册人数", new String[]{"线上","线下","合计"}, ++index, 4);
            dueMargeRowWithOther(row0, row1, "实名人数", new String[]{"线上","线下","合计"}, index+=3, 4);
            dueMargeRowWithOther(row0, row1, "绑卡人数", new String[]{"线上","线下","合计"}, index+=3, 4);

            dueMargeRegion(row0, "充值情况", index+=3, 10, 1);
            dueMargeRegion(row1, "人数", index, 5, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, index+=2, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row1, "金额", ++index, 5, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, index+=2, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row0, "投资情况", ++index, 25, 1);
            dueMargeRegion(row1, "人数", index, 5, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, index+=2, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row1, "规模", ++index, 4, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下"}, index, 2);
            dueMargeRegion(row2, "老用户", index+=2, 1, 3);
            dueMargeRegion(row2, "合计", ++index, 1, 3);

            dueMargeRegion(row1, "活期", ++index, 4, 1);
            dueMargeRegion(row2, "新用户", index, 1, 3);
            dueMargeRowWithOther(row2, row3, "老用户", new String[]{"线上","线下"}, ++index, 2);
            dueMargeRegion(row2, "合计", index+=2, 1, 3);

            dueMargeRegion(row1, "标业", ++index, 12, 1);
            dueMargeRowWithOther(row2, row3, "新用户", new String[]{"线上","线下","合计"}, index, 2);
            dueMargeRegion(row2, "老用户", index+=3, 8, 1);

            dueMargeRegion(row3, "线上", index, 4, 1);
            dueMargeRegion(row4, "A", index, 1, 1);
            dueMargeRegion(row4, "B", ++index, 1, 1);
            dueMargeRegion(row4, "C+", ++index, 1, 1);
            dueMargeRegion(row4, "合计", ++index, 1, 1);

            dueMargeRegion(row3, "线下", ++index, 4, 1);
            dueMargeRegion(row4, "A", index, 1, 1);
            dueMargeRegion(row4, "B", ++index, 1, 1);
            dueMargeRegion(row4, "C+", ++index, 1, 1);
            dueMargeRegion(row4, "合计", ++index, 1, 1);

            dueMargeRegion(row2, "合计", ++index, 1, 3);

            dueMargeRegion(row0, "转化情况", ++index, 8, 1);
            dueMargeRegion(row1, "下载转化", index, 1, 4);
            dueMargeRegion(row1, "激活转化", ++index, 1, 4);

            dueMargeRowWithOther(row1, row2, "注册转化", new String[]{"线上","线下"}, ++index, 3);
            dueMargeRowWithOther(row1, row2, "实名转化", new String[]{"线上","线下"}, index+=2, 3);
            dueMargeRowWithOther(row1, row2, "充值转化", new String[]{"线上","线下"}, index+=2, 3);
            dueMargeRowWithOther(row1, row2, "投资转化", new String[]{"线上","线下"}, index+=2, 3);

            dueMargeRegion(row0, "CPA", index+=2, 1, 5);
            dueMargeRegion(row0, "CPI", ++index, 1, 5);
            dueMargeRegion(row0, "ROI", ++index, 1, 5);

            dueMargeRowWithOther(row0, row1, "后期投资转化率", new String[]{"人数","金额","转化率"}, ++index, 4);

            return 5;
        } else if ("sourceAPP".equals(type)) {
            HSSFRow row0 = sheet.createRow(0);// 1行
            HSSFRow row1 = sheet.createRow(1);// 2行

            int index = 0;
            dueMargeRegion(row0, "时间", index, 1, 2);
            dueMargeRegion(row0, "成本", ++index, 1, 2);
            dueMargeRegion(row0, "激活", ++index, 1, 2);
            dueMargeRegion(row0, "注册人数", ++index, 1, 2);
            dueMargeRegion(row0, "实名人数", ++index, 1, 2);
            dueMargeRegion(row0, "绑卡人数", ++index, 1, 2);

            dueMargeRowWithOther(row0, row1, "充值", new String[]{"人数","金额"}, ++index, 1);
            dueMargeRowWithOther(row0, row1, "当日投资", new String[]{"人数","金额","不包含活期"}, index+=2, 1);
            dueMargeRowWithOther(row0, row1, "累计投资", new String[]{"人数","金额","不包含活期"}, index+=3, 1);
            dueMargeRowWithOther(row0, row1, "转化率", new String[]{"下载转化","激活转化","注册转化","实名转化","充值转化","投资转化"}, index+=3, 1);
            dueMargeRowWithOther(row0, row1, "质量", new String[]{"客户单价","留存金额"}, index+=6, 1);

            dueMargeRegion(row0, "CPA", index+=2, 1, 2);
            dueMargeRegion(row0, "CPI", ++index, 1, 2);
            return 2;
        } else if ("sourceWEB".equals(type)) {
            HSSFRow row0 = sheet.createRow(0);// 1行
            HSSFRow row1 = sheet.createRow(1);// 2行

            int index = 0;
            dueMargeRegion(row0, "时间", index, 1, 2);
            dueMargeRegion(row0, "成本", ++index, 1, 2);
            dueMargeRegion(row0, "UV", ++index, 1, 2);
            dueMargeRegion(row0, "PV", ++index, 1, 2);
            dueMargeRegion(row0, "注册人数", ++index, 1, 2);
            dueMargeRegion(row0, "实名人数", ++index, 1, 2);
            dueMargeRegion(row0, "绑卡人数", ++index, 1, 2);

            dueMargeRowWithOther(row0, row1, "充值", new String[]{"人数","金额"}, ++index, 1);
            dueMargeRowWithOther(row0, row1, "当日投资", new String[]{"人数","金额","不包含活期"}, index+=2, 1);
            dueMargeRowWithOther(row0, row1, "累计投资", new String[]{"人数","金额","不包含活期"}, index+=3, 1);
            dueMargeRowWithOther(row0, row1, "转化率", new String[]{"注册转化","实名转化","充值转化","投资转化"}, index+=3, 1);
            dueMargeRowWithOther(row0, row1, "质量", new String[]{"客户单价","留存金额"}, index+=4, 1);

            dueMargeRegion(row0, "CPA", index+=2, 1, 2);
            dueMargeRegion(row0, "CPI", ++index, 1, 2);
            return 2;
        }

        return 1;
    }


    *//**
     * 合并单元格
     * @param startRow
     * @param otherRow
     * @param headerRow1 第一行 列名称
     * @param headerRow2 第二行 列名称
     * @param startRowIndex 第一行 开始index
     * @param length 第二行占据的行数
     *//*
    private static void dueMargeRowWithOther(HSSFRow startRow, HSSFRow otherRow, String headerRow1, String[] headerRow2, int startRowIndex, int length) {
        HSSFSheet sheet = startRow.getSheet();

        CellRangeAddress cellRangeAddress = new CellRangeAddress(startRow.getRowNum(), startRow.getRowNum(), startRowIndex, startRowIndex+headerRow2.length - 1);
        startRow.getSheet().addMergedRegion(cellRangeAddress);
        HSSFCell cell1 = startRow.createCell(startRowIndex);
        HSSFRichTextString text1 = new HSSFRichTextString(headerRow1);
        cell1.setCellValue(text1);
        cell1.setCellStyle(style);

        borderStyle(cellRangeAddress, startRow);

        for (int i =0; i < headerRow2.length; i++) {
            CellRangeAddress cellRangeAddress1 = new CellRangeAddress(otherRow.getRowNum(), otherRow.getRowNum() + length - 1, startRowIndex+i,startRowIndex+i);
            sheet.addMergedRegion(cellRangeAddress1);
            HSSFCell cell2 = otherRow.createCell(startRowIndex+i);
            HSSFRichTextString text2 = new HSSFRichTextString(headerRow2[i]);
            cell2.setCellValue(text2);
            cell2.setCellStyle(style);

            borderStyle(cellRangeAddress1, otherRow);
        }
    }

    *//**
     * 合并单元格
     * @param row 起始行
     * @param title 列标题
     * @param startRowIndex 行起始index
     * @param length 长度
     * @param colLength 占据行数
     *//*
    private static void dueMargeRegion(HSSFRow row, String title, int startRowIndex, int length, int colLength) {
        HSSFSheet sheet = row.getSheet();

        CellRangeAddress cellRangeAddress = new CellRangeAddress(row.getRowNum(), row.getRowNum() + colLength - 1, startRowIndex, startRowIndex + length - 1);
        sheet.addMergedRegion(cellRangeAddress);
        HSSFCell cell1 = row.createCell(startRowIndex);
        HSSFRichTextString text1 = new HSSFRichTextString(title);
        cell1.setCellValue(text1);
        cell1.setCellStyle(style);

        borderStyle(cellRangeAddress, row);
    }


    *//**
     * 对合并单元格进行边框加载
     * @param cellRangeAddress
     * @param row
     *//*
    private static void borderStyle(CellRangeAddress cellRangeAddress, HSSFRow row) {
        RegionUtil.setBorderLeft(1, cellRangeAddress, row.getSheet(), row.getSheet().getWorkbook());
        RegionUtil.setBorderRight(1, cellRangeAddress, row.getSheet(), row.getSheet().getWorkbook());
        RegionUtil.setBorderTop(1, cellRangeAddress, row.getSheet(), row.getSheet().getWorkbook());
        RegionUtil.setBorderBottom(1, cellRangeAddress, row.getSheet(), row.getSheet().getWorkbook());
    }*/
}
