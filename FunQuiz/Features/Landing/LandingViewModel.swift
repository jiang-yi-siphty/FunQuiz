//
//  LandingViewModel.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

class LandingViewModel {
    
    // MARK: Variables
    var store: QuestionsStore
    
    var questionsList: [Question]? {
        didSet {
            self.didUpdate?()
        }
    }
    
    var score: Int? {
        guard let questionList = store.quiz?.questions else { return nil }
        return questionList.reduce(0) { $0 + ($1.correct ?? false ? 1 : 0)}
    }
    
    // MARK: Events 
    var viewModeInitialized: (() -> Void)?
    var didUpdate: (() -> Void)?
    var hasAlertMessage: ((String) -> Void)?
    
    // MARK: Funcs
    init(_ store: QuestionsStore = QuestionsStore.shared) {
        self.store = store
        store.fetchQuestions()
        prepareStore()
    }
    
    private func prepareStore() { 
        store.storeInitialized = { [weak self] in
            guard let self = self else { return }
            self.questionsList = self.store.quiz?.questions
            self.viewModeInitialized?()
        }
        
        store.modeDidUpdate = {  [weak self] () in
            guard let self = self else { return }
            switch self.store.mode {
            case .initial:
                self.viewModeInitialized?()
            case .startQuiz:
                self.store.resetScore()
                break
            case .finishedQuiz:
                self.didUpdate?()
            }
        }
        
        store.hasCommonError = { error in 
            switch error {
            case .customError(let message):
                self.hasAlertMessage?(message)
            default:
                fatalError("\(error.description)\n\(error.recoverySuggestion ?? "")")
            }
        }
    }
    
    func startQuiz() {
        store.mode = .startQuiz
        store.fetchQuestions()
    }
}
