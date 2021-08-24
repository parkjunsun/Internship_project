package sptek.spdevteam.intern.quiz.mybatis;

import org.springframework.stereotype.Repository;
import sptek.spdevteam.intern.quiz.domain.DspYnDto;
import sptek.spdevteam.intern.quiz.domain.QuizDto;

import java.util.HashMap;
import java.util.List;

@Repository
public interface QzListMapper {

    List<QuizDto> getExcelList(HashMap<String, Object> map);

    List<QuizDto> getBoardList(HashMap<String, Object> map);

    Integer getListCnt(HashMap<String, Object> map);

    void updateDspYn(HashMap<String, Object> map);

}
