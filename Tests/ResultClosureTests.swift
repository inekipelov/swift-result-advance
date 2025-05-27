//
//  ResultClosureTests.swift
//

import XCTest
@testable import ResultAdvance

final class ResultClosureTests: XCTestCase {
    enum TestError: Error, Equatable {
        case error
    }
    
    func testResultClosures() {
        let result: Result<Int, TestError> = .success(42)
        result.onSuccess { value in
            XCTAssertEqual(value, 42)
        }.onFailure { _ in
            XCTFail("Expected success, but got failure")
        }
        
        let secondResult: Result<Int, TestError> = .failure(.error)
        secondResult.onSuccess { _ in
            XCTFail("Expected failure, but got success")
        }.onFailure { error in
            XCTAssertEqual(error, .error)
        }
    }
    
    func testResultAsyncClosures() {
        let result: Result<Int, TestError> = .success(42)
        result.onSuccess { value in
            try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
            XCTAssertEqual(value, 42)
        }.onFailure { _ in
            XCTFail("Expected success, but got failure")
        }
        
        let secondResult: Result<Int, TestError> = .failure(.error)
        secondResult.onSuccess { _ in
            XCTFail("Expected failure, but got success")
        }.onFailure { error in
            try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
            XCTAssertEqual(error, .error)
        }
    }
}
