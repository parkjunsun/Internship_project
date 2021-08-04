package sptek.spdevteam.intern.content.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequiredArgsConstructor
@RequestMapping("/content")
public class UpdateController {

    @GetMapping("/update/{ctnSeq}")
    public String updateForm(Model model, @PathVariable("ctnSeq") int ctnSeq) {

        return "content/content_update";

    }

}
