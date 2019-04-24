//
//  QuestionsViewController.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    
    lazy var viewModel: QuestionsViewModel = {
        return QuestionsViewModel()
    }()

    
    private var questionBody = UILabel()
    private var trueAnswerButton = UIButton()
    private var falseAnswerButton = UIButton()
    private var answerButtonsStackView = UIStackView()
    private var resultMessage = UILabel()
    private var nextQuestionButton = UIButton()
    private var questionStackView = UIStackView()
    private var resultStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", 
                                                            style: .plain, 
                                                            target: self, 
                                                            action: #selector(doneButtonTapped))
        navigationItem.setHidesBackButton(true, animated:true)
        prepareViewController()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureQuestion()
    }
    
    @objc private func doneButtonTapped() {
        viewModel.finishedQuiz()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func trueButtonTapped() {
        viewModel.answerValue = true
        trueAnswerButton.isEnabled.toggle()
        falseAnswerButton.isEnabled.toggle()
    }
    
    @objc private func falseButtonTapped() {
        viewModel.answerValue = false
        trueAnswerButton.isEnabled.toggle()
        falseAnswerButton.isEnabled.toggle()
    }
    
    @objc private func nextButtonTapped() {
        viewModel.nextQuestion()
        trueAnswerButton.isEnabled = true
        falseAnswerButton.isEnabled = true
    }
    
    private func prepareViewController() {
        view.backgroundColor = .white
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        questionStackView.translatesAutoresizingMaskIntoConstraints = false
        prepareQuestionSection()
        prepareResultSection()
    }
    
    private func prepareQuestionSection() {
        questionBody.font = .systemFont(ofSize: Constants.titleFontSize)
        questionBody.textAlignment = .left
        questionBody.numberOfLines = 0
        view.addSubview(questionBody)
        prepareAnswerButtonsStackView()
        questionBody.translatesAutoresizingMaskIntoConstraints = false
        questionBody.safeAreaLayoutGuide.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, 
                        constant: Constants.topSpace).isActive = true
        questionBody.leadingAnchor
            .constraint(equalTo: view.leadingAnchor, 
                        constant: Constants.leadingSpace).isActive = true
        questionBody.trailingAnchor
            .constraint(equalTo: view.trailingAnchor, 
                        constant: Constants.trailingSpace).isActive = true
        prepareAnswerButtonsStackView()
    }
    
    private func prepareButtonView(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal) 
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.bodyFontSize)
        answerButtonsStackView.addArrangedSubview(button)
    }
    
    private func prepareAnswerButtonsStackView() {
        answerButtonsStackView.axis = .horizontal
        answerButtonsStackView.distribution = .fillEqually
        answerButtonsStackView.alignment = .center
        answerButtonsStackView.spacing = Constants.stackViewSpace
        view.addSubview(answerButtonsStackView)
        answerButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        answerButtonsStackView.topAnchor
            .constraint(equalTo: questionBody.bottomAnchor, 
                        constant: Constants.stackViewSpace).isActive = true
        answerButtonsStackView.leadingAnchor
            .constraint(equalTo: view.leadingAnchor, 
                        constant: Constants.leadingSpace).isActive = true
        answerButtonsStackView.trailingAnchor
            .constraint(equalTo: view.trailingAnchor, 
                        constant: Constants.trailingSpace).isActive = true
        answerButtonsStackView.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        
        prepareButtonView(trueAnswerButton, title: .trueButtonTitle)
        trueAnswerButton.addTarget(self, action: #selector(trueButtonTapped), for: .touchUpInside)
        prepareButtonView(falseAnswerButton, title: .falseButtonTitle)
        falseAnswerButton.addTarget(self, action: #selector(falseButtonTapped), for: .touchUpInside)
    }
    
    private func prepareResultSection() {
        nextQuestionButton.titleLabel?.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        nextQuestionButton.setTitle(.nextButtonTitle, for: .normal)
        nextQuestionButton.setTitleColor(.blue, for: .normal) 
        view.addSubview(nextQuestionButton)
        nextQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        nextQuestionButton.safeAreaLayoutGuide.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, 
                        constant: Constants.bottomSpace).isActive = true
        nextQuestionButton.leadingAnchor
            .constraint(equalTo: view.leadingAnchor, 
                        constant: Constants.leadingSpace).isActive = true
        nextQuestionButton.trailingAnchor
            .constraint(equalTo: view.trailingAnchor, 
                        constant: Constants.trailingSpace).isActive = true
        nextQuestionButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        resultMessage.text = "your anwser is false"
        resultMessage.font = .systemFont(ofSize: Constants.titleFontSize)
        resultMessage.textAlignment = .center
        resultMessage.numberOfLines = 0
        view.addSubview(resultMessage)
        resultMessage.translatesAutoresizingMaskIntoConstraints = false
        resultMessage.bottomAnchor
            .constraint(equalTo: nextQuestionButton.topAnchor, 
                        constant: Constants.aboveSpace).isActive = true
        resultMessage.leadingAnchor
            .constraint(equalTo: view.leadingAnchor, 
                        constant: Constants.leadingSpace).isActive = true
        resultMessage.trailingAnchor
            .constraint(equalTo: view.trailingAnchor, 
                        constant: Constants.trailingSpace).isActive = true
    }
    
    private func configureQuestion() {
        title = viewModel.title 
        questionBody.text = viewModel.questionText
        resultMessage.isHidden = true
        nextQuestionButton.isHidden = viewModel.hasNextQuestion()
    }
    
    private func configureResultMessage() {
        resultMessage.isHidden = false
        resultMessage.text = viewModel.resultText
    }
    
    private func configureViewModel() {
        
        viewModel.anwserResultIsReady = { () in 
            DispatchQueue.main.async { [weak self] in
                self?.configureResultMessage()
            }
        }
            
        viewModel.nextQuestionIsReady = { () in 
            DispatchQueue.main.async { [weak self] in
                self?.configureQuestion()
            }
        }
        
        viewModel.hasAlertMessage  = { (message) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(message)
            }
        }
    }
    
    // MARK: - private func
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: .alertTitleText, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: .alertButtonText, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


fileprivate extension String {
    
    static let alertTitleText = "Alert"
    static let alertButtonText = "OK"
    static let trueButtonTitle = "True"
    static let falseButtonTitle = "False"
    static let resultMessageFormat = "Your answer is %@"
    static let nextButtonTitle = "Next"
    
}
