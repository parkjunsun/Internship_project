package sptek.spdevteam.intern.temp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.common.LogUtil;
import sptek.spdevteam.intern.temp.domain.TempDomain;
import sptek.spdevteam.intern.temp.mybatis.TempMapper;
import sptek.spdevteam.intern.temp.service.TempService;

import java.util.HashMap;
import java.util.Map;

@Service
public class TempServiceImpl implements TempService {

    private LogUtil log = new LogUtil(TempServiceImpl.class);

    /*@Autowired
    TempMapper tempMapper;*/

    @Override
    public TempDomain testMethod(TempDomain tempDomain) throws Exception {
        log.service("TempService","testMethod()");
        Map map = new HashMap();
        map.put("key1","value1");
        map.put("key2","value2");
        tempDomain.setMap(map);

//        tempDomain.setList(tempMapper.getTemplist());

        tempDomain.setS("string1");

        return tempDomain;
    }
}
