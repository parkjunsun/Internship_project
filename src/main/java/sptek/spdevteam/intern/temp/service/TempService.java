package sptek.spdevteam.intern.temp.service;

import sptek.spdevteam.intern.temp.domain.TempDomain;

public interface TempService {
    TempDomain selectMethod(TempDomain tempDomain) throws Exception;
    int insertMethod(TempDomain tempDomain) throws Exception;
    int updateMethod(TempDomain tempDomain) throws Exception;
    int deleteMethod(TempDomain tempDomain) throws Exception;
}
