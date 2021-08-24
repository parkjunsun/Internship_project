package sptek.spdevteam.intern.quiz.mybatis;

import sptek.spdevteam.intern.quiz.domain.Quiz;
import sptek.spdevteam.intern.quiz.domain.QuizDetail;
import sptek.spdevteam.intern.quiz.domain.QuizOption;
import sptek.spdevteam.intern.quiz.domain.QuizType;

import java.util.HashMap;
import java.util.List;

public interface QuizRegisterMapper {
    List<QuizType> getTypes();

    void quizSave(Quiz quiz);

    void quizDtlSave(QuizDetail quizDetail);

    void quizOptionSave(QuizOption quizOption);

    int getQuizSeq(HashMap<String, String> map);

    int getQuizDtlSeq(HashMap<String, String> map);



}
