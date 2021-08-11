package sptek.spdevteam.intern.quiz.service;

import org.springframework.data.relational.core.sql.In;
import sptek.spdevteam.intern.quiz.domain.QuizDto;

import java.util.HashMap;
import java.util.List;

public interface QzListService {

    List<QuizDto> getList(HashMap<String, String> map);

    Integer getListCnt(HashMap<String, String> map);

}
