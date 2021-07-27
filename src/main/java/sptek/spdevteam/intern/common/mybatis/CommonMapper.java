package sptek.spdevteam.intern.common.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.SrcDto;

import java.util.List;

@Repository
public interface CommonMapper {
    List<SrcDto> getSrcList();
}
