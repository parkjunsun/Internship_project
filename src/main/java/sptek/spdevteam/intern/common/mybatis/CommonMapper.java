package sptek.spdevteam.intern.common.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TplDto;

import java.util.List;

@Repository
public interface CommonMapper {
    List<SrcDto> getSrcList();

    List<TplDto> getTplList();
}
