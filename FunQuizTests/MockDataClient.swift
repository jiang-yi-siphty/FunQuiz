//
//  MockDataClient.swift
//  FunQuizTests
//
//  Created by Yi JIANG on 25/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class MockDataClient: DataClient {
    
    //Use mock json file 
    func dataRequest(_ config: MockDataConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        dataRequestByFileNameSession(config, completionHandler: completionHandler)
    }
}

extension MockDataClient {
    
    // If someday we have API server, we can make func networkRequestByNSURLSession() to get data response
    fileprivate func dataRequestByFileNameSession(_ config: MockDataConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        completionHandler(JsonFileLoader.loadJson(fileName: config.fileName))
    }
    
}

enum MockDataConfig {
    case wrongFormate
    case correctFormate
    case wrongFilePath
    
    var fileName: String {
        switch self {
        case .wrongFormate:
            return "swiftQuestions_wrongFormate"
        case .correctFormate:
            return "swiftQuestions_correctFormate"
        case .wrongFilePath:
            return "swiftQuestions_notExist"
        }
    }
    
}
