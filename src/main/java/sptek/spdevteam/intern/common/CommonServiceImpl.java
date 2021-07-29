package sptek.spdevteam.intern.common;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.common.mybatis.CommonMapper;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.domain.TplDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommonServiceImpl implements CommonService {

    private final CommonMapper commonMapper;

    @Override
    public List<SrcDto> getSrcList() {
        return commonMapper.getSrcList();
    }

    @Override
    public List<TplDto> getTplList() {
        return commonMapper.getTplList();
    }
}
