//
//  DataServer.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

protocol DataService {
    func dataRequest(_ config: DataConfig, completionHandler: @escaping ((Result<Data?, ServerError>) -> Void))
}

enum ServerError: Error {
    case parsingIssue(_ jsonFileName: String, error: Error)
    case noFile
    
    var description: String {
        switch self {
        case .parsingIssue(let fileName, _):
            return "Error!! Unable to parse  \(fileName).json"
        case .noFile:
            return "Invalid path."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .parsingIssue(let fileName, let error):
            return "Parsing \(fileName).json has issue: \(error.localizedDescription)"
        case .noFile:
            return "Please check: Is the file in the project bundle? "
        }
    }
    
}

enum DataConfig {
    case questionsData
    
    var fileName: String {
        switch self {
        case .questionsData:
            return "swiftQuestions"
        }
    }
    
}

class JsonFileLoader {
    
    class func loadJson(fileName: String) -> Result<Data?, ServerError> {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return .success(try NSData(contentsOf: url) as Data)
            } catch let error {
                return .failure(.parsingIssue(fileName, error: error) )
            }
        } else {
            return .failure(.noFile)
        }
    }
    
}
