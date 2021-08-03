package sptek.spdevteam.intern.content.domain;

import lombok.Data;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
public class Image {

    private int imgSeq;
    private String imgGrpId;
    private String imgTyCd;
    private String path;
    private String feNm;
    private String encFeNm;
    private String feExt;
    private long feSz;
    private Timestamp regDt;
    private Timestamp modDt;
    private String useYn;
    private int imgOdr;

}
