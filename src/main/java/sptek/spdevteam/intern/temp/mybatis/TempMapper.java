package sptek.spdevteam.intern.temp.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.temp.domain.TempDomain;

import java.util.List;

@Repository
public interface TempMapper {

    List<TempDomain> selectTemp(TempDomain tempDomain) throws Exception;

    int insertTemp(TempDomain tempDomain) throws Exception;

    int updateTemp(TempDomain tempDomain) throws Exception;

    int deleteTemp(TempDomain tempDomain) throws Exception;
}
