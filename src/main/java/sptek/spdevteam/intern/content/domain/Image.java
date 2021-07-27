package sptek.spdevteam.intern.content.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Image {

    private int imgSeq;
    private String imgGrpId;
    private String imgTyCd;
    private String path;
    private String feNm;
    private String encFrNm;
    private String feExt;
    private int feSz;
    private LocalDateTime regDt;
    private LocalDateTime modDt;
    private String useYn;
    private int imgOdr;

}
