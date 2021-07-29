package sptek.spdevteam.intern.content.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.content.domain.ContentExcel;
import sptek.spdevteam.intern.content.domain.ListDomain;

import java.util.List;

@Repository
public interface ListMapper {

    List<ContentExcel> getList();

}
