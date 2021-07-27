package sptek.spdevteam.intern.temp.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.temp.domain.TempDomain;

import java.util.List;

@Repository
public interface TempMapper {

    public List<TempDomain> getTemplist() throws Exception;

}
