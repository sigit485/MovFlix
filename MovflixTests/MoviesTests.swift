//
//  MoviesTests.swift
//  MovflixTests
//
//  Created by Sigit on 13/01/23.
//

import XCTest

@testable import Movflix

final class MoviesTests: XCTestCase {

    func test_getGenreNotNil() {
        // setup
        let useCase = Injection.init().provideMovie()
        
        // prepare
        var result: [GenreResult]?
        var error: Error?
        let expectation = self.expectation(description: "should return success (no error)")
        
        // execute
        useCase.getMovieGenreList { _result in
            switch _result {
            case .success(let data):
                result = data
                expectation.fulfill()
            case .failure(let failure):
                error = failure
                XCTAssertNil(error)
            }
        }
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(result)
    }
    
    
    func test_GenreImageNotAvailable() {
        let useCase = Injection.init().provideMovie()
        
        // prepare
        let genreExpected = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama"]
        var error: Error?
        let expectation = self.expectation(description: "should return success (no error)")
        var result: [String] = []
        
        // exec
        useCase.getMovieGenreList { _result in
            switch _result {
            case .success(let data):
                let genreNameResponse = data.compactMap { return $0.name }
                result = genreNameResponse
                expectation.fulfill()
            case .failure(let failure):
                error = failure
                XCTAssertNil(error)
            }
        }
        waitForExpectations(timeout: 10)
        
        XCTAssertGreaterThan(result.count, genreExpected.count)
    }
    
    
    func test_MoviesNowPlayingNotNil() {
        let useCase = Injection.init().provideMovie()
        
        let expectation = self.expectation(description: "should return success (no error)")
        var result: [MovieResponseResult]?

        useCase.getMovies(page: 1, category: .nowPlaying) { _result in
            switch _result {
            case .success(let data):
                result = data
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed get list now playing, \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 10)

        XCTAssertNotNil(result)
    }

}
