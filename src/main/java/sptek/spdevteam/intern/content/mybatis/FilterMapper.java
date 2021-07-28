package sptek.spdevteam.intern.content.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.domain.TempType;

import java.util.List;

@Repository
public interface FilterMapper {

    List<TempType> getTempList();

}
