package sptek.spdevteam.intern.quiz.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.quiz.domain.QuizDto;
import sptek.spdevteam.intern.quiz.mybatis.QzListMapper;
import sptek.spdevteam.intern.quiz.service.QzListService;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class QzListServiceImpl implements QzListService {

    private final QzListMapper qzListMapper;

    @Override
    public List<QuizDto> getList(HashMap<String, String> map) {
        return qzListMapper.getList(map);
    }

    @Override
    public Integer getListCnt(HashMap<String, String> map) {
        return qzListMapper.getListCnt(map);
    }
}
