//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAns : Bool = false
    var questionNum : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: UIButton) {
        
        nextQuestion()
        checkAnswer(sender: sender)
    }
    
    
    func updateUI() {
        scoreLabel.text = String(score)
        progressLabel.text = "\(questionNum + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNum + 1)
    }
    

    func nextQuestion() {
        
        if questionNum == 12 {
            jumpToEnd()
            return
        }
        let currentQuestion = allQuestions.list[questionNum]
        questionLabel.text = currentQuestion.question
    }
    
    
    func checkAnswer(sender: UIButton) {
        
        if sender.tag == 1{
            pickedAns = true
        }else{
            pickedAns = false
        }
        if pickedAns == allQuestions.list[questionNum].answer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }
        else{
            ProgressHUD.showError("Wrong!")
        }
        updateUI()
        questionNum += 1

    }
    
    func jumpToEnd() {
        
        let alert = UIAlertController(title: "Congrats", message: "You've finished all, wanna do it again?", preferredStyle: .alert)
        let restartAct = UIAlertAction(title: "restart?", style: .default, handler: { (UIAlertAction) in
            self.startOver()
            })
        alert.addAction(restartAct)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func startOver() {
        questionNum = 0
        score = 0
        updateUI()
        nextQuestion()
    }
    
    @IBAction func restartClicked(_ sender: UIButton) {
        
        
    }
    
    
}
