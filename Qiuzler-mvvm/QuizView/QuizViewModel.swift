//
//  QuizViewModel.swift
//  Qiuzler-mvvm
//
//  Created by Nuntapat Hirunnattee on 17/9/2565 BE.
//

import Foundation

class QuizViewModel{
    
    var questions: Question?
    var answerNumber = 0
    var score = 0
    
    let url = "https://opentdb.com/api.php?amount=10&type=multiple"
    
    func facthQuizs(_ value: @escaping (Question) -> Void){
        NetworkService.shared.request(with: url, type: Question.self) { data, error in
            guard let result = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            self.questions = result
            value(result)
        }
    }
    
    func getQuestion(_ completion: @escaping (String?, [String]?) -> Void){
        
        print("AnswerNumber : \(answerNumber)")
        print("Score: \(score)")
        
        guard let question = questions?.results[answerNumber].question, let incorrects = questions?.results[answerNumber].incorrect_answers, let correct = questions?.results[answerNumber].correct_answer else {
            completion("No question", ["-", "-", "-", "-"])
            return
        }
        
        //make choiceList from correct and incoreect answer
        var answerChoices = incorrects
        answerChoices.append(correct)
        
        completion(question, answerChoices)
    }
    
    func checkAnswer(_ answer: String, _ isCorrect: @escaping () -> Void){
        guard let correctAnswer = questions?.results[answerNumber].correct_answer else { return }
        guard let numberOfQuestion = questions?.results.count else { return }
        if answerNumber < numberOfQuestion - 1{
            if correctAnswer == answer{
                score += 1
                print("Correct!")
            } else {
                print("Incorrect.")
            }
            answerNumber += 1
        } else {
            answerNumber = 0
        }
    }
}
