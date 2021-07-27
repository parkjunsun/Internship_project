package sptek.spdevteam.intern.content.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.Content;

import java.util.HashMap;
import java.util.List;

@Repository
public interface RegisterMapper {

    void save(Content content);
    List<HashMap<String, String>> getSrcList();
}
