package sptek.spdevteam.intern.common;

import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TplDto;

import java.util.List;

public interface CommonService {

    List<SrcDto> getSrcList();

    List<TplDto> getTplList();
}
