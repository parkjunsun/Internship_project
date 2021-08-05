package sptek.spdevteam.intern.content.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.Image;

import java.util.List;

@Repository
public interface UpdateMapper {

    Content getContent(int ctnSeq);

    List<Image> getImages(String imgGrpId);

    String getSrcName(String srcCd);

    void updateContent(Content content);
}
