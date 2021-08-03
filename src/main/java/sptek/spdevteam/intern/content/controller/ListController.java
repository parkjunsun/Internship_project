package sptek.spdevteam.intern.content.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
    public ModelAndView searchResultPage(HttpServletRequest request, HttpServletResponse  response) throws Exception{
        log.page("/content/search", "searchMainPage");
        for (String name : Collections.<String>list(request.getParameterNames())) {
            System.out.println("name, value = " + name + ", "+ request.getParameter(name));
        }

        Map<String, String[]> paramMap = request.getParameterMap();
        HashMap<String, Object> map = new HashMap<>();
        for (String key  : paramMap.keySet()) {
            map.put(key,paramMap.get(key)[0]);
        }

        int listCnt = listService.getBoardListCnt(map);
        Pagination pagination = new Pagination();

        map.replace("listSize", Integer.parseInt(map.get("listSize").toString()));

        pagination.pageInfo(Integer.parseInt(map.get("page").toString()),Integer.parseInt(map.get("range").toString()),listCnt);
        pagination.setListSize(Integer.parseInt(map.get("listSize").toString()));
        System.out.println("pagination = " + pagination);
        map.put("startList", pagination.getStartList());
        List<ContentExcel> contentExcelList = listService.getBoardList(map);

        ModelAndView mv = new ModelAndView("/content/content_search");
        mv.addObject("contentExcelList", contentExcelList);
        mv.addObject("pagination", pagination);

        return mv;
    }

}
