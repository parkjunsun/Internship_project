package sptek.spdevteam.intern.content.domain;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ContentDet {

    private int ctnDetSeq;
    private int ctnSeq;
    private String imgGrpId;
    private String tplCd;
    private String urlAddr;
    private Timestamp regDt;
    private Timestamp modDt;
    private String useYn;

}
