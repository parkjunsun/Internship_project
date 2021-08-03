package sptek.spdevteam.intern.content.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.domain.SrcDto;

import java.util.HashMap;
import java.util.List;

@Repository
public interface RegisterMapper {

    void ctnSave(Content content);

    void imgSave(Image image);
}
