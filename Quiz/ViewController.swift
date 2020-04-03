//
//  ViewController.swift
//  Quiz
//
//  Created by Pascal Hurni on 17.02.16.
//  Copyright (c) 2016 Pascal Hurni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var hintButton: UIButton!
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var timeLabel: UILabel!
    
    var session : QuizSession!
    var sessionCompletion: (() -> Void)!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sessionTick), userInfo: nil, repeats: true)
        
        nextOne()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func sessionTick() {
        if (session.tickAndShouldPassToNextQuestion()) {
            nextOne()
        }
        timeLabel.text = session.timeInfo()
    }

    @IBAction func answerClick(_ sender: UIButton) {
        // Tell the session the chosen answer
        if session.checkAnswer(sender.currentTitle!) {
            // Pass to the next question
            nextOne()
        }
    }

    func nextOne() {
        hintLabel.isHidden = true
        hintButton.isHidden = false

        // get the next question from the session
        if let question = session.nextQuestion() {
            // Set the captions
            questionLabel.text = question.caption
            hintLabel.text = question.hint
            answerButton1.setTitle(question.answers[0], for: UIControl.State())
            answerButton2.setTitle(question.answers[1], for: UIControl.State())
            answerButton3.setTitle(question.answers[2], for: UIControl.State())
        }
        else {
            // No more question, game finished
            dismiss(animated: true, completion: sessionCompletion)
        }
    }
    
    @IBAction func hintClick(_ sender: UIButton) {
        hintLabel.isHidden = false
        hintButton.isHidden = true
    }
    
}

