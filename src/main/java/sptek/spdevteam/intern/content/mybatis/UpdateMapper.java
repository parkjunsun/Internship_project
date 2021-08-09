package sptek.spdevteam.intern.content.mybatis;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.ContentDet;
import sptek.spdevteam.intern.content.domain.Image;

import java.util.List;

@Repository
public interface UpdateMapper {

    Content getContent(int ctnSeq);

    List<Image> getImages(@Param("imgGrpId")String imgGrpId, @Param("useYn") String useYn);

    String getSrcName(String srcCd);

    void updateContent(Content content);

    void updateImage(Image image);

    void updateContentDet(ContentDet contentDet);

    Image getImage(Integer imgSeq);

    ContentDet getCtnDet(Integer ctnSeq);
}
