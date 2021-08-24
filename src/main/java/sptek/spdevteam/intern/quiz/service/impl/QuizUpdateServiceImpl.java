package sptek.spdevteam.intern.quiz.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.quiz.domain.*;
import sptek.spdevteam.intern.quiz.mybatis.QuizUpdateMapper;
import sptek.spdevteam.intern.quiz.service.QuizUpdateService;

import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@Service
public class QuizUpdateServiceImpl implements QuizUpdateService {
    private final QuizUpdateMapper quizUpdateMapper;

    @Override
    public QuizDto getQuiz(int quizSeq) {
        return quizUpdateMapper.getQuiz(quizSeq);
    }

    @Override
    public List<QuizDtl> getQuizDtl(int quizSeq) {
        return quizUpdateMapper.getQuizDtl(quizSeq);
    }

    @Override
    public List<PtcAns> getPtcAns(int qzDetSeq) {
        return quizUpdateMapper.getPtcAns(qzDetSeq);
    }

    @Override
    public List<Image> getImages(String imgGrpId, String useYn) {
        return quizUpdateMapper.getImages(imgGrpId, useYn);
    }

    @Override
    public List<QuizOption> getOpt(int qzDetSeq) {
        return quizUpdateMapper.getOpt(qzDetSeq);
    }

    @Override
    public int getTotalPtc(int qzSeq) {
        return quizUpdateMapper.getTotalPtc(qzSeq);
    }

    @Override
    public void disableImg(int imgSeq) {
        quizUpdateMapper.disableImg(imgSeq);
    }

    @Override
    public void updateQzImgGrpId(HashMap<String, String> hashMap) {
        quizUpdateMapper.updateQzImgGrpId(hashMap);
    }

    @Override
    public void updateQuiz(HashMap<String, String> hashmap) {
        quizUpdateMapper.updateQuiz(hashmap);
    }

    @Override
    public void updateQuizDtl(QuizDtl quizDtl) {
        quizUpdateMapper.updateQuizDtl(quizDtl);
    }

    @Override
    public void updateQuizOption(QuizOption quizOption) {
        quizUpdateMapper.updateQuizOption(quizOption);
    }

    @Override
    public void updateImg(Image image) {
        quizUpdateMapper.updateImg(image);
    }


}
