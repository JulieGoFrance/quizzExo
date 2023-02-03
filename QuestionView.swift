//
//  QuestionView.swift
//  Quizz
//
//  Created by User on 27/01/2023.
//

import UIKit

class QuestionView: UIView {
    
    
    
    @IBOutlet private var label : UILabel!
    @IBOutlet private var icon : UIImageView!
    enum Style {
        case correct, incorrect, standard
    }
    var style : Style = .standard {
        didSet {
            setStyle(style)
        }
    }
    var title = ""{
        didSet {
            label.text = title
        }
    }
    
    private func setStyle(_ style : Style){
        switch style {
            case .correct: backgroundColor = UIColor(red: 200/255, green: 236/255, blue: 160/255, alpha: 1)
                icon.image = UIImage(named: "Icon Correct")
                icon.isHidden = false
            case .incorrect : backgroundColor = UIColor(red: 243/255, green: 135/255, blue: 148/255, alpha: 1)
                icon.image = UIImage(named: "Icon Error")
                icon.isHidden = false
        case .standard : backgroundColor = UIColor(red: 56/255, green: 56/255, blue: 201/255, alpha: 0.5)
                icon.isHidden = true
        }
    }

    /*
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
