package sptek.spdevteam.intern.content.domain;

import lombok.Data;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
public class Content {

    private int cntSeq;
    private String tplCd;
    private String srcCd;
    private String imgGrpId;

    private String ctnNm;
    private String dspStDt;
    private String dspEndDt;
    private String ctnDiv;
    private String dspYn;
    private String cmtYn;
    private String cstYn;
    private String popMsg;
    private Long viewCnt;

    private LocalDateTime regDt;
    private LocalDateTime modDt;
    private String useYn;

}
