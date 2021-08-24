package sptek.spdevteam.intern.content.service;


import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.ContentDet;
import sptek.spdevteam.intern.content.domain.Image;

import java.util.HashMap;
import java.util.List;

public interface UpdateService {

    Content getContent(int ctnSeq);

    List<Image> getImages(String imgGrpId, String useYn);

    String getSrcName(String srcCd);

    void updateContent(Content content);

    void updateImage(Image image);

    void updateImages(HashMap<String, Object> paramMap);

    void updateContentDet(ContentDet contentDet);

    Image getImage(Integer imgSeq);

    ContentDet getCtnDet(Integer ctnSeq);


}
