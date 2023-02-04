//
//  Game.swift
//  Quizz
//
//  Created by User on 25/01/2023.
//

import Foundation

class Game {
    var score = 0
    

    

       private var questions = [Question]()
       private var currentIndex = 0

       var state: State = .ongoing

       enum State {
           case ongoing, over
       }

       var currentQuestion: Question {
           
           if questions.indices.contains(currentIndex){
               return questions[currentIndex]
               
           } else {
               currentIndex = 0
               return questions[currentIndex]
           }
          
       }

       func refresh() {
           score = 0
           currentIndex = 0
           state = .over
           
           
           QuestionManager.shared.get { (questions) in
               self.questions = questions
               self.state = .ongoing
               let name = Notification.Name(rawValue: "QuestionsLoaded")
               let notification = Notification(name: name)
               NotificationCenter.default.post(notification)
           }
       }

       func answerCurrentQuestion(with answer: Bool) {
           if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
               score += 1
           }
           goToNextQuestion()
       }

       private func goToNextQuestion() {
           if currentIndex < questions.count - 1 && state == .ongoing {
               currentIndex += 1
           } else {
               finishGame()
           }
       }

       private func finishGame() {
           state = .over
       }
}
