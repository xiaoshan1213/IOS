//
//  Question.swift
//  Quizzler
//
//  Created by Sam Ma on 10/24/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    
    let question : String
    let answer : Bool
    
    init(text: String, correctAnswer: Bool) {
        question = text
        answer = correctAnswer
    }
}
