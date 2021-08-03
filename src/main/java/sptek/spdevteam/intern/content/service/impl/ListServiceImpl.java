package sptek.spdevteam.intern.content.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.common.mybatis.CommonMapper;
import sptek.spdevteam.intern.content.domain.ContentExcel;
import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TempType;
import sptek.spdevteam.intern.content.mybatis.FilterMapper;
import sptek.spdevteam.intern.content.mybatis.ListMapper;
import sptek.spdevteam.intern.content.service.ListService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ListServiceImpl implements ListService {

    private LogUtil log = new LogUtil(ListServiceImpl.class);

    private final FilterMapper filterMapper;
    private final ListMapper listMapper;

    @Override
    public List<TempType> getTempList() {
        return filterMapper.getTempList();
    }

    @Override
    public List<ContentExcel> getList(ContentExcel contentExcel) throws Exception {
        return listMapper.getList(contentExcel);
    }

    @Override
    public List<ContentExcel> getBoardList(HashMap<String, Object> map) throws Exception {
        return listMapper.getBoardList(map);
    }

    @Override
    public int getBoardListCnt(HashMap<String, Object> map) throws Exception {
        return listMapper.getBoardListCnt(map);
    }



}
