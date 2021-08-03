package sptek.spdevteam.intern.content.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.CommonService;
import sptek.spdevteam.intern.common.FileUploadUtil;
import sptek.spdevteam.intern.common.RandomOutUtil;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TplDto;
import sptek.spdevteam.intern.content.service.RegisterService;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/content")
public class RegisterController {

    private static final String COMMON_REPR_IMG = "I0001";

    private final RegisterService registerService;
    private final CommonService commonService;

    private final RandomOutUtil randomOutUtil;

    @Value("${uploadFile.path}")
    private String uploadFilePath;

    @GetMapping("/register")
    public ModelAndView registerPage() {

        ModelAndView mv = new ModelAndView("content/content_register");
        List<SrcDto> srcList = commonService.getSrcList();
        List<TplDto> tplList = commonService.getTplList();

        mv.addObject("tplList", tplList);
        mv.addObject("srcList", srcList);


        return mv;

    }

    @PostMapping("/register")
    public String register(@RequestParam("repr_img") MultipartFile multipartFile, @ModelAttribute Content content) throws IOException {


        FileUploadUtil fileUploadUtil = new FileUploadUtil(multipartFile, uploadFilePath);
        fileUploadUtil.UploadImage();

        String randomStr = randomOutUtil.getRandomStr();


        Image image = new Image();
        image.setImgGrpId(randomStr);
        image.setImgTyCd(COMMON_REPR_IMG);
        image.setPath(fileUploadUtil.getPath());
        image.setFeNm(fileUploadUtil.getFileName());
        image.setEncFeNm(fileUploadUtil.getEncFileName());
        image.setFeExt(fileUploadUtil.getExtension());
        image.setFeSz(fileUploadUtil.getSize());
        image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));


        registerService.imgSave(image);


        content.setImgGrpId(randomStr);



        registerService.ctnSave(content);
        return "redirect:/content/register";
    }

}
