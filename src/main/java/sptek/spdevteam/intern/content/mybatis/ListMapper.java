package sptek.spdevteam.intern.content.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.ContentExcel;
import sptek.spdevteam.intern.content.domain.ListDomain;

import java.util.HashMap;
import java.util.List;

@Repository
public interface ListMapper {

    List<ContentExcel> getList(ContentExcel contentExcel);
    List<ContentExcel> getBoardList(HashMap<String, Object> map);
    int getBoardListCnt(HashMap<String, Object> map );
    void updateDspYn(HashMap<String, Object> map);

}
