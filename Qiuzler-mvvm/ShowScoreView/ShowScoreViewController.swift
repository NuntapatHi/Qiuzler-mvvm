//
//  ShowScoreViewController.swift
//  Qiuzler-mvvm
//
//  Created by Nuntapat Hirunnattee on 19/9/2565 BE.
//

import UIKit

class ShowScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScore()
    }
    
    @IBAction func newQuizPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setScore(){
        guard let score = score else {
            scoreLabel.text = "Score not found."
            return
        }
        scoreLabel.text = "\(score) / 10"
    }
}
