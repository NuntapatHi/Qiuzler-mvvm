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
    var finalScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.facthQuizs { [weak self] question in
            self?.question = question
        }
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        guard let answer = sender.currentTitle else { return }
        viewModel.checkAnswer(answer) {
            self.setupQuestion()
        }
    }
    
    private func setupQuestion(){
        viewModel.getQuestion { [weak self] question, choices in
            guard let question = question, var choices = choices else {
                return
            }
            print("Question is \(question)")
            print("Choice is \(choices)")
            choices.shuffle()
            DispatchQueue.main.async {
                self?.questionLabel.text = question
                self?.answerOneButton.setTitle(choices[0], for: .normal)
                self?.answerTwoButton.setTitle(choices[1], for: .normal)
                self?.answerThreeButton.setTitle(choices[2], for: .normal)
                self?.answerFouthButton.setTitle(choices[3], for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShowScore"{
            guard let destinationVC = segue.destination as? ShowScoreViewController, let score = finalScore else { return }
            destinationVC.score = score
        }
    }
}

extension QuizViewController: QuizViewModelDelegate{
    func showScore(_ quizViewModel: QuizViewModel, _ score: Int) {
        finalScore = score
        self.performSegue(withIdentifier: "goToShowScore", sender: self)
    }
}
