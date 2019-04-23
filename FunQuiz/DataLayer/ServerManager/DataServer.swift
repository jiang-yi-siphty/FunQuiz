//
//  DataServer.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

protocol DataService {
    func dataRequest(_ config: DataConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void))
}

enum CommonError: Error {
    case fileError(_ jsonFileName: String?, error: Error)
    case customError(_ errorMessage: String)
    case parsingError(_ error: Error)
    case urlError
    
    var description: String {
        switch self {
        case .fileError(let fileName, _):
            if let fileName = fileName {
                return "Generic Error with file \(fileName)"
            } else {
                return "Generic Error"
            }
        case .customError(let errorMessage):
             return errorMessage
        case .parsingError(_):
            return "Parsing Error!! Unable to parse the json data"
        case .urlError:
            return "Invalid path url."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .fileError(let fileName, let error):
            if let fileName = fileName {
            return "Opening \(fileName).json get generic error: \(error.localizedDescription)"
            } else {
                return "\(error.localizedDescription)"
            }
        case .customError(_):
            return nil
        case .parsingError(let error):
            return "Parsing the json data has the issue: \(error.localizedDescription)"
        case .urlError:
            return "Please check: Is the file in the project bundle? Is the URL has correct format? "
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
    
    class func loadJson(fileName: String) -> Result<Data?, CommonError> {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return .success(try NSData(contentsOf: url) as Data)
            } catch let error {
                return .failure(.fileError(fileName, error: error) )
            }
        } else {
            return .failure(.urlError)
        }
    }
    
}
