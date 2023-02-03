//
//  ViewController.swift
//  Quizz
//
//  Created by User on 25/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: name, object: nil)
        
        startNewGame()
      
    }
    @objc func questionsLoaded(){
        activityCircle.isHidden = true
        newGameButton.isHidden = false
        questionView.title = game.currentQuestion.title
    }
    
    
    @IBOutlet weak var activityCircle: UIActivityIndicatorView!
    

    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionView: QuestionView!
    var game = Game()
    
    @IBAction func didTapNewGameButton(_ sender: Any) {
        startNewGame()
    }
    private func startNewGame(){
        
        activityCircle.isHidden = false
        newGameButton.isHidden = true
        questionView.title = "loading"
        questionView.style = .standard
        scoreLabel.text = "0/10"
        game.refresh()
   }
    
    @IBAction func dragQuestionView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformQuestionViewWith(gesture:sender)
        case .ended, .cancelled :
            answerQuestion()
        default :
            break
        }
    }
    
    private func transformQuestionViewWith (gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: questionView)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        let screenWidth = UIScreen.main.bounds.width
        let translationPercent = translation.x / (screenWidth/2)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        let transform = translationTransform.concatenating(rotationTransform)
        questionView.transform = transform
     
        if translation.x > 0 {
            questionView.style = .correct
            } else {
            questionView.style = .incorrect
            }
        }
    
    private func answerQuestion(){
        
    }
    
}

