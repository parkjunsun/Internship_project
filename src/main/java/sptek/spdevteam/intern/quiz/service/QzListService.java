package sptek.spdevteam.intern.quiz.service;

import org.springframework.data.relational.core.sql.In;
import sptek.spdevteam.intern.quiz.domain.DspYnDto;
import sptek.spdevteam.intern.quiz.domain.QuizDto;

import java.util.HashMap;
import java.util.List;

public interface QzListService {

    List<QuizDto> getExcelList(HashMap<String, Object> map);

    List<QuizDto> getBoardList(HashMap<String, Object> map);

    Integer getListCnt(HashMap<String, Object> map);

    void updateDspYn(HashMap<String, Object> map);

}
