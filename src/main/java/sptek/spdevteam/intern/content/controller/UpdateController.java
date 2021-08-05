package sptek.spdevteam.intern.content.controller;

import lombok.RequiredArgsConstructor;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sptek.spdevteam.intern.common.CommonService;
import sptek.spdevteam.intern.content.domain.*;
import sptek.spdevteam.intern.content.service.UpdateService;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/content")
public class UpdateController {

    private final CommonService commonService;
    private final UpdateService updateService;

    private static final String CARD_TYPE = "T0001";
    private static final String URL_TYPE = "T0002";

    private static final String COMMON_REPR_IMG = "I0001";
    private static final String CARD_DET_IMG = "I0004";

    @GetMapping("/update/{ctnSeq}")
    public String updateForm(Model model, @PathVariable("ctnSeq") int ctnSeq) {


        List<SrcDto> srcList = commonService.getSrcList();
        model.addAttribute("srcList", srcList);

        Content findContent = updateService.getContent(ctnSeq);

        findContent.setDspStDt(findContent.getDspStDt().substring(0, 10));
        findContent.setDspEndDt(findContent.getDspEndDt().substring(0, 10));

        String tplCd = findContent.getTplCd();
        String tplNm = "";
        String srcNm = updateService.getSrcName(findContent.getSrcCd());

        if (tplCd.equals(CARD_TYPE)) {
            tplNm = "카드형";
        } else {
            tplNm = "URL형";
        }

        model.addAttribute("content", findContent);


        model.addAttribute("tplNm", tplNm);
        model.addAttribute("srcNm", srcNm);

        String imgGrpId = findContent.getImgGrpId();

        List<Image> images = updateService.getImages(imgGrpId);
        for (Image image : images) {
            if (image.getImgTyCd().equals(COMMON_REPR_IMG)) {
                model.addAttribute("reprImg", image);
            }
        }

        return "content/content_update";

    }

    @PostMapping("/update/{ctnSeq}")
    public String update(@PathVariable("ctnSeq") int ctnSeq, @RequestParam String ctnNm, @RequestParam String ctnDiv, @RequestParam String dspYn,
                         @RequestParam String cmtYn, @RequestParam String srcCd, @RequestParam String cstYn, @RequestParam String popMsg) {

        Content content = updateService.getContent(ctnSeq);

        content.setCtnNm(ctnNm);
        content.setCtnDiv(ctnDiv);
        content.setDspYn(dspYn);
        content.setCmtYn(cmtYn);
        content.setSrcCd(srcCd);
        content.setCstYn(cstYn);
        content.setPopMsg(popMsg);
        content.setModDt(Timestamp.valueOf(LocalDateTime.now()));

        updateService.updateContent(content);

        return "redirect:/";
    }

//    @GetMapping(value = "/update/{ctnSeq}", produces = MediaType.IMAGE_JPEG_VALUE)
//    public ResponseEntity<byte[]> userSearch(@PathVariable("ctnSeq") int ctnSeq) throws IOException {
//
//        Content findContent = updateService.getContent(ctnSeq);
//        String imgGrpId = findContent.getImgGrpId();
//
//        List<Image> images = updateService.getImages(imgGrpId);
//        Image image = images.get(0);
//
//        InputStream imageStream = new FileInputStream(image.getPath());
//        byte[] imageByteArray = IOUtils.toByteArray(imageStream);
//        imageStream.close();
//
//        return new ResponseEntity<>(imageByteArray, HttpStatus.OK);
//
//    }

}
