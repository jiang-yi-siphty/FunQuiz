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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
        prepareViewModel()
    }
    
    func prepareViewController() {
        
        view.backgroundColor = .white
        
        scoreTitle.text = .scoreTitleText
        scoreTitle.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        scoreTitle.textAlignment = .center
        view.addSubview(scoreTitle)
        scoreTitle.translatesAutoresizingMaskIntoConstraints = false
        scoreTitle.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topSpace).isActive = true
        scoreTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpace).isActive = true
        scoreTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingSpace).isActive = true
        scoreTitle.isHidden = true
        
        scoreNumber.font = .boldSystemFont(ofSize: Constants.bodyFontSize)
        scoreNumber.textAlignment = .center
        view.addSubview(scoreNumber)
        scoreNumber.translatesAutoresizingMaskIntoConstraints = false
        scoreNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpace).isActive = true
        scoreNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingSpace).isActive = true
        scoreNumber.topAnchor.constraint(equalTo: scoreTitle.bottomAnchor, constant: Constants.leadingSpace).isActive = true
        scoreNumber.isHidden = true
        
        playButton.setTitle(.playButtonTitleText, for: .normal)
        playButton.setTitleColor(.blue, for: .normal) 
        playButton.titleLabel?.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        playButton.addTarget(self, action: #selector(navigateToQuestionView), for: .touchUpInside)
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpace).isActive = true
        playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingSpace).isActive = true
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.bottomSpace).isActive = true
    }
    
    func prepareViewModel() {
        viewModel.didUpdate = { 
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.scoreNumber.isHidden = self.viewModel.score == nil
                if let score = self.viewModel.score  {
                    self.scoreNumber.text = String(score)
                    self.scoreTitle.isHidden = false
                } else {
                    self.scoreNumber.text = nil
                    self.scoreTitle.isHidden = true
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
        let alert = UIAlertController(title: .alertTitleText, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: .alertButtonText, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func navigateToQuestionView(){
        viewModel.startQuiz()
        let questionsViewController = QuestionsViewController()
        self.navigationController!.pushViewController(questionsViewController, animated: true)
    }
    
}

fileprivate extension String {
    
    static let scoreTitleText = "Score"
    static let playButtonTitleText = "Play"
    static let alertTitleText = "Alert"
    static let alertButtonText = "OK"
    
}

