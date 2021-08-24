package sptek.spdevteam.intern.quiz.domain;

import lombok.Data;

@Data
public class QuizDetail {
    public String quizSeq;
    public String quizTyCd;
    public String imgGrpId;
    public String quizDtlSeq;
    public String quizQst;
    public String ansUseYn;
    public String cmtUseYn;
    public String cmtCnt;
    public String abImgYn;
    public String quizAns;
    public String crtAnsClv;
    public String wrgAnsClv;
    public String notUseClv;
}
