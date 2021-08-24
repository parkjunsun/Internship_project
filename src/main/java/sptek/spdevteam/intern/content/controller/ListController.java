package sptek.spdevteam.intern.content.controller;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.CommonService;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.common.domain.Pagination;
import sptek.spdevteam.intern.content.domain.ContentExcel;
import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TempType;
import sptek.spdevteam.intern.content.service.ListService;
import sptek.spdevteam.intern.temp.domain.TempDomain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/content")
public class ListController {

    private LogUtil log = new LogUtil(ListController.class);

    @Autowired
    ListService listService;

    @Autowired
    CommonService commonService;

    @PostMapping("/change-dspstate")
    public void displayConfigPage(HttpServletRequest request) throws Exception{
        HashMap<String, Object> updateParam = new HashMap<>();
        String[] items = request.getParameter("items").split(" ");
        updateParam.put("items", items);
        updateParam.put("dspYn", request.getParameter("dspYn"));
        listService.updateDspYn(updateParam);
    }

    @ResponseBody
    @PostMapping("/download")
    public ModelAndView downloadExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        Map<String, String[]> paramMap = request.getParameterMap();
        HashMap<String, Object> map = new HashMap<>();
        for (String key  : paramMap.keySet()) {
            map.put(key,paramMap.get(key)[0]);
        }

        // 엑셀 파일 생성
        Workbook workbook = new SXSSFWorkbook();

        // 엑셀 파일 내부에 Sheet 생성
        Sheet sheet = workbook.createSheet();

        // 엑셀 렌더링에 필요한 DTO 가져오기
        List<ContentExcel> contentExcelList = listService.getBoardListAll(map);

