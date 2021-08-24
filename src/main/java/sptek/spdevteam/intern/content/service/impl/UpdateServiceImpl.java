package sptek.spdevteam.intern.content.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.ContentDet;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.mybatis.UpdateMapper;
import sptek.spdevteam.intern.content.service.UpdateService;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UpdateServiceImpl implements UpdateService {

    private final UpdateMapper updateMapper;

    @Override
    public Content getContent(int ctnSeq) {
        return updateMapper.getContent(ctnSeq);
    }

    @Override
    public List<Image> getImages(String imgGrpId, String useYn) {
        return updateMapper.getImages(imgGrpId, useYn);
    }

    @Override
    public String getSrcName(String srcCd) {
        return updateMapper.getSrcName(srcCd);
    }

    @Override
    public void updateContent(Content content) {
        updateMapper.updateContent(content);
    }

    @Override
    public void updateImage(Image image) {
        updateMapper.updateImage(image);
    }

    @Override
    public void updateImages(HashMap<String, Object> paramMap) {
        updateMapper.updateImages(paramMap);
    }

    @Override
    public void updateContentDet(ContentDet contentDet) {
        updateMapper.updateContentDet(contentDet);
    }

    @Override
    public Image getImage(Integer imgSeq) {
        return updateMapper.getImage(imgSeq);
    }

    @Override
    public ContentDet getCtnDet(Integer ctnSeq) {
        return updateMapper.getCtnDet(ctnSeq);
    }
}
