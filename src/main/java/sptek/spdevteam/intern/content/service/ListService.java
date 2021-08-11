package sptek.spdevteam.intern.content.service;

import sptek.spdevteam.intern.content.domain.ContentExcel;
import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.domain.TempType;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ListService {
    public List<TempType> getTempList() throws Exception;
    public List<ContentExcel> getList(ContentExcel contentExcel) throws Exception;
    public List<ContentExcel> getBoardList(HashMap<String,Object> map) throws Exception;
    public int getBoardListCnt(HashMap<String, Object> map) throws Exception;

    public void updateDspYn(HashMap<String, Object> map) throws Exception;
}
