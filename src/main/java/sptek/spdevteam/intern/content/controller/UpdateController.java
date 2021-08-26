package sptek.spdevteam.intern.content.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.relational.core.sql.In;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sptek.spdevteam.intern.common.CommonService;
import sptek.spdevteam.intern.common.FileUploadUtil;
import sptek.spdevteam.intern.content.domain.*;
import sptek.spdevteam.intern.content.service.RegisterService;
import sptek.spdevteam.intern.content.service.UpdateService;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/content")
public class UpdateController {

    private final CommonService commonService;
    private final UpdateService updateService;
    private final RegisterService registerService;

    private static final String CARD_TYPE = "T0001";
    private static final String URL_TYPE = "T0002";

    private static final String COMMON_REPR_IMG = "I0001";
    private static final String COMMON_BIG_IMG = "I0002";
    private static final String COMMON_SMALL_IMG = "I0003";
    private static final String CARD_DET_IMG = "I0004";

    @Value("${uploadFile.path}")
    private String uploadFilePath;

    @GetMapping("/update/{ctnSeq}")
    public String updateForm(Model model, @PathVariable("ctnSeq") int ctnSeq) {


        List<SrcDto> srcList = commonService.getSrcList();
        model.addAttribute("srcList", srcList);

        Content findContent = updateService.getContent(ctnSeq);

        if (findContent.getUseYn().equals("N")) {
            return "content/content_error";
        }

//        findContent.setDspStDt(findContent.getDspStDt().substring(0, 10));
//        findContent.setDspEndDt(findContent.getDspEndDt().substring(0, 10));


        findContent.setDspStDt(findContent.getDspStDt().substring(0, 16));
        findContent.setDspEndDt(findContent.getDspEndDt().substring(0, 16));

        String tplCd = findContent.getTplCd();
        String tplNm = "";
        String srcNm = updateService.getSrcName(findContent.getSrcCd());

        if (tplCd.equals(CARD_TYPE)) {
            tplNm = "카드형";
        } else {
            tplNm = "URL형";
        }

        model.addAttribute("tplNm", tplNm);
        model.addAttribute("srcNm", srcNm);

        model.addAttribute("content", findContent);
        model.addAttribute("tplCd", tplCd);

        String imgGrpId = findContent.getImgGrpId();

        List<Image> images = updateService.getImages(imgGrpId, "Y");
        List<Image> ctnDetImages = new ArrayList<>();

        for (Image image : images) {
            if (image.getImgTyCd().equals(COMMON_REPR_IMG)) {
                model.addAttribute("reprImg", image);
            } else if (image.getImgTyCd().equals(COMMON_BIG_IMG)) {
                model.addAttribute("bigImg", image);
            } else if (image.getImgTyCd().equals(COMMON_SMALL_IMG)) {
                model.addAttribute("smallImg", image);
            } else if (image.getImgTyCd().equals(CARD_DET_IMG)){
                ctnDetImages.add(image);
            }
        }

        model.addAttribute("ctnDetImages", ctnDetImages);

        ContentDet ctnDet = updateService.getCtnDet(ctnSeq);
        String urlAddr = ctnDet.getUrlAddr();

        if(urlAddr != null) {
            model.addAttribute("urlAddr", urlAddr);
        }

        return "content/content_update";
    }


