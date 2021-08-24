package sptek.spdevteam.intern.quiz.mybatis;

import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.quiz.domain.*;

import java.util.HashMap;
import java.util.List;

public interface QuizUpdateMapper {
    public QuizDto getQuiz(int quizSeq);

    public List<QuizDtl> getQuizDtl(int quizSeq);

    public List<PtcAns> getPtcAns(int qzDetSeq);

    public List<Image> getImages(String imgGrpId, String useYn);

    public List<QuizOption> getOpt(int qzDetSeq);

    public int getTotalPtc(int qzSeq);

    void disableImg(int imgSeq);

    void updateQzImgGrpId(HashMap<String, String> hashMap);

    void updateQuiz(HashMap<String, String> hashmap);

    void updateQuizDtl(QuizDtl quizDtl);

    void updateQuizOption(QuizOption quizOption);

    void updateImg(Image image);
}
