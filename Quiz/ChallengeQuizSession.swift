//
//  ChallengeQuizSession.swift
//  Quiz
//
//  Created by Henry Nicolas on 03.04.20.
//  Copyright © 2020 Pascal Hurni. All rights reserved.
//

import Foundation
class ChallengeQuizSession : QuizSession {
    var _currentQuestionCount: Int
    
    init(questionRepository: QuestionRepository) {
        _currentQuestionCount = 0
        super.init(questionRepository: questionRepository, totalQuestionCount: 12)
    }
    
    override func nextQuestion() -> Question? {
        _currentQuestionCount += 1
        if _currentQuestionCount > _totalQuestionCount {
            return nil
        }
        
        return super.nextQuestion()
    }
    
    override func checkAnswer(_ answer: String) -> Bool {
        let correct = super.checkAnswer(answer)
        if (correct) {
            _score += 1
        } else {
            _score -= 1
            if (_score <= 0) {
                _currentQuestionCount = 12
            }
        }
        return true
    }
    
}
