package sptek.spdevteam.intern.quiz.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.domain.Pagination;
import sptek.spdevteam.intern.quiz.domain.DspYnDto;
import sptek.spdevteam.intern.quiz.domain.QuizDto;
import sptek.spdevteam.intern.quiz.service.QzListService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/quiz")
@RequiredArgsConstructor
public class QuizListController {

    private final QzListService qzListService;


    @GetMapping("/search")
    public String searchForm() { return "quiz/quiz_search"; }


    @PostMapping("/search")
    @ResponseBody
    public ModelAndView searchResultPage(@RequestParam HashMap<String, Object> paramMap) {

        Integer listCnt = qzListService.getListCnt(paramMap);

        Pagination pagination = new Pagination();

        paramMap.replace("listSize", Integer.parseInt(paramMap.get("listSize").toString()));
        pagination.setListSize(Integer.parseInt(paramMap.get("listSize").toString()));

        int page;
        if (paramMap.get("page").equals("")) {
            page = 1;
        } else {
            page = Integer.parseInt(paramMap.get("page").toString());
        }

        pagination.pageInfo(page, Integer.parseInt(paramMap.get("range").toString()), listCnt);

        System.out.println(pagination);

        paramMap.put("startList", pagination.getStartList());
        System.out.println(paramMap);
        List<QuizDto> qzList = qzListService.getBoardList(paramMap);

        ModelAndView mv = new ModelAndView("jsonView");

        mv.addObject("qzList", qzList);
        mv.addObject("pagination", pagination);

        return mv;
    }

    @PostMapping("/change-dspstate")
    @ResponseBody
    public Message displayConfigPage(@RequestParam String jsonData) throws JsonProcessingException {

        HashMap<String, Object> updateParam = new HashMap<>();
        List<String> qzSeqList = new ArrayList<>();

        List<DspYnDto> dspYnList = new ObjectMapper().readValue(jsonData, new TypeReference<List<DspYnDto>>() {});

        for (DspYnDto dspYnDto : dspYnList) {
            qzSeqList.add(Integer.toString(dspYnDto.getQzSeq()));
        }

        updateParam.put("items", qzSeqList);
        updateParam.put("dspYn", dspYnList.get(0).getDspYn());

        qzListService.updateDspYn(updateParam);

        Message message = new Message();
        message.setMsg("정상적으로 데이터 수정이 완료되었습니다.");
        return message;
    }


    static class Message {
        private String msg;

        public String getMsg() {return msg;}
        public void setMsg(String msg) {this.msg = msg;}
    }


    @PostMapping("/excel/download")
    public void excelDownLoad(HttpServletResponse response, @RequestParam("searchType") String searchType, @RequestParam("dspStDt") String dspStDt,
                              @RequestParam("dspEndDt") String dspEndDt, @RequestParam("dspYn") String dspYn, @RequestParam("qzNm") String qzNm) throws IOException {

        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("searchType", searchType);
        paramMap.put("stDt", dspStDt);
        paramMap.put("endDt", dspEndDt);
        paramMap.put("dspYn", dspYn);
        paramMap.put("qzNm", qzNm);

        List<QuizDto> excelList = qzListService.getExcelList(paramMap);

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("sample_sheet");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        row = sheet.createRow(rowNum++);
        String[] headers = {"번호", "퀴즈명", "유형", "퀴즈번호", "진행기간", "전시상태", "등록일"};

        //Header
        for(int i = 0; i<7; i++) {
            cell = row.createCell(i);
            cell.setCellValue(headers[i]);
        }

        //Body
        int seq = 1;
        for (QuizDto quizDto : excelList) {
            row = sheet.createRow(rowNum++);

            cell = row.createCell(0);
            cell.setCellValue(seq++);

            cell = row.createCell(1);
            cell.setCellValue(quizDto.getQzNm());

            cell = row.createCell(2);
            cell.setCellValue("퀴즈");

            cell = row.createCell(3);
            cell.setCellValue(quizDto.getQzSeq());

            cell = row.createCell(4);
            cell.setCellValue(quizDto.getStDt() + " ~ " + quizDto.getEndDt());

            cell = row.createCell(5);
            String strDspYn = quizDto.getDspYn().equals("Y") ? "전시" : "미전시";
            cell.setCellValue(strDspYn);

            cell = row.createCell(6);
            cell.setCellValue(quizDto.getRegDt());
        }


        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        String today = simpleDateFormat.format(new Date());

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel;");
        response.setCharacterEncoding("UTF-8");

        String fileName = "퀴즈목록_" + today + ".xlsx";
        String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
        response.setHeader("Content-Disposition", "attachment; filename=" + outputFileName);

        wb.write(response.getOutputStream());
        wb.close();
    }
}
