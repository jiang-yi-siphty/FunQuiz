//
//  LandingViewController.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    
    lazy var viewModel: LandingViewModel = {
        return LandingViewModel()
    }()
    
    private var scoreTitle = UILabel()
    private var scoreNumber = UILabel()
    private var playButton = UIButton()
    private var scoreStackView = UIStackView()
    var backButton: UIButton? = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
        prepareViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViewController()
    }
    
    func prepareViewController() {
        
        view.backgroundColor = .white
        let mainStackView = UIStackView()
        mainStackView.backgroundColor = .yellow
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        mainStackView.spacing = 100
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mainStackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainStackView.addArrangedSubview(scoreStackView)
        playButton.setTitle(.playButtonTitleText, for: .normal)
        playButton.setTitleColor(.blue, for: .normal) 
        playButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        playButton.addTarget(self, action: #selector(navigateToQuestionView), for: .touchUpInside)
        mainStackView.addArrangedSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        scoreTitle.text = .scoreTitleText
        scoreStackView.backgroundColor = .green
        scoreTitle.font = .boldSystemFont(ofSize: 24)
        scoreNumber.font = .boldSystemFont(ofSize: 18)
        scoreStackView.addArrangedSubview(scoreTitle)
        scoreStackView.addArrangedSubview(scoreNumber)
        scoreStackView.axis = .vertical
        scoreStackView.distribution = .fillEqually
        scoreStackView.alignment = .center
        scoreStackView.spacing = 40
        scoreStackView.isHidden = true
    }
    
    private func updateViewController() {
        scoreStackView.isHidden = viewModel.mode.hideScore
    }
    
    func prepareViewModel() {
        viewModel.didUpdate = { 
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.scoreStackView.isHidden = self.viewModel.mode.hideScore
                if !self.scoreStackView.isHidden, 
                    let score = self.viewModel.score {
                    self.scoreNumber.text = String(score)
                }
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
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func navigateToQuestionView(){
        let questionsViewController = QuestionsViewController()
        self.navigationController!.pushViewController(questionsViewController, animated: true)
    }
    
}

fileprivate extension String {
    static let scoreTitleText = "Score"
    static let playButtonTitleText = "Play"
}

