package sptek.spdevteam.intern.quiz.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.quiz.domain.QuizDto;

import java.util.HashMap;
import java.util.List;

@Repository
public interface QzListMapper {

    List<QuizDto> getList(HashMap<String, String> map);

    List<QuizDto> getBoardList(HashMap<String, Object> map);

    Integer getListCnt(HashMap<String, Object> map);

}
