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
    private var question: Question?{
        didSet{
            setupQuestion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.facthQuizs { [weak self] question in
            self?.question = question
        }
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        guard let answer = sender.currentTitle else { return }
        viewModel.checkAnswer(answer) { [weak self] in
            self?.setupQuestion()
        }
    }
    
    private func setupQuestion(){
        viewModel.getQuestion { [weak self] question, choices in
            guard let question = question, var choices = choices else {
                return
            }
            
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
            guard let destinationVC = segue.destination as? ShowScoreViewController else { return }
            destinationVC.score = viewModel.getScore
        }
    }
}

extension QuizViewController: QuizViewModelDelegate{
    func showScore(_ quizViewModel: QuizViewModel) {
        self.performSegue(withIdentifier: "goToShowScore", sender: self)
    }
}
