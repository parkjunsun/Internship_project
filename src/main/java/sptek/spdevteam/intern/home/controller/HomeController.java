package sptek.spdevteam.intern.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sptek.spdevteam.intern.common.LogUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class HomeController {

    private LogUtil log = new LogUtil(HomeController.class);

    @RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
    public String home(HttpServletRequest request, HttpServletResponse response){
        log.page("/","home()");
        System.out.println("HomeController.home");
        return "redirect:/temp/list";
    }
}
