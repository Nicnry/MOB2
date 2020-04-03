//
//  WarriorQuizSession.swift
//  Quiz
//
//  Created by Pascal Hurni on 28.02.17.
//  Copyright © 2017 Pascal Hurni. All rights reserved.
//

import Foundation

class WarriorQuizSession : JourneymanQuizSession {
    var _currentTickCount: Int
    let _maxTickCount = 30
    
    override init(questionRepository: QuestionRepository, totalQuestionCount: Int = 15) {
        _currentTickCount = 0
        super.init(questionRepository: questionRepository, totalQuestionCount: totalQuestionCount)
    }

    override func nextQuestion() -> Question? {
        if _currentTickCount >= _maxTickCount {
            return nil
        }
        
        return super.nextQuestion()
    }

    // For time based sessions, call it once per second and pass to the next question if true is returned
    override func tickAndShouldPassToNextQuestion() -> Bool {
        switch _currentTickCount {
        case 0..<_maxTickCount:
            _currentTickCount += 1
            return false
        case _maxTickCount:
            return true
        default:
            return false
        }
    }
    
    // For time based sessions, report this to the UI
    override func timeInfo() -> String {
        return "\(_maxTickCount-_currentTickCount)";
    }

}
