package sptek.spdevteam.intern.quiz.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.quiz.domain.Quiz;
import sptek.spdevteam.intern.quiz.domain.QuizDetail;
import sptek.spdevteam.intern.quiz.domain.QuizOption;
import sptek.spdevteam.intern.quiz.domain.QuizType;
import sptek.spdevteam.intern.quiz.mybatis.QuizRegisterMapper;
import sptek.spdevteam.intern.quiz.service.QuizRegisterService;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class QuizRegisterServiceImpl implements QuizRegisterService {

    private final QuizRegisterMapper mapper;

    @Override
    public List<QuizType> getTypes() {
        return mapper.getTypes();
    }

    @Override
    public void quizSave(Quiz quiz) {
        mapper.quizSave(quiz);
    }

    @Override
    public void quizDtlSave(QuizDetail quizDetail) {
        mapper.quizDtlSave(quizDetail);
    }

    @Override
    public void quizOptionSave(QuizOption quizOption) {
        mapper.quizOptionSave(quizOption);
    }

    @Override
    public int getQuizSeq(HashMap<String, String> map) {
        return mapper.getQuizSeq(map);
    }

    @Override
    public int getQuizDtlSeq(HashMap<String, String> map) {
        return mapper.getQuizDtlSeq(map);

    }
}