    @PostMapping("/update/{ctnSeq}")
    public String update(@PathVariable("ctnSeq") int ctnSeq, @RequestParam String ctnNm, @RequestParam String ctnDiv, @RequestParam String dspYn,
                         @RequestParam String cmtYn, @RequestParam String srcCd, @RequestParam String cstYn, @RequestParam String popMsg, @RequestParam String dspEndDt,
                         @RequestParam("repr_img") MultipartFile multipartFile, @RequestParam(value = "ctn_img", required = false) List<MultipartFile> multipartFiles,
                         @RequestParam(value = "imgSeq", required = false) List<Integer> imgSeqs, @RequestParam(value = "inputUrl", required = false) String inputUrl) throws IOException {


        Content content = updateService.getContent(ctnSeq);

        content.setCtnNm(ctnNm);
        content.setCtnDiv(ctnDiv);
        content.setDspEndDt(dspEndDt);
        content.setDspYn(dspYn);
        content.setCmtYn(cmtYn);
        content.setSrcCd(srcCd);
        content.setCstYn(cstYn);
        content.setPopMsg(popMsg);
        content.setModDt(Timestamp.valueOf(LocalDateTime.now()));

        updateService.updateContent(content);

        List<Image> images = updateService.getImages(content.getImgGrpId(), "Y");
        Image reprImage = null;
        List<Image> ctnDetImages = new ArrayList<>();

        for (Image image : images) {
            if (image.getImgTyCd().equals(COMMON_REPR_IMG)) {
                reprImage = image;
            } else if (image.getImgTyCd().equals(CARD_DET_IMG)) {
                ctnDetImages.add(image);
            }
        }


        if (!multipartFile.isEmpty()) {
            FileUploadUtil fileUploadUtil = new FileUploadUtil(multipartFile, uploadFilePath);

            String encFileName = fileUploadUtil.getEncFileName();
            reprImage.setPath(fileUploadUtil.getPath(encFileName));
            reprImage.setFeNm(fileUploadUtil.getFileName());
            reprImage.setEncFeNm(encFileName);
            reprImage.setFeExt(fileUploadUtil.getExtension());
            reprImage.setFeSz(fileUploadUtil.getSize());
            reprImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
            reprImage.setUseYn("Y");
            reprImage.setImgOdr(0);

            fileUploadUtil.UploadImage(encFileName);
            updateService.updateImage(reprImage);
        }

        if (multipartFiles != null) {
            int odr = 1;
            for (MultipartFile file : multipartFiles) {

                if (!file.isEmpty()) {
//                    Image ctnDetImage = ctnDetImages.get(odr - 1);
                    if (imgSeqs != null) {
                        if (odr - 1 >= imgSeqs.size()) {
                            Image newImage = new Image();

                            FileUploadUtil util = new FileUploadUtil(file, uploadFilePath);

                            newImage.setImgGrpId(content.getImgGrpId());
                            newImage.setImgTyCd(CARD_DET_IMG);

                            String encFileName = util.getEncFileName();
                            newImage.setPath(util.getPath(encFileName));
                            newImage.setFeNm(util.getFileName());
                            newImage.setEncFeNm(encFileName);
                            newImage.setFeExt(util.getExtension());
                            newImage.setFeSz(util.getSize());
                            newImage.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                            newImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                            newImage.setUseYn("Y");
                            newImage.setImgOdr(odr);

                            util.UploadImage(encFileName);
                            registerService.imgSave(newImage);

                        } else {

                            Integer imgSeq = imgSeqs.get(odr - 1);
                            Image ctnDetImage = updateService.getImage(imgSeq);

                            FileUploadUtil ctnDetUploadUtil = new FileUploadUtil(file, uploadFilePath);

                            String ctnDetEncFileName = ctnDetUploadUtil.getEncFileName();

                            ctnDetImage.setPath(ctnDetUploadUtil.getPath(ctnDetEncFileName));
                            ctnDetImage.setFeNm(ctnDetUploadUtil.getFileName());
                            ctnDetImage.setEncFeNm(ctnDetEncFileName);
                            ctnDetImage.setFeExt(ctnDetUploadUtil.getExtension());
                            ctnDetImage.setFeSz(ctnDetUploadUtil.getSize());
                            ctnDetImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                            ctnDetImage.setUseYn("Y");
                            ctnDetImage.setImgOdr(odr);

                            ctnDetUploadUtil.UploadImage(ctnDetEncFileName);
                            updateService.updateImage(ctnDetImage);
                        }
                    } else {
                        Image newImage = new Image();

                        FileUploadUtil util = new FileUploadUtil(file, uploadFilePath);

                        newImage.setImgGrpId(content.getImgGrpId());
                        newImage.setImgTyCd(CARD_DET_IMG);

                        String encFileName = util.getEncFileName();
                        newImage.setPath(util.getPath(encFileName));
                        newImage.setFeNm(util.getFileName());
                        newImage.setEncFeNm(encFileName);
                        newImage.setFeExt(util.getExtension());
                        newImage.setFeSz(util.getSize());
                        newImage.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                        newImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                        newImage.setUseYn("Y");
                        newImage.setImgOdr(odr);

                        util.UploadImage(encFileName);
                        registerService.imgSave(newImage);
                    }
                } else {
                    // 파일 찾기를 누르지 않은 것은 input hidden값을 받아서 ctnDetImage에 업데이트 시켜야한다.
                    Integer imgSeq = imgSeqs.get(odr - 1);
                    Image findImage = updateService.getImage(imgSeq);
                    findImage.setImgOdr(odr);
//                    findImage.setModDt(Timestamp.valueOf(LocalDateTime.now()));

                    updateService.updateImage(findImage);
                }
                odr += 1;
            }
        }

        if (inputUrl != null) {
            ContentDet ctnDet = updateService.getCtnDet(ctnSeq);
            ctnDet.setUrlAddr(inputUrl);
            ctnDet.setModDt(Timestamp.valueOf(LocalDateTime.now()));

            updateService.updateContentDet(ctnDet);

        }

        return "redirect:/content/update/" + ctnSeq;
    }

    @PostMapping("/delete")
    public Message deleteContent(@RequestParam("ctnSeq") Integer ctnSeq) {

        Content findContent = updateService.getContent(ctnSeq);
        findContent.setUseYn("N");
        findContent.setModDt(Timestamp.valueOf(LocalDateTime.now()));

        updateService.updateContent(findContent);

        Message message = new Message();
        message.setMsg("정상적으로 데이터 삭제가 완료되었습니다.");

        return message;
    }


    @PostMapping("/image/delete")
    public Message deleteImage(@RequestParam(value = "imgSeq[]") List<Integer> imgSeqs) {

        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("imgSeqs", imgSeqs);
        paramMap.put("useYn", "N");
        paramMap.put("modDt", Timestamp.valueOf(LocalDateTime.now()));

        updateService.updateImages(paramMap);

        System.out.println(imgSeqs);
        Message message = new Message();
        message.setMsg("정상적으로 데이터 삭제가 완료되었습니다.");
        return message;
    }

    static class Message {
        private String msg;

        public String getMsg() {return msg;}
        public void setMsg(String msg) {this.msg = msg;}
    }


}
