//
//  MathGame.swift
//  MathGame
//
//  Created by Andrei Tekhtelev on 2020-04-27.
//  Copyright © 2020 Sam Meech-Ward. All rights reserved.
//

import Foundation

protocol MathQuestion {
  var text: String { get }
  var answer: Int { get }
}

extension MathQuestion {
  func check(answer: Int) -> Bool {
    return answer == self.answer
  }
}

