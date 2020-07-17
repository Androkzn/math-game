//
//  MultiplicationQuestions.swift
//  MathGame
//
//  Created by Andrei Tekhtelev on 2020-04-27.
//  Copyright © 2020 Sam Meech-Ward. All rights reserved.
//


import Foundation


struct MultiplicationQuestion {
    
    private let num1: Int
    private let num2: Int
    let answer: Int
    let question: String
    
    enum Questions {
        case one
        case two
        case three
        
        static let options: [Questions] = [.one, .two, .three]
        
        static func rand() -> Questions {
          return options.randomElement()!
        }
    }
    
    init() {
        num1 = Int.random(in: 1...10)
        num2 = Int.random(in: 1...10)
        switch  Questions.rand() {
            case .one:
                 answer = num1 * num2
                 question = "What is \(num1) * \(num2)?"
            case .two:
                 answer = num1 * num2 * 2
                 question = "What is \(num1) * \(num2) * 2 ?"
            case .three:
                answer = num1 * num2 * 3
                question = "What is \(num1) * \(num2) * 3 ?"
        }
    }
}

extension MultiplicationQuestion: MathQuestion {
  func checkAnswer(_ answer: Int) -> Bool {
    return self.answer == answer
  }
  var text: String {
    get { question }
  }
}
