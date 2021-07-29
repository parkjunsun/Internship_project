package sptek.spdevteam.intern.temp.domain;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class TempDomain {
    private String stringValue1;
    private String stringValue2;
    private String stringValue3;

    private int intValue1;
    private int intValue2;
    private int intValue3;

    private String findWord;
    private int cudCnt;

    private List list;
    private Map map;
}

