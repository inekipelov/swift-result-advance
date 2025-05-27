//
//  ResultPropertiesTests.swift
//

import XCTest
@testable import ResultAdvance

final class ResultPropertiesTests: XCTestCase {
    enum TestError: Error, Equatable {
        case error
    }
    
    func testSuccessOrNil() {
        let result: Result<Int, TestError> = .success(42)
        XCTAssertNotNil(result.success)
        XCTAssertNil(result.failure)
    }
    
    func testFailureOrNil() {
        let result: Result<Int, TestError> = .failure(.error)
        XCTAssertNotNil(result.failure)
        XCTAssertNil(result.success)
    }

    func testBoolSuccess() {
        let result: Result<Int, TestError> = .success(42)
        XCTAssertTrue(result.isSuccess)
        XCTAssertFalse(result.isFailure)
    }
    
    func testBoolFailure() {
        let result: Result<Int, TestError> = .failure(.error)
        XCTAssertTrue(result.isFailure)
        XCTAssertFalse(result.isSuccess)
    }
}
