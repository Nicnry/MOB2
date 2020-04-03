//
//  NinjaQuizSession.swift
//  Quiz
//
//  Created by Pascal Hurni on 28.02.17.
//  Copyright © 2017 Pascal Hurni. All rights reserved.
//

import Foundation

class NinjaQuizSession : WarriorQuizSession {
    var _currentQuestionTickCount: Int
    let _maxQuestionTickCount = 3
    
    override init(questionRepository: QuestionRepository, totalQuestionCount: Int = 15) {
        _currentQuestionTickCount = 0
        super.init(questionRepository: questionRepository, totalQuestionCount: totalQuestionCount)
    }

    override func nextQuestion() -> Question? {
        if let question = super.nextQuestion() {
            // Reset the question timer count
            _currentQuestionTickCount = 0
            return question
        }
        return nil
    }

    // For time based sessions, call it once per second and pass to the next question if true is returned
    override func tickAndShouldPassToNextQuestion() -> Bool {
        // Let parent handle base scenario
        if super.tickAndShouldPassToNextQuestion() {
            return true
        }
        
        // Now should we go to the next question?
        _currentQuestionTickCount += 1
        return _currentQuestionTickCount >= _maxQuestionTickCount
    }
    
    // For time based sessions, report this to the UI
    override func timeInfo() -> String {
        return "\(_maxQuestionTickCount-_currentQuestionTickCount) / \(super.timeInfo())";
    }

}
