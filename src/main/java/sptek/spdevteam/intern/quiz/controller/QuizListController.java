package sptek.spdevteam.intern.quiz.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.domain.Pagination;
import sptek.spdevteam.intern.quiz.domain.DspYnDto;
import sptek.spdevteam.intern.quiz.domain.QuizDto;
import sptek.spdevteam.intern.quiz.service.QzListService;

import java.util.ArrayList;
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
    public ModelAndView searchResultPage(@RequestParam HashMap<String, Object> paramMap) {

        Integer listCnt = qzListService.getListCnt(paramMap);
        System.out.println(listCnt);

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


}
