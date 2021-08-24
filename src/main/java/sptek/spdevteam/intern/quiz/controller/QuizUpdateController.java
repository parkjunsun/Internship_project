package sptek.spdevteam.intern.quiz.controller;

import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sptek.spdevteam.intern.common.FileUploadUtil;
import sptek.spdevteam.intern.common.RandomOutUtil;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.service.RegisterService;
import sptek.spdevteam.intern.quiz.domain.*;
import sptek.spdevteam.intern.quiz.service.QuizRegisterService;
import sptek.spdevteam.intern.quiz.service.QuizUpdateService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequiredArgsConstructor
public class QuizUpdateController {

    private final QuizUpdateService quizUpdateService;
    private final QuizRegisterService quizRegisterService;
    private final RegisterService registerService;
    private final RandomOutUtil randomOutUtil;

    @Value("/home/koji/SPTEK/images/")
    private String uploadFilePath;


    private static final String COMMON_REPR_IMG = "I0001";
    private static final String COMMON_BIG_IMG = "I0002";
    private static final String COMMON_SMALL_IMG = "I0003";
    private static final String QUIZ_MAIN_IMG = "I0005";
    private static final String QUIZ_A_IMG = "I0006";
    private static final String QUIZ_B_IMG = "I0007";

    @GetMapping("/quiz/update/{quizSeq}")
    public String listQuiz(Model model, @PathVariable("quizSeq") String quizSeq){
        QuizDto quiz = quizUpdateService.getQuiz(Integer.parseInt(quizSeq));
        System.out.println("quiz = " + quiz);
        model.addAttribute("quiz", quiz);
        List<QuizType> types = quizRegisterService.getTypes();
        model.addAttribute("types", types);
        List<Image> quizImage = quizUpdateService.getImages(quiz.getImgGrpId(), "y");
        model.addAttribute("quizImage", quizImage.get(0));
        List<QuizDtl> quizDtls = quizUpdateService.getQuizDtl(Integer.parseInt(quizSeq));
        model.addAttribute("quizDtls", quizDtls);
        List<Image> qdImages = quizUpdateService.getImages(quizDtls.get(0).getImgGrpId(), "y");
        int totalPtc = quizUpdateService.getTotalPtc(Integer.parseInt(quizSeq));
        model.addAttribute("totalPtc", totalPtc);
        int sequence = 0;
        for (QuizDtl qd : quizDtls) {
            model.addAttribute("qd_" + Integer.toString(sequence), quizDtls.get(sequence));
            model.addAttribute("qdImage_"+Integer.toString(sequence), qdImages.get(sequence));
            List<PtcAns> ptcAns = quizUpdateService.getPtcAns(Integer.parseInt(qd.getQuizDetSeq()));
            model.addAttribute("ptcAns_" + Integer.toString(sequence), ptcAns);
            if(qd.getQuizTyCd().equals("Q0002")){
                List<QuizOption> options = quizUpdateService.getOpt(Integer.parseInt(qd.getQuizDetSeq()));
                model.addAttribute("optionA_"+Integer.toString(sequence), options.get(0));
                model.addAttribute("optionB_"+Integer.toString(sequence), options.get(1));
                if(qd.getAbImgYn().equals("Y")){
                    List<Image> optionImages = quizUpdateService.getImages(options.get(0).getImgGrpId(), "y");
                    model.addAttribute("optionImageA_" + Integer.toString(sequence), optionImages.get(0));
                    model.addAttribute("optionImageB_" + Integer.toString(sequence), optionImages.get(1));
                }
            }
            sequence += 1;
        }

        System.out.println("quiz = " + quiz);
        System.out.println("quizDtl = " + quizDtls);

        return "quiz/quiz_update";
    }

