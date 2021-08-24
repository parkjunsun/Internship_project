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
import sptek.spdevteam.intern.common.ResizeImgUtil;
import sptek.spdevteam.intern.content.domain.*;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.service.RegisterService;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;


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

    @Value("/home/sptek/image")
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
        String imgGrpId = randomOutUtil.getRandomStr();

        Image image = new Image();

        image.setImgGrpId(imgGrpId);
        image.setImgTyCd(COMMON_REPR_IMG);

        String encFileName = fileUploadUtil.getEncFileName();

        image.setPath(fileUploadUtil.getPath(encFileName));
        image.setFeNm(fileUploadUtil.getFileName());
        image.setEncFeNm(encFileName);
        image.setFeExt(fileUploadUtil.getExtension());
        image.setFeSz(fileUploadUtil.getSize());
        image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setImgOdr(0);
        image.setUseYn("Y");

        fileUploadUtil.UploadImage(encFileName);
        registerService.imgSave(image);


        ResizeImgUtil resizeImgUtil = new ResizeImgUtil(fileUploadUtil.getPath(encFileName), COMMON_BIG_IMG);
        BufferedImage newImage = resizeImgUtil.resizeImg();

        Image bigImage = new Image();

        String bigExt = fileUploadUtil.getExtension();
        String bigEncFeNm = UUID.randomUUID().toString();
        String bigPath = uploadFilePath + bigEncFeNm + '.' + bigExt;
        int bigFeSz = newImage.getWidth() * newImage.getHeight();

        bigImage.setImgGrpId(imgGrpId);
        bigImage.setImgTyCd(COMMON_BIG_IMG);
        bigImage.setPath(bigPath);
        bigImage.setFeNm(fileUploadUtil.getFileName());
        bigImage.setEncFeNm(bigEncFeNm);
        bigImage.setFeExt(bigExt);
        bigImage.setFeSz(bigFeSz);
        bigImage.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        bigImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        bigImage.setUseYn("Y");
        bigImage.setImgOdr(0);

        ImageIO.write(newImage, bigExt, new File(bigPath));
        registerService.imgSave(bigImage);



        ResizeImgUtil resizeImgUtil2 = new ResizeImgUtil(fileUploadUtil.getPath(encFileName), COMMON_SMALL_IMG);
        BufferedImage newImage2 = resizeImgUtil2.resizeImg();

        Image smallImage = new Image();

        String smallExt = fileUploadUtil.getExtension();
        String smallEncFeNm = UUID.randomUUID().toString();
        String smallPath = uploadFilePath + smallEncFeNm + '.' + smallExt;
        int smallFeSz = newImage2.getWidth() * newImage2.getHeight();

        smallImage.setImgGrpId(imgGrpId);
        smallImage.setImgTyCd(COMMON_SMALL_IMG);
        smallImage.setPath(smallPath);
        smallImage.setFeNm(fileUploadUtil.getFileName());
        smallImage.setEncFeNm(smallEncFeNm);
        smallImage.setFeExt(smallExt);
        smallImage.setFeSz(smallFeSz);
        smallImage.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        smallImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        smallImage.setUseYn("Y");
        smallImage.setImgOdr(0);

        ImageIO.write(newImage2, smallExt, new File(smallPath));
        registerService.imgSave(smallImage);


        if (multipartFiles != null) {
            int odr = 1;
            for (MultipartFile file : multipartFiles) {
                if (!file.isEmpty()) {

                    FileUploadUtil ctnDetUploadUtil = new FileUploadUtil(file, uploadFilePath);

                    Image ctnDetImage = new Image();
                    ctnDetImage.setImgGrpId(imgGrpId);
                    ctnDetImage.setImgTyCd(CARD_DET_IMG);

                    String ctnDetEncFileName = ctnDetUploadUtil.getEncFileName();

                    ctnDetImage.setPath(ctnDetUploadUtil.getPath(ctnDetEncFileName));
                    ctnDetImage.setFeNm(ctnDetUploadUtil.getFileName());
                    ctnDetImage.setEncFeNm(ctnDetEncFileName);
                    ctnDetImage.setFeExt(ctnDetUploadUtil.getExtension());
                    ctnDetImage.setFeSz(ctnDetUploadUtil.getSize());
                    ctnDetImage.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                    ctnDetImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                    ctnDetImage.setImgOdr(odr);
                    ctnDetImage.setUseYn("Y");

                    ctnDetUploadUtil.UploadImage(ctnDetEncFileName);
                    registerService.imgSave(ctnDetImage);

                    odr += 1;
                }
            }
        }


        content.setImgGrpId(imgGrpId);
        content.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        content.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        content.setUseYn("Y");
        registerService.ctnSave(content);


        ContentDet contentDet = new ContentDet();
        contentDet.setCtnSeq(registerService.getCtnSeq(imgGrpId));
        contentDet.setImgGrpId(content.getImgGrpId());
        contentDet.setTplCd(content.getTplCd());
        contentDet.setUrlAddr(inputUrl);
        contentDet.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        contentDet.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        contentDet.setUseYn("Y");

        registerService.ctnDetSave(contentDet);

        int ctnSeq = contentDet.getCtnSeq();

        return "redirect:/content/update/" + Integer.toString(ctnSeq);
    }




}