        CellStyle defaultCellStyle = workbook.createCellStyle();
        defaultCellStyle.setAlignment(HorizontalAlignment.CENTER);
        defaultCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        defaultCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        defaultCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());

        CellStyle alignCellStyle = workbook.createCellStyle();
        defaultCellStyle.setAlignment(HorizontalAlignment.CENTER);
        defaultCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);


        int rowIndex = 0;

        // 생성일
        Row createDateRow = sheet.createRow(rowIndex++);
        Cell createDate = createDateRow.createCell(0);
        createDate.setCellValue("생성일");
        createDate.setCellStyle(defaultCellStyle);
        Cell createDateVal = createDateRow.createCell(1);
        createDateVal.setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        createDateVal.setCellStyle(alignCellStyle);

        // 조회수
        Row viewCntRow = sheet.createRow(rowIndex++);
        Cell viewCnt = viewCntRow.createCell(0);
        viewCnt.setCellValue("조회수");
        viewCnt.setCellStyle(defaultCellStyle);
        Cell viewCntData = viewCntRow.createCell(1);
        viewCntData.setCellValue(contentExcelList.size()+"건");
        viewCntData.setCellStyle(alignCellStyle);

        sheet.createRow(rowIndex++);


        // 셀 스타일 생성
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());

        // 헤더 생성
        Row headerRow = sheet.createRow(rowIndex++);

        Cell headerCell1 = headerRow.createCell(0);
        headerCell1.setCellStyle(headerStyle);
        headerCell1.setCellValue("번호");

        Cell headerCell2 = headerRow.createCell(1);
        headerCell2.setCellStyle(headerStyle);
        headerCell2.setCellValue("콘텐츠명");

        Cell headerCell3 = headerRow.createCell(2);
        headerCell3.setCellValue("화면코드");
        headerCell3.setCellStyle(headerStyle);

        Cell headerCell4 = headerRow.createCell(3);
        headerCell4.setCellValue("콘텐츠형태");
        headerCell4.setCellStyle(headerStyle);

        Cell headerCell5 = headerRow.createCell(4);
        headerCell5.setCellValue("템플릿유형");
        headerCell5.setCellStyle(headerStyle);

        Cell headerCell6 = headerRow.createCell(5);
        headerCell6.setCellValue("전시여부");
        headerCell6.setCellStyle(headerStyle);

        Cell headerCell7 = headerRow.createCell(6);
        headerCell7.setCellValue("전시기간");
        headerCell7.setCellStyle(headerStyle);

        Cell headerCell8 = headerRow.createCell(7);
        headerCell8.setCellValue("출처");
        headerCell8.setCellStyle(headerStyle);



        // 데이터 작성
        int index = 1;
        for (ContentExcel con : contentExcelList) {
            Row bodyRow = sheet.createRow(rowIndex++);

            Cell bodyCell1 = bodyRow.createCell(0);
            bodyCell1.setCellValue(index++);
            bodyCell1.setCellStyle(alignCellStyle);

            Cell bodyCell2 = bodyRow.createCell(1);
            bodyCell2.setCellValue(con.getCtnNm());
            bodyCell2.setCellStyle(alignCellStyle);

            Cell bodyCell3 = bodyRow.createCell(2);
            bodyCell3.setCellValue(con.getCtnSeq());
            bodyCell3.setCellStyle(alignCellStyle);

            Cell bodyCell4 = bodyRow.createCell(3);
            bodyCell4.setCellValue(con.getCtnDiv()=="IN"?"외부":"내부");
            bodyCell4.setCellStyle(alignCellStyle);

            Cell bodyCell5 = bodyRow.createCell(4);
            bodyCell5.setCellValue(con.getTplNm());
            bodyCell5.setCellStyle(alignCellStyle);

            Cell bodyCell6 = bodyRow.createCell(5);
            bodyCell6.setCellValue(con.getDspYn()=="Y"?"미전시":"전시");
            bodyCell6.setCellStyle(alignCellStyle);

            Cell bodyCell7 = bodyRow.createCell(6);
            String[] dspStDt = con.getDspStDt().split(":");
            String[] dspEndDt = con.getDspEndDt().split(":");
            bodyCell7.setCellValue(dspStDt[0]+":"+dspStDt[1]+" ~ "+dspEndDt[0]+":"+dspEndDt[1]);
            bodyCell7.setCellStyle(alignCellStyle);

            Cell bodyCell8 = bodyRow.createCell(7);
            bodyCell8.setCellValue(con.getSrcNm());
            bodyCell8.setCellStyle(alignCellStyle);

        }

        sheet.setColumnWidth((short)1,(short)10000);
        sheet.setColumnWidth((short)6,(short)10000);
        sheet.setColumnWidth((short)7,(short)3000);
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=test.xls");


        workbook.write(response.getOutputStream());
        workbook.close();

        return mv;

    }

    @GetMapping("/search")
    public ModelAndView searchMainPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        log.page("/content/search", "searchMainPage");
        List<SrcDto> srcList = commonService.getSrcList();
        List<TempType> tempList = listService.getTempList();

        System.out.println("tempList = " + tempList);

        ModelAndView mv = new ModelAndView("/content/content_search");

        Pagination pagination = new Pagination();
        pagination.setRange(1);
        pagination.setPage(1);

        mv.addObject("srcList", srcList);
        mv.addObject("tempList", tempList);
        mv.addObject("pagination", pagination);
        return mv;
    }


    @ResponseBody
    @PostMapping("/search")
    public ModelAndView searchResultPage(HttpServletRequest request) throws Exception{
        log.page("/content/search", "searchMainPage");

        Map<String, String[]> paramMap = request.getParameterMap();
        HashMap<String, Object> map = new HashMap<>();
        for (String key  : paramMap.keySet()) {
            map.put(key,paramMap.get(key)[0]);
        }

        int listCnt = listService.getBoardListCnt(map);

        // pagination 객체 생성
        Pagination pagination = new Pagination();
        map.replace("listSize", Integer.parseInt(map.get("listSize").toString()));
        pagination.setListSize(Integer.parseInt(map.get("listSize").toString()));
        pagination.pageInfo(Integer.parseInt(map.get("page").toString()),Integer.parseInt(map.get("range").toString()),listCnt);
        map.put("startList", pagination.getStartList());

        List<ContentExcel> contentExcelList = listService.getBoardList(map);

        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("contentExcelList", contentExcelList);
        mv.addObject("pagination", pagination);
        return mv;
    }

}
