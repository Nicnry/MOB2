//
//  JourneymanQuizSession
//  Quiz
//
//  Created by Pascal Hurni on 14.02.17.
//  Copyright © 2017 Pascal Hurni. All rights reserved.
//

import Foundation

class JourneymanQuizSession : QuizSession {
    var _currentQuestionCount: Int
    
    override init(questionRepository: QuestionRepository, totalQuestionCount: Int = 10) {
        _currentQuestionCount = 0
        super.init(questionRepository: questionRepository, totalQuestionCount: totalQuestionCount)
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
        _score += correct ? 1 : -1
        return correct
    }
    
}
