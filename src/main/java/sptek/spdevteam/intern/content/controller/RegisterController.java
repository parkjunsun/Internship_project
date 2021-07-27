package sptek.spdevteam.intern.content.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.service.RegisterService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/content")
public class RegisterController {

    private final RegisterService registerService;

    @GetMapping("/register")
    public ModelAndView registerPage() {

        ModelAndView mv = new ModelAndView("content/content_register");
        List<HashMap<String, String>> srcList = registerService.getSrcList();

        System.out.println(srcList);

        mv.addObject("srcList", srcList);

        return mv;

    }

    @PostMapping("/register")
    public String register(@ModelAttribute Content content) throws IOException {
        registerService.save(content);
        return "redirect:/";
    }

}
