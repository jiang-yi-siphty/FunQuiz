//
//  QuestionsStore.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class QuestionsStore {
    
    enum Mode {
        case initial
        case finishedQuiz
        case startQuiz
    }
    
    var mode: Mode = .initial {
        didSet {
            self.modeDidUpdate?()
        }
    }
    static let shared = QuestionsStore()
    let notificationCenter = NotificationCenter.default
    
    
    var dataClient: DataClient
    
    // MARK: Data Binding
    var quiz: Questions? {
        didSet {
            storeInitialized?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            guard let message = alertMessage else { return }
            hasCommonError?(.customError(message))
        }
    }
    
    var score: Int? 
    
    // MARK: Events 
    var storeInitialized: (() -> Void)?
    var modeDidUpdate: (() -> Void)?
    var hasCommonError: ((CommonError) -> Void)?
    
    
    // MARK: Init
    init(dataClient: DataClient = DataClient()) {
        self.dataClient = dataClient
    }
    
    func resetScore() {
        fetchQuestions()
    }
    
}


// MARK: - Session Handling
extension QuestionsStore {
    
    func fetchQuestions() {
        
        dataClient.dataRequest(.questionsData) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else {
                    self.alertMessage = "We run out of question..."
                    return 
                }
                do {
                    let decoder = JSONDecoder()
                    self.quiz = try decoder.decode(Questions.self, from: data)
                } catch let error {
                    self.hasCommonError?(.parsingError(error))
                }
            case .failure(let error):
                self.hasCommonError?(error)
            }   
        }
    }
    
}
