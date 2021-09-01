package sptek.spdevteam.intern.quiz.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sptek.spdevteam.intern.common.CommonService;
import sptek.spdevteam.intern.common.FileUploadUtil;
import sptek.spdevteam.intern.common.RandomOutUtil;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.service.RegisterService;
import sptek.spdevteam.intern.quiz.domain.Quiz;
import sptek.spdevteam.intern.quiz.domain.QuizDetail;
import sptek.spdevteam.intern.quiz.domain.QuizOption;
import sptek.spdevteam.intern.quiz.domain.QuizType;
import sptek.spdevteam.intern.quiz.service.QuizRegisterService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/quiz")
public class QuizRegisterController {

    private static final String COMMON_REPR_IMG = "I0001";
    private static final String COMMON_BIG_IMG = "I0002";
    private static final String COMMON_SMALL_IMG = "I0003";
    private static final String QUIZ_MAIN_IMG = "I0005";
    private static final String QUIZ_A_IMG = "I0006";
    private static final String QUIZ_B_IMG = "I0007";

    private final RandomOutUtil randomOutUtil;
    private final RegisterService registerService;
    private final QuizRegisterService quizRegisterService;


    @Value("/home/ec2-user/")
    private String uploadFilePath;

    private final QuizRegisterService service;

    @GetMapping("/register")
    public ModelAndView getMainPage() throws Exception {
        List<QuizType> types = service.getTypes();
        System.out.println("types = " + types);
        ModelAndView mv = new ModelAndView("/quiz/quiz_register");
        mv.addObject("types", types);
        return mv;
    }

    @PostMapping("/register")
    public String saveQuiz(HttpServletRequest request,
                           HttpServletResponse response,
                           @RequestParam("mainImage") MultipartFile mainImage,
                           @RequestParam("quizMainImage") ArrayList<MultipartFile> quizMainImages,
                           @Nullable @RequestParam("quizABImage") ArrayList<MultipartFile> quizABImages) throws Exception {
        Map<String, String[]> paramMap = request.getParameterMap();
        HashMap<String, Object> map = new HashMap<>();
        for (String key  : paramMap.keySet()) {
            map.put(key,paramMap.get(key)[0]);
        }
        System.out.println("map = " + map);
        System.out.println("mainImage = " + mainImage);
        System.out.println("quizMainImage = " + quizMainImages);
        System.out.println("quizABImage = " + quizABImages);

        FileUploadUtil fileUploadUtil = new FileUploadUtil(mainImage, uploadFilePath);

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


        Quiz quiz = new Quiz();
        quiz.setQuizNm(request.getParameter("quizNm"));
        quiz.setDspStDt(request.getParameter("dspStDt"));
        quiz.setDspEndDt(request.getParameter("dspEndDt"));
        quiz.setDspYn(request.getParameter("dspYn"));
        quiz.setMaxPrt(request.getParameter("maxPrt"));
        quiz.setPushYn(request.getParameter("pushYn"));
        quiz.setUseYn(request.getParameter("useYn"));
        quiz.setImgGrpId(imgGrpId);

        quizRegisterService.quizSave(quiz);
        HashMap<String, String> quizSeqMap = new HashMap<>();
        quizSeqMap.put("imgGrpId",quiz.getImgGrpId());
        int quizSeq = quizRegisterService.getQuizSeq(quizSeqMap);



        String quizListStr = request.getParameter("quizOrder");
        String[] quizList = quizListStr.split("_");

        int sequence = 0;
        imgGrpId = randomOutUtil.getRandomStr();
        for (String index : quizList) {
            QuizDetail qd = new QuizDetail();
            fileUploadUtil = new FileUploadUtil(quizMainImages.get(sequence), uploadFilePath);

            image = new Image();
            image.setImgGrpId(imgGrpId);
            image.setImgTyCd(QUIZ_MAIN_IMG);

            encFileName = fileUploadUtil.getEncFileName();

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

            qd.setQuizTyCd(request.getParameter("searchType_" + index));
            String type = qd.getQuizTyCd();
            if (type.equals("Q0002")){
                qd.setAbImgYn(request.getParameter("imgYn_"+index));
            }
            qd.setImgGrpId(imgGrpId);
            qd.setQuizQst(request.getParameter("quizQuestion_" + index));
            qd.setQuizSeq(Integer.toString(quizSeq));
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
                qoA.setQuizSeq(Integer.toString(quizSeq));
                qoB.setQuizSeq(Integer.toString(quizSeq));

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

            sequence += 1;
        }
        return "redirect:/quiz/update/" + Integer.toString(quizSeq);
    }
}