    @PostMapping("/quiz/update/{quizSeq}")
    public String updateQuiz(HttpServletRequest request,
                             HttpServletResponse response,
                             @PathVariable("quizSeq") String quizSeq,
                             @Nullable @RequestParam("mainImage") MultipartFile mainImage,
                             @Nullable @RequestParam("quizMainImage") ArrayList<MultipartFile> quizMainImages,
                             @Nullable @RequestParam("quizABImage") ArrayList<MultipartFile> quizABImages) throws Exception {

        Map<String, String[]> paramMap = request.getParameterMap();
        HashMap<String, Object> map = new HashMap<>();
        for (String key  : paramMap.keySet()) {
            map.put(key,paramMap.get(key)[0]);
        }
        System.out.println("map = " + map);
        System.out.println("mainImage = " + mainImage);

        FileUploadUtil fileUploadUtil = new FileUploadUtil(mainImage, uploadFilePath);
        QuizDto quiz = quizUpdateService.getQuiz(Integer.parseInt(quizSeq));

        // 메인이미지 변경시
        if(!mainImage.isEmpty()){
            List<Image> exImg = quizUpdateService.getImages(quiz.getImgGrpId(), "y");
            quizUpdateService.disableImg(exImg.get(0).getImgSeq());


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
            image.setUseYn("y");

            fileUploadUtil.UploadImage(encFileName);
            registerService.imgSave(image);

            HashMap<String, String> hashMap = new HashMap<>();
            hashMap.put("imgGrpId", imgGrpId);
            hashMap.put("qzSeq", quizSeq);
            quizUpdateService.updateQzImgGrpId(hashMap);
        }

        HashMap<String, String> updateQuizHashMap = new HashMap<>();
        updateQuizHashMap.put("qzNm", request.getParameter("quizNm"));
        updateQuizHashMap.put("stDt", request.getParameter("dspStDt"));
        updateQuizHashMap.put("endDt", request.getParameter("dspEndDt"));
        updateQuizHashMap.put("pshYn", request.getParameter("pushYn"));
        updateQuizHashMap.put("mxPrt", request.getParameter("maxPrt"));
        updateQuizHashMap.put("qzSeq", quizSeq);

        quizUpdateService.updateQuiz(updateQuizHashMap);

        int originalCnt = Integer.parseInt(request.getParameter("originalCnt"));

        String quizListStr = request.getParameter("quizOrder");
        String[] quizList = quizListStr.split("_");

        String quizDtlImageStr = request.getParameter("quizDtlImageYn");
        String[] quizDtlImageYnList = quizDtlImageStr.split("_");

        String quizAImageYnStr = request.getParameter("quizAImageYn");
        String[] quizAImageYnStrList = quizAImageYnStr.split("_");

        String quizBImageYnStr = request.getParameter("quizBImageYn");
        String[] quizBImageYnStrList = quizBImageYnStr.split("_");

        List<String> done = new ArrayList<>();

        List<QuizDtl> originalQds = quizUpdateService.getQuizDtl(Integer.parseInt(quizSeq));

        int sequence = 0;
        for (int index=0;index<quizList.length;index++) {
            String quizIndex = quizList[index];
            String quizDtlImageYn = quizDtlImageYnList[index];
            // 기존 퀴즈
            if (Integer.parseInt(quizIndex) < originalCnt) {
                done.add(quizIndex);
                QuizDtl originalQd = originalQds.get(Integer.parseInt(quizIndex));
                // 퀴즈 질문이미지 변경시
                if(quizDtlImageYn.equals("O")){
                    List<Image> originalImages = quizUpdateService.getImages(originalQd.getImgGrpId(), "y" );
                    quizUpdateService.disableImg(originalImages.get(0).getImgSeq());

                    fileUploadUtil = new FileUploadUtil(quizMainImages.get(index), uploadFilePath);

                    Image image = new Image();
                    String imgGrpId = originalQd.getImgGrpId();
                    image.setImgGrpId(imgGrpId);
                    image.setImgTyCd(QUIZ_MAIN_IMG);

                    String encFileName = fileUploadUtil.getEncFileName();

                    image.setPath(fileUploadUtil.getPath(encFileName));
                    image.setFeNm(fileUploadUtil.getFileName());
                    image.setEncFeNm(encFileName);
                    image.setFeExt(fileUploadUtil.getExtension());
                    image.setFeSz(fileUploadUtil.getSize());
                    image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                    image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                    image.setImgOdr(sequence);
                    image.setUseYn("y");

                    fileUploadUtil.UploadImage(encFileName);
                    registerService.imgSave(image);
                }
                // 미변경시
                else{
                    List<Image> originalImages = quizUpdateService.getImages(originalQd.getImgGrpId(), "y" );
                    Image image = originalImages.get(0);
                    image.setImgOdr(sequence);
                    quizUpdateService.updateImg(image);
                }
                String originalType = originalQd.getQuizTyCd();
                // 기존에 AB형인 경우
                if (originalType.equals("Q0002")){
                    // 선택지
                    List<QuizOption> originalOptions = quizUpdateService.getOpt(Integer.parseInt(originalQd.getQuizDetSeq()));
                    QuizOption originalQoA = originalOptions.get(0);
                    QuizOption originalQoB = originalOptions.get(1);

                    // OX로 바꾼 경우
                    if (request.getParameter("searchType_" + quizIndex).equals("Q0001")) {
                        // 기존에 이미지를 사용한 경우
                        if(originalQd.getAbImgYn().equals("Y")){
                            // 기존 이미지 disable
                            List<Image> imgs = quizUpdateService.getImages(originalQoA.getImgGrpId(), "y");
                            quizUpdateService.disableImg(imgs.get(0).getImgSeq());
                            quizUpdateService.disableImg(imgs.get(1).getImgSeq());
                        }
                        // 옵션 disable
                        originalQoA.setUseYn("N");
                        originalQoB.setUseYn("N");

                        // 옵션 update
                        quizUpdateService.updateQuizOption(originalQoA);
                        quizUpdateService.updateQuizOption(originalQoB);
                    }
                    // 그대로 AB인 경우
                    else{
                        List<Image> abImages = quizUpdateService.getImages(originalQoA.getImgGrpId(), "y");
                        // 기존에 이미지 사용 안한 경우
                        if (abImages.isEmpty()){
                            MultipartFile imageA = quizABImages.get(0);
                            MultipartFile imageB = quizABImages.get(1);
                            quizABImages.remove(0);
                            quizABImages.remove(0);

                            fileUploadUtil = new FileUploadUtil(imageA, uploadFilePath);
                            Image image = new Image();

                            String optImgGrpId = randomOutUtil.getRandomStr();

                            String encFileName = fileUploadUtil.getEncFileName();

                            image.setImgGrpId(optImgGrpId);
                            image.setImgTyCd(QUIZ_A_IMG);
                            image.setPath(fileUploadUtil.getPath(encFileName));
                            image.setFeNm(fileUploadUtil.getFileName());
                            image.setEncFeNm(encFileName);
                            image.setFeExt(fileUploadUtil.getExtension());
                            image.setFeSz(fileUploadUtil.getSize());
                            image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setImgOdr(0);
                            image.setUseYn("y");

                            fileUploadUtil.UploadImage(encFileName);
                            registerService.imgSave(image);

                            fileUploadUtil = new FileUploadUtil(imageB, uploadFilePath);
                            image = new Image();

                            encFileName = fileUploadUtil.getEncFileName();

                            image.setImgGrpId(optImgGrpId);
                            image.setImgTyCd(QUIZ_B_IMG);
                            image.setPath(fileUploadUtil.getPath(encFileName));
                            image.setFeNm(fileUploadUtil.getFileName());
                            image.setEncFeNm(encFileName);
                            image.setFeExt(fileUploadUtil.getExtension());
                            image.setFeSz(fileUploadUtil.getSize());
                            image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setImgOdr(1);
                            image.setUseYn("y");

                            fileUploadUtil.UploadImage(encFileName);
                            registerService.imgSave(image);

                            originalQoA.setImgGrpId(optImgGrpId);
                            originalQoB.setImgGrpId(optImgGrpId);

                            // 옵션 update
                            quizUpdateService.updateQuizOption(originalQoA);
                            quizUpdateService.updateQuizOption(originalQoB);
                        }
                        // 기존에 이미지를 사용한 경우
                        else{
                            // 이미지 A가 변경된 경우
                            if (quizAImageYnStrList[Integer.parseInt(quizIndex)].equals("O")) {
                                Image originalImageA = abImages.get(0);
                                // 기존 이미지 disable
                                quizUpdateService.disableImg(originalImageA.getImgSeq());

                                MultipartFile imageA = quizABImages.get(0);

                                fileUploadUtil = new FileUploadUtil(imageA, uploadFilePath);
                                Image image = new Image();

                                String optImgGrpId = originalImageA.getImgGrpId();

                                String encFileName = fileUploadUtil.getEncFileName();

                                image.setImgGrpId(optImgGrpId);
                                image.setImgTyCd(QUIZ_A_IMG);
                                image.setPath(fileUploadUtil.getPath(encFileName));
                                image.setFeNm(fileUploadUtil.getFileName());
                                image.setEncFeNm(encFileName);
                                image.setFeExt(fileUploadUtil.getExtension());
                                image.setFeSz(fileUploadUtil.getSize());
                                image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                                image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                                image.setImgOdr(0);
                                image.setUseYn("y");

                                fileUploadUtil.UploadImage(encFileName);
                                registerService.imgSave(image);

                            }
                            quizABImages.remove(0);
                            // 이미지 B가 변경된 경우
                            if (quizBImageYnStrList[Integer.parseInt(quizIndex)].equals("O")) {
                                Image originalImageB = abImages.get(1);
                                // 기존 이미지 disable
                                quizUpdateService.disableImg(originalImageB.getImgSeq());

                                MultipartFile imageB = quizABImages.get(0);

                                fileUploadUtil = new FileUploadUtil(imageB, uploadFilePath);
                                Image image = new Image();

                                String optImgGrpId = originalImageB.getImgGrpId();

                                String encFileName = fileUploadUtil.getEncFileName();

                                image.setImgGrpId(optImgGrpId);
                                image.setImgTyCd(QUIZ_B_IMG);
                                image.setPath(fileUploadUtil.getPath(encFileName));
                                image.setFeNm(fileUploadUtil.getFileName());
                                image.setEncFeNm(encFileName);
                                image.setFeExt(fileUploadUtil.getExtension());
                                image.setFeSz(fileUploadUtil.getSize());
                                image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                                image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                                image.setImgOdr(1);
                                image.setUseYn("y");

                                fileUploadUtil.UploadImage(encFileName);
                                registerService.imgSave(image);

                            }
                            quizABImages.remove(0);
                        }
                    }
                }

                // 기존에 OX형인 경우
                else{
                    // AB로 바뀐 경우
                    if (request.getParameter("searchType_" + quizIndex).equals("Q0002")) {
                        QuizOption qoA = new QuizOption();
                        QuizOption qoB = new QuizOption();

                        MultipartFile imageA = quizABImages.get(0);
                        MultipartFile imageB = quizABImages.get(1);
                        quizABImages.remove(0);
                        quizABImages.remove(0);

                        String optImgGrpId = randomOutUtil.getRandomStr();


                        // 바뀌었는데 이미지 없는 경우
                        if(imageA.isEmpty()){
                            qoA.setUseYn("Y");
                            qoA.setQuizSeq(quizSeq);
                            qoA.setQuizDetSeq(originalQd.getQuizDetSeq());
                            qoA.setOptCnt(request.getParameter("A_"+quizIndex));
                        }
                        else{
                            fileUploadUtil = new FileUploadUtil(imageA, uploadFilePath);
                            Image image = new Image();


                            String encFileName = fileUploadUtil.getEncFileName();

                            image.setImgGrpId(optImgGrpId);
                            image.setImgTyCd(QUIZ_A_IMG);
                            image.setPath(fileUploadUtil.getPath(encFileName));
                            image.setFeNm(fileUploadUtil.getFileName());
                            image.setEncFeNm(encFileName);
                            image.setFeExt(fileUploadUtil.getExtension());
                            image.setFeSz(fileUploadUtil.getSize());
                            image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setImgOdr(0);
                            image.setUseYn("y");

                            fileUploadUtil.UploadImage(encFileName);
                            registerService.imgSave(image);

                            qoA.setImgGrpId(optImgGrpId);
                        }

                        if(imageB.isEmpty()){
                            qoB.setUseYn("Y");
                            qoB.setQuizSeq(quizSeq);
                            qoB.setQuizDetSeq(originalQd.getQuizDetSeq());
                            qoB.setOptCnt(request.getParameter("B_"+quizIndex));
                        }
                        else{
                            fileUploadUtil = new FileUploadUtil(imageB, uploadFilePath);
                            Image image = new Image();

                            String encFileName = fileUploadUtil.getEncFileName();

                            image.setImgGrpId(optImgGrpId);
                            image.setImgTyCd(QUIZ_B_IMG);
                            image.setPath(fileUploadUtil.getPath(encFileName));
                            image.setFeNm(fileUploadUtil.getFileName());
                            image.setEncFeNm(encFileName);
                            image.setFeExt(fileUploadUtil.getExtension());
                            image.setFeSz(fileUploadUtil.getSize());
                            image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                            image.setImgOdr(1);
                            image.setUseYn("y");

                            fileUploadUtil.UploadImage(encFileName);
                            registerService.imgSave(image);

                            qoB.setImgGrpId(optImgGrpId);
                        }


                        // 옵션 update
                        quizRegisterService.quizOptionSave(qoA);
                        quizRegisterService.quizOptionSave(qoB);
                    }
                }

                originalQd.setQuizTyCd(request.getParameter("searchType_" + quizIndex));
                String type = request.getParameter("searchType_"+quizIndex);
                if (type.equals("Q0002")){
                    originalQd.setAbImgYn(request.getParameter("imgYn_"+quizIndex));
                }
                originalQd.setQuizQst(request.getParameter("quizQuestion_" + quizIndex));
                originalQd.setQuizSeq(quizSeq);
                originalQd.setQuizDtlSeq(Integer.toString(sequence));
                String ansYn = request.getParameter("ansYn_" + quizIndex);
                originalQd.setAnsUseYn(ansYn);
                originalQd.setQuizDtlSeq(Integer.toString(index));

                if (ansYn.equals("Y")){
                    originalQd.setCrtAnsClv(request.getParameter("ansClov_" + quizIndex));
                    originalQd.setWrgAnsClv(request.getParameter("wngClov_" + quizIndex));
                    if (type.equals("Q0002")){
                        originalQd.setQuizAns(request.getParameter("corAB_"+quizIndex));
                    }
                    else{
                        originalQd.setQuizAns(request.getParameter("corOX_"+quizIndex));
                    }
                    originalQd.setCmtUseYn(request.getParameter("comYn_" + quizIndex));
                    if (request.getParameter("comYn_" + quizIndex).equals("Y")){
                        originalQd.setCmtCnt(request.getParameter("comment_" + quizIndex));
                    }
                }
                else{
                    originalQd.setNotUseClv(request.getParameter("ansN_clov_" + quizIndex));
                }
                quizUpdateService.updateQuizDtl(originalQd);



            }
            // 추가된 퀴즈
            else{
                String imgGrpId = originalQds.get(0).getImgGrpId();
                QuizDetail qd = new QuizDetail();
                fileUploadUtil = new FileUploadUtil(quizMainImages.get(index), uploadFilePath);

                Image image = new Image();
                image.setImgGrpId(imgGrpId);
                image.setImgTyCd(QUIZ_MAIN_IMG);

                String encFileName = fileUploadUtil.getEncFileName();

                image.setPath(fileUploadUtil.getPath(encFileName));
                image.setFeNm(fileUploadUtil.getFileName());
                image.setEncFeNm(encFileName);
                image.setFeExt(fileUploadUtil.getExtension());
                image.setFeSz(fileUploadUtil.getSize());
                image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                image.setImgOdr(index);
                image.setUseYn("y");

                fileUploadUtil.UploadImage(encFileName);
                registerService.imgSave(image);

                qd.setQuizTyCd(request.getParameter("searchType_" + index));
                qd.setQuizDtlSeq(Integer.toString(index));
                String type = qd.getQuizTyCd();
                if (type.equals("Q0002")){
                    qd.setAbImgYn(request.getParameter("imgYn_"+index));
                }
                qd.setImgGrpId(imgGrpId);
                qd.setQuizQst(request.getParameter("quizQuestion_" + index));
                qd.setQuizSeq(quizSeq);
                qd.setQuizDtlSeq(Integer.toString(sequence));
                String ansYn = request.getParameter("ansYn_" + index);
                qd.setAnsUseYn(ansYn);

                if (ansYn.equals("Y")){
                    qd.setCrtAnsClv(request.getParameter("ansClov_" + index));
                    qd.setWrgAnsClv(request.getParameter("wngClov_" + index));
                    if (type.equals("Q0002")){
                        qd.setQuizAns(request.getParameter("corAB_"+index));
                    }
                    else{
                        qd.setQuizAns(request.getParameter("corOX_"+index));
                    }
                    qd.setCmtUseYn(request.getParameter("comYn_" + index));
                    if (request.getParameter("comYn_" + index).equals("Y")){
                        qd.setCmtCnt(request.getParameter("comment_" + index));
                    }
                }
                else{
                    qd.setNotUseClv(request.getParameter("ansN_clov_" + index));
                }


                HashMap<String, String> getQuizDtlSeqMap = new HashMap<>();
                getQuizDtlSeqMap.put("sequence", qd.getQuizDtlSeq());
                getQuizDtlSeqMap.put("imgGrpId", qd.getImgGrpId());

                quizRegisterService.quizDtlSave(qd);
                int quizDtlSeq = quizRegisterService.getQuizDtlSeq(getQuizDtlSeqMap);

                // AB형
                if (type.equals("Q0002")){
                    // 선택지
                    QuizOption qoA = new QuizOption();
                    QuizOption qoB = new QuizOption();

                    qoA.setQuizDetSeq(Integer.toString(quizDtlSeq));
                    qoB.setQuizDetSeq(Integer.toString(quizDtlSeq));
                    qoA.setQuizSeq(quizSeq);
                    qoB.setQuizSeq(quizSeq);

                    // 이미지 사용
                    if (qd.getAbImgYn().equals("Y")){
                        MultipartFile imageA = quizABImages.get(0);
                        MultipartFile imageB = quizABImages.get(1);
                        quizABImages.remove(0);
                        quizABImages.remove(0);

                        fileUploadUtil = new FileUploadUtil(imageA, uploadFilePath);
                        image = new Image();

                        String optImgGrpId = randomOutUtil.getRandomStr();

                        encFileName = fileUploadUtil.getEncFileName();

                        image.setImgGrpId(optImgGrpId);
                        image.setImgTyCd(QUIZ_A_IMG);
                        image.setPath(fileUploadUtil.getPath(encFileName));
                        image.setFeNm(fileUploadUtil.getFileName());
                        image.setEncFeNm(encFileName);
                        image.setFeExt(fileUploadUtil.getExtension());
                        image.setFeSz(fileUploadUtil.getSize());
                        image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                        image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                        image.setImgOdr(0);
                        image.setUseYn("y");

                        fileUploadUtil.UploadImage(encFileName);
                        registerService.imgSave(image);

                        fileUploadUtil = new FileUploadUtil(imageB, uploadFilePath);
                        image = new Image();

                        encFileName = fileUploadUtil.getEncFileName();

                        image.setImgGrpId(optImgGrpId);
                        image.setImgTyCd(QUIZ_B_IMG);
                        image.setPath(fileUploadUtil.getPath(encFileName));
                        image.setFeNm(fileUploadUtil.getFileName());
                        image.setEncFeNm(encFileName);
                        image.setFeExt(fileUploadUtil.getExtension());
                        image.setFeSz(fileUploadUtil.getSize());
                        image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
                        image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
                        image.setImgOdr(1);
                        image.setUseYn("y");

                        fileUploadUtil.UploadImage(encFileName);
                        registerService.imgSave(image);

                        qoA.setImgGrpId(optImgGrpId);
                        qoB.setImgGrpId(optImgGrpId);
                    }
                    // 선택지 사용
                    qoA.setOptCnt(request.getParameter("A_"+index));
                    qoB.setOptCnt(request.getParameter("B_"+index));



                    quizRegisterService.quizOptionSave(qoA);
                    quizRegisterService.quizOptionSave(qoB);

                }
            }
            sequence += 1;
        }

        return "redirect:/quiz/update/"+quizSeq;
    }

//    @PostMapping("/quiz/excel/download")
//    public void excelDownload(HttpServletResponse response, @RequestParam("quizSeq") String quizSeq){
//
//        QuizDto quiz = quizUpdateService.getQuiz(Integer.parseInt(quizSeq));
//        List<QuizDtl> quizDtls = quizUpdateService.getQuizDtl(Integer.parseInt(quizSeq));
//
//        Workbook wb = new XSSFWorkbook();
//        Sheet sheet = wb.createSheet("sheet");
//        Row row = null;
//        Cell cell = null;
//        int rowNum = 0;
//
//        row = sheet.createRow(rowNum++);
//        String[] headers = {"퀴즈명", "퀴즈질문", "퀴즈답변", "답변자수"};
//
//        CellStyle middleArrange = wb.createCellStyle();
//        middleArrange.setAlignment(HorizontalAlignment.CENTER);
//
//        //Header
//        for(int i = 0; i<7; i++) {
//            cell = row.createCell(i);
//            cell.setCellStyle(middleArrange);
//            cell.setCellValue(headers[i]);
//        }
//
//        //Body
//        int seq = 1;
//        for (QuizDtl qd : quizDtls) {
//            List<PtcAns> ptcAns = quizUpdateService.getPtcAns(Integer.parseInt(qd.getQuizDetSeq()));
//            quizUpdateService.getOpt(Integer.parseInt(qd.getQuizDetSeq()));
//            // OX형인 경우
//            if(qd.getQuizTyCd().equals("Q0001")){
//                row = sheet.createRow(rowNum++);
//
//                cell = row.createCell(0);
//                cell.setCellStyle(middleArrange);
//                cell.setCellValue(quiz.getQzNm());
//
//                cell = row.createCell(1);
//                cell.setCellStyle(middleArrange);
//                cell.setCellValue(qd.getQuizQst());
//
////                cell = row.createCell(2);
////                cell.setCellStyle(middleArrange);
////                cell.setCellValue();
////
////                cell = row.createCell(3);
////                cell.setCellStyle(middleArrange);
////                cell.setCellValue(quizDto.getQzSeq());
////
////                cell = row.createCell(4);
////                cell.setCellStyle(middleArrange);
////                cell.setCellValue(quizDto.getStDt().substring(0, 16) + " ~ " + quizDto.getEndDt().substring(0, 16));
////
////                cell = row.createCell(5);
////                cell.setCellStyle(middleArrange);
////                String strDspYn = quizDto.getDspYn().equals("Y") ? "전시" : "미전시";
////                cell.setCellValue(strDspYn);
////
////                cell = row.createCell(6);
////                cell.setCellStyle(middleArrange);
////                cell.setCellValue(quizDto.getRegDt().substring(0, 10));
//            }
////            else{
////
////            }
////
////
//        }
////
////
////        for(int i=0; i<7;i++) {
////            sheet.autoSizeColumn(i);
////            sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + (short)1024);
////        }
////
////
////        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
////        String today = simpleDateFormat.format(new Date());
////
////        // 컨텐츠 타입과 파일명 지정
////        response.setContentType("ms-vnd/excel;");
////        response.setCharacterEncoding("UTF-8");
////
////        String fileName = "퀴즈목록_" + today + ".xlsx";
////        String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
////        response.setHeader("Content-Disposition", "attachment; filename=" + outputFileName);
////
////        wb.write(response.getOutputStream());
////        wb.close();
//    }

}
