//
//  ViewController.swift
//  Quiz
//
//  Created by Виктория Бадисова on 22.05.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
//        updateOffScreenLabel()
        
        nextQuestionLabelCenterXConstraint.isActive = false
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        layoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nextQuestionLabel.centerXAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        currentQuestionLabel.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive
            = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    
    //MARK: - Actions

    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    //MARK: - Animation

    func animateLabelTransitions() {
        view.layoutIfNeeded()
//        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += view.frame.width
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [.curveLinear],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        self.view.layoutIfNeeded()
        },
                       completion: {(_) in
//                        swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
//                        swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
//                        self.updateOffScreenLabel()
                        swap(&self.currentQuestionLabel.text, &self.nextQuestionLabel.text)
                        self.currentQuestionLabel.alpha = 1
                        self.currentQuestionLabelCenterXConstraint.constant = 0
                        self.view.layoutIfNeeded()
                        self.nextQuestionLabel.alpha = 0
        })
    }
    
    //MARK: - Update UI
    
    func updateOffScreenLabel() {
        nextQuestionLabelCenterXConstraint.constant = -view.frame.width
    }
}

