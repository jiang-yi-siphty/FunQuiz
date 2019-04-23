//
//  DataClient.swift
//  FunQuiz
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//
import Foundation

class DataClient: DataService {
    
    func dataRequest(_ config: DataConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        dataRequestByFileNameSession(config, completionHandler: completionHandler)
    }
    
}

extension DataClient {
    
    // If someday we have API server, we can make func networkRequestByNSURLSession() to get data response
    fileprivate func dataRequestByFileNameSession(_ config: DataConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        completionHandler(JsonFileLoader.loadJson(fileName: config.fileName))
    }
    
}
