package sptek.spdevteam.intern.content.service;


import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.Image;

import java.util.List;

public interface UpdateService {

    Content getContent(int ctnSeq);

    List<Image> getImages(String imgGrpId);

    String getSrcName(String srcCd);

    void updateContent(Content content);

}
