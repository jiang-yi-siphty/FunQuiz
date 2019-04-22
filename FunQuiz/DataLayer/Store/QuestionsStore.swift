//
//  QuestionsStore.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

protocol QuestionsStoreDelegate: class {
    func questionsStoreDidUpdate(questionsStore: QuestionsStore)
    func questionsStoreWillUpdate()
}

class QuestionsStore {
    
    static let shared = QuestionsStore()
    let notificationCenter = NotificationCenter.default
    
    
    var dataClient: DataClient
    
    // MARK: Data Binding
    var questions: Questions? {
        didSet {
            didUpdate.forEach { closure in
                closure?()
            }
        }
    }
    
    // MARK: Events 
    var didUpdate = [(() -> Void)?]()
    
    
    // MARK: Init
    init(dataClient: DataClient = DataClient()) {
        self.dataClient = dataClient
    }
    
    func load() {
        
    }
    
    func reset() {
        didUpdate = [(() -> Void)?]()
        load()
    }
    
}


// MARK: - Session Handling
extension QuestionsStore {
    
    func fetchQuestions(completionHandler: @escaping (Result<[Question], ServerError>) -> Void) {
        
    }
    
}
