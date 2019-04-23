//
//  LandingViewModel.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class LandingViewModel {
    
    enum ViewMode {
        case initial
        case scored
        case lastQuestion
        
        var hideScore: Bool {
            switch self {
            case .initial:
                return true
            default:
                return false
            }
        } 
    }
    
    // MARK: Variables
    var store: QuestionsStore
    var mode: ViewMode = .initial {
        didSet {
            self.viewModeChanged?()
        }
    }
    var questionsList: [Question]? {
        didSet {
            self.didUpdate?()
        }
    }
    
    var score: Int? {
        guard let questionList = store.quiz?.questions else { return nil }
        return questionList.reduce(0, {
            guard let correct = $1.correct else { return $0 }
            return correct ? $0 ?? 0 + 1 : $0 })
    }
    
    // MARK: Events 
    var viewModeChanged: (() -> Void)?
    var didUpdate: (() -> Void)?
    var hasAlertMessage: ((String) -> Void)?
    
    // MARK: Funcs
    init(_ store: QuestionsStore = QuestionsStore.shared) {
        self.store = store
        store.fetchQuestions()
    }
    
    func prepareStore() { 
        store.didUpdate = { [weak self] in
            guard let self = self else { return }
            self.questionsList = self.store.quiz?.questions
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
    
    func reset() {
        store.fetchQuestions()
    }
}
