//
//  QuestionsViewModel.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class QuestionsViewModel {
    
    var store: QuestionsStore
    
    
    // MARK: Funcs
    init(_ store: QuestionsStore = QuestionsStore.shared) {
        self.store = store
        store.fetchQuestions()
    }
}
