//
//  DetailTests.swift
//  MovflixTests
//
//  Created by Sigit on 13/01/23.
//

import XCTest

@testable import Movflix

final class DetailTests: XCTestCase {

    func test_ReviewDetailNotNil() {
        let useCase = Injection.init().provideDetail()
        
        // prepare
        var result: [DetailReviewResult]?
        let expectation = self.expectation(description: "should return success (no error)")
        let idMovie = 76600
        
        useCase.getReviewsMovie(idMovie: idMovie) { _result in
            switch _result {
            case .success(let data):
                result = data
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(result)
    }
    
    func test_ReviewDetailEmpty() {
        let useCase  = Injection.init().provideDetail()
        
        var result: [DetailReviewResult]?
        let idMovieEmpty = 315162
        let expectation = self.expectation(description: "should return success (no error)")
        let expectedEmptyCounter = 0
        
        useCase.getReviewsMovie(idMovie: idMovieEmpty) { _result in
            switch _result {
            case .success(let data):
                result = data
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(result?.count, expectedEmptyCounter)

    }

}
