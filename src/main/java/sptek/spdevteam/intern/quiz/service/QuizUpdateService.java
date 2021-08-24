package sptek.spdevteam.intern.quiz.service;

import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.quiz.domain.*;

import java.util.HashMap;
import java.util.List;

public interface QuizUpdateService {
    public QuizDto getQuiz(int quizSeq);
    public List<QuizDtl> getQuizDtl(int quizSeq);
    public List<PtcAns> getPtcAns(int qzDetSeq);
    public List<Image> getImages(String imgGrpId, String useYn);
    public List<QuizOption> getOpt(int qzDetSeq);
    public int getTotalPtc(int qzSeq);
    public void disableImg(int imgSeq);
    public void updateQzImgGrpId(HashMap<String, String> hashMap);
    public void updateQuiz(HashMap<String, String> hashmap);

    public void updateQuizDtl(QuizDtl quizDtl);

    public void updateQuizOption(QuizOption quizOption);

    public void updateImg(Image image);

}

