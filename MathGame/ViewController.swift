//
//  ViewController.swift
//  MathGame
//
//  Created by Andrei Tekhtelev on 2020-04-27.
//  Copyright © 2020 Sam Meech-Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //Labels
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var feedbackLabel: UILabel!
  //Game buttons
  @IBOutlet weak var checkAnswerButton: UIButton!
  @IBOutlet weak var additionButton: UIButton!
  @IBOutlet weak var multiplicationButton: UIButton!
  //Numeric buttons
  @IBOutlet var numericButtonsLabels: [UIButton]!
  //Delete buttons
  @IBOutlet var deleteButtons: [UIButton]!
    
  var yourAnswer = ""
  var question: MathQuestion?
  var timer: Timer? = nil
  var counter = 20
  var redCounter = 10
  override func viewDidLoad() {
    super.viewDidLoad()
    initialButtonsStyle()
  }
    

    
    @IBAction func numericButton(_ sender: UIButton) {
        yourAnswer += (sender.titleLabel?.text!)!
        displayAnswer(answer: yourAnswer)
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sender.layer.borderColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    
    @IBAction func numericButtonTouchDown(_ sender:  UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 3
        sender.layer.borderColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
    }
    
    
    @IBAction func deleteButtonsTouchDown(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 3
        sender.layer.borderColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    

    
    @IBAction func deleteButton(_ sender: UIButton) {
        yourAnswer = "\(yourAnswer.dropLast(1))"
        displayAnswer(answer: yourAnswer)
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func deleteAllButton(_ sender: UIButton) {
        yourAnswer = ""
        displayAnswer(answer: yourAnswer)
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func additionGameButton(_ sender: UIButton) {
        counter  = 20
        redCounter = 10
        timerOff()
        yourAnswer = ""
        displayQuestion(gameType: AdditionQuestion())
        startGameButtonsStyle()
        startTimer()
        inactiveCheckButtonStyle()
    }
    
    @IBAction func multiplicationButton(_ sender: UIButton) {
        counter  = 30
        redCounter = 15
        timerOff()
        yourAnswer = ""
        displayQuestion(gameType: MultiplicationQuestion())
        startGameButtonsStyle()
        startTimer()
        inactiveCheckButtonStyle()
    }
    
    @IBAction func checkAnswerButton(_ sender: UIButton) {
        checkAnswer(answer: yourAnswer)
    }
    
    func displayQuestion (gameType: MathQuestion?) {
        question = gameType
        questionLabel.text  = question?.text
        questionLabel.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        questionLabel.layer.cornerRadius = 10
        questionLabel.layer.masksToBounds = true
        answerLabel.text = "Do you have a guess?"
        answerLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        feedbackLabel.text = "Check your answer to see feedback"
        feedbackLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
    }
    
    func checkAnswer (answer: String) {
        if question!.check(answer: Int(yourAnswer)!) {
            let goodComments: [String] = ["Well done! \(yourAnswer) is correct answer 😺", "Nice job! Keep it up! 🤗 ", "Wow! It gonna be a world record! 🏆🏆🏆"]
            feedbackLabel.text =  goodComments.randomElement()
            feedbackLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            yourAnswer = ""
            initialButtonsStyle()
            timerOff()
            timerLabel.text = " "
        } else {
            let badComments: [String] = ["Your answer is wrong 😿. Try again!", "Take a rest and try one more time", "It was a bad idea, try harder!"]
            feedbackLabel.text = badComments.randomElement()
            feedbackLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    func displayAnswer (answer: String){
        if answer == "" {
           answerLabel.text = "Enter your answer"
           answerLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
           initialButtonsStyle()
           feedbackLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           feedbackLabel.text = "No answer no feedback"
           startGameButtonsStyle()
        } else {
            answerLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            answerLabel.text = answer
            activeCheckButtonStyle()
            feedbackLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            feedbackLabel.text = "Check your answer to see feedback"
        }
    }
    
    func startTimer () {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if self.counter >= 0 {
                        self.stopBlinking(label: self.timerLabel)
                        self.timerLabel.text = "\(self.counter) sec left"
                        self.timerLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        if self.counter <= self.redCounter {
                                      self.timerLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                                      self.startBlinking(label: self.timerLabel)
                                  }
                         } else {
                             timer.invalidate()
                             self.timerLabel.text = " "
                             self.answerLabel.text = "Oops!"
                             self.answerLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                             self.feedbackLabel.text = "Time is over. Try again!"
                             self.feedbackLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                             
                            self.numericButtonsLabels.forEach { button in
                                 button.isEnabled = false
                                 button.layer.cornerRadius = 10
                                 button.layer.borderWidth = 3
                                 button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                             }
                            self.inactiveCheckButtonStyle ()
                         }
                    self.counter -= 1
                     }
    }
    
    func startBlinking(label: UILabel) {
        UILabel.animate(withDuration: 0.5, delay:0.2, options: [.repeat, .autoreverse], animations: {
            label.alpha = 0.1
            }, completion: nil)
    }
    func stopBlinking(label: UILabel) {
        label.alpha = 1
        label.layer.removeAllAnimations()
    }

    func timerOff () {
        timer?.invalidate()
        timer = nil
    }
    
    func initialButtonsStyle () {
        questionLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        questionLabel.layer.cornerRadius = 10
        questionLabel.layer.borderWidth = 3
        questionLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        inactiveCheckButtonStyle()
        deleteButtons.forEach { button in
        button.isEnabled = false
        }
        numericButtonsLabels.forEach { button in
           button.isEnabled = false
           button.layer.cornerRadius = 10
           button.layer.borderWidth = 3
           button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        deleteButtons.forEach { button in
           button.isEnabled = false
           button.layer.cornerRadius = 10
           button.layer.borderWidth = 3
           button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        additionButton.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        multiplicationButton.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        multiplicationButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        additionButton.layer.cornerRadius = 10
        multiplicationButton.layer.cornerRadius = 10
        additionButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        multiplicationButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        additionButton.layer.masksToBounds = true
        multiplicationButton.layer.masksToBounds = true
        
    }
    
    func startGameButtonsStyle () {
        questionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        questionLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        numericButtonsLabels.forEach { button in
            button.isEnabled = true
            button.layer.borderColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        deleteButtons.forEach { button in
            button.isEnabled = false
            button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    
    }

    func activeCheckButtonStyle () {
        checkAnswerButton.isEnabled = true
        deleteButtons.forEach { button in
         button.isEnabled = true
         button.layer.borderColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
         }
        checkAnswerButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        checkAnswerButton.layer.cornerRadius = 10
        checkAnswerButton.layer.masksToBounds = true
    }
    
    func inactiveCheckButtonStyle () {
        checkAnswerButton.isEnabled = false
        deleteButtons.forEach { button in
         button.isEnabled = false
         button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         }
        checkAnswerButton.layer.cornerRadius = 10
        checkAnswerButton.layer.borderWidth = 3
        checkAnswerButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        checkAnswerButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    }
    
    
}

