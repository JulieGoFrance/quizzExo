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

 //   let initialTranslationTransform : CGAffineTransform
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
        switch questionView.style {
        case .correct : game.answerCurrentQuestion(with: true)
        case .incorrect : game.answerCurrentQuestion(with: false)
        case .standard :
            break 
        }
        scoreLabel.text = " \(game.score) / 10"
        
     
        
        let screenWidth = UIScreen.main.bounds.width
        
        var translationTransform : CGAffineTransform
        if questionView.style == .correct {
            translationTransform = CGAffineTransform(translationX: screenWidth + screenWidth/10, y: 0)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth + (-screenWidth/10), y: 0)
        }
        
        //CGAffineTransform(translationX: translation.x, y: translation.y)
        
        UIView.animate(withDuration: 0.4, animations : {
            self.questionView.transform = translationTransform
        }) {(success) in
            if success {
                self.showQuestionView()
            }
        }
       
        
    }
    
    
    private func showQuestionView(){
        
        questionView.transform = .identity
        questionView.style = .standard
        switch game.state {
            case .ongoing :  questionView.title = game.currentQuestion.title
            case .over : questionView.title = "game over"
            questionView.transform = .identity
        }
        
    }
}

