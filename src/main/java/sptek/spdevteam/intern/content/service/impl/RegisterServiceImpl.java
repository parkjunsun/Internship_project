package sptek.spdevteam.intern.content.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.ContentDet;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.domain.SrcDto;
import sptek.spdevteam.intern.content.mybatis.RegisterMapper;
import sptek.spdevteam.intern.content.service.RegisterService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RegisterServiceImpl implements RegisterService {

    private final RegisterMapper registerMapper;

    @Override
    public void ctnSave(Content content) {
        registerMapper.ctnSave(content);
    }

    @Override
    public void imgSave(Image image) {
        registerMapper.imgSave(image);
    }

    @Override
    public void ctnDetSave(ContentDet contentDet) {
        registerMapper.ctnDetSave(contentDet);
    }

    @Override
    public int getCtnSeq(String imgGrpId) {
        return registerMapper.getCtnSeq(imgGrpId);
    }
}
