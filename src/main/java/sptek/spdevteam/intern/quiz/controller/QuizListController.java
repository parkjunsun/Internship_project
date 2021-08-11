package sptek.spdevteam.intern.quiz.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.domain.Pagination;
import sptek.spdevteam.intern.quiz.domain.QuizDto;
import sptek.spdevteam.intern.quiz.service.QzListService;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/quiz")
@RequiredArgsConstructor
public class QuizListController {

    private final QzListService qzListService;

    @GetMapping("/search")
    public String searchForm() {

        return "quiz/quiz_search";
    }

    @PostMapping("/search")
    @ResponseBody
    public ModelAndView searchResultPage(@RequestParam HashMap<String, String> paramMap) {
        List<QuizDto> qzList = qzListService.getList(paramMap);

        Integer listCnt = qzListService.getListCnt(paramMap);
        System.out.println(listCnt);

        Pagination pagination = new Pagination();
        pagination.setListSize(Integer.parseInt(paramMap.get("listSize")));

        int page;
        if (paramMap.get("page").equals("")) {
            page = 1;
        } else {
            page = Integer.parseInt(paramMap.get("page"));
        }
        pagination.pageInfo(page, Integer.parseInt(paramMap.get("range")), listCnt);

        System.out.println(pagination);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("qzList", qzList);

        return mv;
    }

}
