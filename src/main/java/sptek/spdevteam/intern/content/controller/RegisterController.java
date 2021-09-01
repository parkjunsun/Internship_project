package sptek.spdevteam.intern.content.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.*;
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
    private static final String COMMON_BIG_IMG = "I0002";
    private static final String COMMON_SMALL_IMG = "I0003";
    private static final String CARD_DET_IMG = "I0004";

    private final RegisterService registerService;
    private final CommonService commonService;

    private final RandomOutUtil randomOutUtil;

    private final S3Uploader s3Uploader;

    @Value("/home/ec2-user/")
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

        String imgGrpId = randomOutUtil.getRandomStr();

        s3Uploader.uploadSave(multipartFile, "static", imgGrpId, COMMON_REPR_IMG, 0);

        if (multipartFiles != null) {
            int odr = 1;
            for (MultipartFile file : multipartFiles) {
                if (!file.isEmpty()) {
                    s3Uploader.uploadSave(file, "static", imgGrpId, CARD_DET_IMG, odr);
                    odr += 1;
                }
            }
        }

        saveContent(content, imgGrpId);
        ContentDet contentDet = saveContentDet(content, inputUrl, imgGrpId);

        return "redirect:/content/update/" + contentDet.getCtnSeq();
    }


    private ContentDet saveContentDet(Content content, String inputUrl, String imgGrpId) {
        ContentDet contentDet = new ContentDet();
        contentDet.setCtnSeq(registerService.getCtnSeq(imgGrpId));
        contentDet.setImgGrpId(content.getImgGrpId());
        contentDet.setTplCd(content.getTplCd());
        contentDet.setUrlAddr(inputUrl);
        contentDet.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        contentDet.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        contentDet.setUseYn("Y");

        registerService.ctnDetSave(contentDet);
        return contentDet;
    }

    private void saveContent(Content content, String imgGrpId) {
        content.setImgGrpId(imgGrpId);
        content.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        content.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        content.setUseYn("Y");
        registerService.ctnSave(content);
    }

}
