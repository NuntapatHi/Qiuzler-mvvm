//
//  ViewController.swift
//  Qiuzler-mvvm
//
//  Created by Nuntapat Hirunnattee on 17/9/2565 BE.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFouthButton: UIButton!
    
    let viewModel = QuizViewModel()
    var question: Question?{
        didSet{
            setupQuestion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.facthQuizs { question in
            self.question = question
        }
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        guard let answer = sender.currentTitle else { return }
        viewModel.checkAnswer(answer) {
            self.setupQuestion()
        }
    }
    
    private func setupQuestion(){
        viewModel.getQuestion { question, choices in
            guard let question = question, var choices = choices else {
                return
            }
            print("Question is \(question)")
            print("Choice is \(choices)")
            choices.shuffle()
            DispatchQueue.main.async {
                self.questionLabel.text = question
                self.answerOneButton.setTitle(choices[0], for: .normal)
                self.answerTwoButton.setTitle(choices[1], for: .normal)
                self.answerThreeButton.setTitle(choices[2], for: .normal)
                self.answerFouthButton.setTitle(choices[3], for: .normal)
            }
        }
    }
}

