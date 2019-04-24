//
//  QuestionsViewModel.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

class QuestionsViewModel {
    
    var store: QuestionsStore
    var questionsList = QuestionsStore.shared.quiz?.questions
    var title: String {
        return String(format: .navigationTitleFormat, questionIndex + 1)
    }
    var questionIndex: Int = 0 
    var questionText: String? {
        guard questionIndex < questionsList?.count ?? 0 else { return nil }
        return questionsList?[questionIndex].question
    }
    var answerValue: Bool? = nil {
        didSet {
            guard questionIndex < questionsList?.count ?? 0 else { return }
            let correctAnwser = questionsList?[questionIndex].answer
            QuestionsStore.shared.quiz?.questions[questionIndex].correct = correctAnwser == answerValue
            resultText = String(format: .resultMessageFormat, 
                                (correctAnwser == answerValue ? 
                                    String.resultRight : String.resultWrong))
            anwserResultIsReady?()
        }
    }
    var resultText: String? = nil
    
    // MARK: Events 
    var nextQuestionIsReady: (() -> Void)?
    var anwserResultIsReady: (() -> Void)?
    var hasAlertMessage: ((String) -> Void)?
    
    // MARK: Funcs
    init(_ store: QuestionsStore = QuestionsStore.shared) {
        self.store = store
        store.fetchQuestions()
        prepareStore()
    }
    
    func nextQuestion() {
        if questionIndex + 1 < questionsList?.count ?? 0 {
            questionIndex += 1
            nextQuestionIsReady?()
        }
    }
    
    private func prepareStore() { 
        store.storeInitialized = { [weak self] in
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
    
    func hasNextQuestion() -> Bool {
        return questionIndex + 1 >= questionsList?.count ?? 0
    }
    
    func finishedQuiz() {
        store.mode = .finishedQuiz
    }
}

fileprivate extension String {
    static let navigationTitleFormat = "Question %d"
    static let resultMessageFormat = "Your anwser is %@"
    static let resultRight = "right"
    static let resultWrong = "wrong"
}
