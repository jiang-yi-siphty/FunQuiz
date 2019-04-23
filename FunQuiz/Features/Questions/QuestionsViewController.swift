//
//  QuestionsViewController.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation
import UIKit

class QuestionsViewController: UIViewController {
    
    lazy var viewModel: QuestionsViewModel = {
        return QuestionsViewModel()
    }()

    
    private var questionBody = UITextView()
    private var trueAnswerButton = UIButton()
    private var falseAnswerButton = UIButton()
    private var answerButtonsStackView = UIStackView()
    private var resultMessage = UILabel()
    private var nextQuestionButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", 
                                                            style: .plain, 
                                                            target: self, 
                                                            action: #selector(doneButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc private func doneButtonTapped() {
        
    }
    
}
