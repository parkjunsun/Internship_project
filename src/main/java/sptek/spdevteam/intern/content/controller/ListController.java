package sptek.spdevteam.intern.content.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.CommonService;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.content.domain.ContentExcel;
import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TempType;
import sptek.spdevteam.intern.content.service.ListService;
import sptek.spdevteam.intern.temp.domain.TempDomain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/content")
public class ListController {

    private LogUtil log = new LogUtil(ListController.class);

    @Autowired
    ListService listService;

    @Autowired
    CommonService commonService;

    @GetMapping("/search")
    public ModelAndView searchMainPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        log.page("/content/search", "searchMainPage");
        List<SrcDto> srcList = commonService.getSrcList();
        List<TempType> tempList = listService.getTempList();

        System.out.println("tempList = " + tempList);

        ModelAndView mv = new ModelAndView("/content/content_search");

        mv.addObject("srcList", srcList);
        mv.addObject("tempList", tempList);
        return mv;
    }

    @ResponseBody
    @PostMapping("/search")
    public ModelAndView searchResultPage(HttpServletRequest request, HttpServletResponse  response) throws Exception{
        log.page("/content/search", "searchMainPage");
        for (String name : Collections.<String>list(request.getParameterNames())) {
            System.out.println("name, value = " + name + ", "+ request.getParameter(name));
        }

        Map<String, String[]> paramMap = request.getParameterMap();


        ContentExcel contentExcel = new ContentExcel();

        contentExcel.setCtnDiv(paramMap.get("ctnDiv")[0]);
        contentExcel.setCtnSeq(100);
        contentExcel.setDspEndDt(paramMap.get("dspEndDt")[0]);
        contentExcel.setDspStDt(paramMap.get("dspStDt")[0]);
        contentExcel.setCtnNm(paramMap.get("ctnNm")[0]);
        contentExcel.setSrcCd(paramMap.get("srcCd")[0]);
        contentExcel.setDspYn(paramMap.get("dspYn")[0]);
        contentExcel.setTplCd(paramMap.get("tplCd")[0]);


        System.out.println("contentExcel = " + contentExcel);

        List<ContentExcel> contentExcelList = listService.getList(contentExcel);

        ModelAndView mv = new ModelAndView("/content/content_list");
        mv.addObject("contentExcelList", contentExcelList);
        return mv;
    }

}
