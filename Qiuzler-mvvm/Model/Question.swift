//
//  QuestionModel.swift
//  Qiuzler-mvvm
//
//  Created by Nuntapat Hirunnattee on 17/9/2565 BE.
//

import Foundation


struct Question: Codable{
    let results: [QuestionDetail]
}

struct QuestionDetail: Codable{
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}


