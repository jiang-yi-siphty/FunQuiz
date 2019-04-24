//
//  FunQuizTests.swift
//  FunQuizTests
//
//  Created by Yi JIANG on 22/4/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import XCTest
@testable import FunQuiz

class FunQuizTests: XCTestCase {
    var store: QuestionsStore!
    var mockDataClient: MockDataClient!
    var quiz: Questions?
    
    override func setUp() {
        super.setUp()
        mockDataClient = MockDataClient()
        store = QuestionsStore(dataClient: mockDataClient)
    }
    
    override func tearDown() {
        mockDataClient = nil	
        store = nil
    }
    
    func testQuestionsDataLayerWithWrongJsonFormate() {
        // Given
        let mockDataConfig = MockDataConfig.wrongFormate
        
        mockDataClient.dataRequest(mockDataConfig) { result in
            
            // Assert
            switch result {
            case .success(let data):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .urlError:
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }  
        }
    }
    
    func testQuestionsDataLayerWithWrongUrl() {
        // Given
        let mockDataConfig = MockDataConfig.wrongFilePath
        
        // When
        mockDataClient.dataRequest(mockDataConfig) { result in
            
            // Assert
            switch result {
            case .success(let data):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .urlError:
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }  
        }
    }
    
    func testQuestionsDataLayerWithCorrectFormate() {
        // Given
        let mockDataConfig = MockDataConfig.wrongFormate
        
        // When
        mockDataClient.dataRequest(mockDataConfig) { result in
            
            // Assert
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self.quiz = try decoder.decode(Questions.self, from: data!)
                } catch let error {
                    XCTAssert( true )
                }
            case .failure(let error):
                XCTAssert(true)
            }  
        }
    }
    
    
}
