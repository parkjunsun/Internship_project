package sptek.spdevteam.intern.temp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.temp.domain.TempDomain;
import sptek.spdevteam.intern.temp.service.TempService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value = "/temp", method = { RequestMethod.GET, RequestMethod.POST })
public class TempController {

    private LogUtil log = new LogUtil(TempController.class);

    @Autowired
    TempService tempService;

    @RequestMapping(value = "/list", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView listPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        log.page("/temp/list","listPage()");
        ModelAndView mv = new ModelAndView("temp/temp_list");

        TempDomain temp = new TempDomain();
        TempDomain temp2 = tempService.selectMethod(temp);
        tempService.insertMethod(temp);
        tempService.updateMethod(temp);
        tempService.deleteMethod(temp);

        mv.addObject("result",temp2);

        return mv;
    }

    @RequestMapping(value = "/detail", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView detailPage(TempDomain tempDomain, HttpServletRequest request, HttpServletResponse response) throws Exception {
        log.page("/temp/detail","detailPage()");
        ModelAndView mv = new ModelAndView("temp/temp_detail");

        return mv;
    }

}
