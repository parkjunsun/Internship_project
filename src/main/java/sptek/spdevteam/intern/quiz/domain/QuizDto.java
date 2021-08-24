package sptek.spdevteam.intern.quiz.domain;

import lombok.Data;

@Data
public class QuizDto {
    private Integer qzSeq;
    private String imgGrpId;
    private String qzNm;
    private String stDt;
    private String endDt;
    private String pshYn;
    private String dspYn;
    private String mxPrt;
    private String regDt;
    private String modDt;
    private String viewCnt;
    private String useYn;
}
