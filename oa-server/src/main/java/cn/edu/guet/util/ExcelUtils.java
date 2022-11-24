package cn.edu.guet.util;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 * @author 陶祎祎
 */
public class ExcelUtils {
    public static void downloadExcel(String fileName, Workbook workbook, HttpServletResponse response) throws Exception {
        try {
            if (StringUtils.isEmpty(fileName)) {
                throw new RuntimeException("导出文件名不能为空");
            }
            String encodeFileName = URLEncoder.encode(fileName, "UTF-8");
            response.setHeader("content-Type", "application/vnd.ms-excel; charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + encodeFileName);
            response.setHeader("FileName", encodeFileName);
            response.setHeader("Access-Control-Expose-Headers", "FileName");
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            workbook.close();
        }
    }
}
