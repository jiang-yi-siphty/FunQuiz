//
//  Questions.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

struct Questions: Codable {
    let domain: String
    var questions: [Question]
    var score: Int?
} 

struct Question: Codable {
    let question: String
    let answer: Bool
    var correct: Bool?
}
