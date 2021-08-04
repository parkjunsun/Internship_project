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
import sptek.spdevteam.intern.content.domain.*;
import sptek.spdevteam.intern.content.service.RegisterService;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;


@Controller
@RequiredArgsConstructor
@RequestMapping("/content")
public class RegisterController {

    private static final String COMMON_REPR_IMG = "I0001";
    private static final String CARD_DET_IMG = "I0004";

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
    public String register(@ModelAttribute Content content, @RequestParam(value = "repr_img") MultipartFile multipartFile,
                           @RequestParam(value = "ctn_img", required = false) List<MultipartFile> multipartFiles,
                           @RequestParam(value = "inputUrl", required = false) String inputUrl) throws IOException {


        FileUploadUtil fileUploadUtil = new FileUploadUtil(multipartFile, uploadFilePath);
        fileUploadUtil.UploadImage();

        String imgGrpId = randomOutUtil.getRandomStr();

        Image image = new Image();
        image.setImgGrpId(imgGrpId);
        image.setImgTyCd(COMMON_REPR_IMG);
        image.setPath(fileUploadUtil.getPath());
        image.setFeNm(fileUploadUtil.getFileName());
        image.setEncFeNm(fileUploadUtil.getEncFileName());
        image.setFeExt(fileUploadUtil.getExtension());
        image.setFeSz(fileUploadUtil.getSize());
        image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setImgOdr(0);
        image.setUseYn("y");

        registerService.imgSave(image);

        if (multipartFiles != null) {
            int odr = 1;
            for (MultipartFile file : multipartFiles) {
                if (!file.isEmpty()) {

                    FileUploadUtil ctnDetUploadUtil = new FileUploadUtil(file, uploadFilePath);

                    Image ctnDetImage = new Image();
                    ctnDetImage.setImgGrpId(imgGrpId);
                    ctnDetImage.setImgTyCd(CARD_DET_IMG);
                    ctnDetImage.setPath(ctnDetUploadUtil.getPath());
                    ctnDetImage.setFeNm(ctnDetUploadUtil.getFileName());
                    ctnDetImage.setEncFeNm(ctnDetUploadUtil.getEncFileName());
                    ctnDetImage.setFeExt(ctnDetUploadUtil.getExtension());
                    ctnDetImage.setFeSz(ctnDetUploadUtil.getSize());
                    ctnDetImage.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                    ctnDetImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                    ctnDetImage.setImgOdr(odr);
                    ctnDetImage.setUseYn("y");

                    ctnDetUploadUtil.UploadImage();
                    registerService.imgSave(ctnDetImage);

                    odr += 1;
                }
            }
        }


        content.setImgGrpId(imgGrpId);
        content.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        content.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        content.setUseYn("y");
        registerService.ctnSave(content);


        ContentDet contentDet = new ContentDet();
        contentDet.setCtnSeq(registerService.getCtnSeq(imgGrpId));
        contentDet.setImgGrpId(content.getImgGrpId());
        contentDet.setTplCd(content.getTplCd());
        contentDet.setUrlAddr(inputUrl);
        contentDet.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        contentDet.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        contentDet.setUseYn("y");

        registerService.ctnDetSave(contentDet);

        return "redirect:/content/register";
    }

}
