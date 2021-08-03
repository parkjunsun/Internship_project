package sptek.spdevteam.intern.content.domain;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ContentExcel {

    private int ctnSeq;
    private String tplCd;
    private String srcCd;

    private String tplNm;
    private String srcNm;
    private String ctnNm;
    private String dspStDt;
    private String dspEndDt;
    private String ctnDiv;
    private String dspYn;
}
