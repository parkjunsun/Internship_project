package sptek.spdevteam.intern.content.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.service.ListService;
import sptek.spdevteam.intern.temp.domain.TempDomain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/content")
public class ListController {

    private LogUtil log = new LogUtil(ListController.class);

    @Autowired
    ListService listService;

    @GetMapping("/search")
    public ModelAndView searchMainPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        log.page("/content/search", "searchMainPage");
        ModelAndView mv = new ModelAndView("/content/content_search");
        return mv;
    }

    @PostMapping("/search")
    public ModelAndView searchResultPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        log.page("/content/search", "searchMainPage");
        ModelAndView mv = new ModelAndView("/content/content_list");

        ListDomain temp = new ListDomain();
        ListDomain temp2 = listService.listMethod(temp);

        mv.addObject("result",temp2);
        return mv;
    }

}
