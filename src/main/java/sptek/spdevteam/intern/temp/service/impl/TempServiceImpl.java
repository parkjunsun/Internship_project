package sptek.spdevteam.intern.temp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.temp.domain.TempDomain;
import sptek.spdevteam.intern.temp.mybatis.TempMapper;
import sptek.spdevteam.intern.temp.service.TempService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TempServiceImpl implements TempService {

    private LogUtil log = new LogUtil(TempServiceImpl.class);

    @Autowired
    TempMapper tempMapper;

    @Override
    public TempDomain selectMethod(TempDomain tempDomain) throws Exception {
        log.service("TempService","testMethod()");
        Map map = new HashMap();
        map.put("key1","value1");
        map.put("key2","value2");
        tempDomain.setMap(map);

        tempDomain.setFindWord("2021-07");
        List<TempDomain> list =tempMapper.selectTemp(tempDomain);
        tempDomain.setList(list);

        tempDomain.setStringValue1("string1");

        return tempDomain;
    }

    @Override
    public int insertMethod(TempDomain tempDomain) throws Exception {

        tempDomain.setStringValue2("Temp1");
        tempDomain.setStringValue3("Temp2");
        tempDomain.setIntValue1(1);
        tempDomain.setIntValue2(2);
        tempDomain.setIntValue3(3);

        return tempMapper.insertTemp(tempDomain);
    }

    @Override
    public int updateMethod(TempDomain tempDomain) throws Exception {
        tempDomain.setFindWord("2021-07");
        return tempMapper.updateTemp(tempDomain);
    }

    @Override
    public int deleteMethod(TempDomain tempDomain) throws Exception {

        tempDomain.setFindWord("2021-07-29 14:43:38");

        return tempMapper.deleteTemp(tempDomain);
    }
}
