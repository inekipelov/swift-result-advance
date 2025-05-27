//
//  ResultMappingTests.swift
//

import XCTest
@testable import ResultAdvance

final class ResultMappingTests: XCTestCase {
    enum TestError: Error, Equatable {
        case error
    }
    enum NewTestError: Error, Equatable {
        case newError
    }
    
    func testAsyncMapSuccess() async throws {
        let result: Result<Int, TestError> = .success(42)
        
        let mappedResult = try await result.map { value in
            try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
            return value * 2
        }
        
        switch mappedResult {
            case .success(let value):
                XCTAssertEqual(value, 84)
            case .failure:
                XCTFail("Expected success, but got failure")
        }
    }
    
    func testAsyncMapFailure() async throws {
        let result: Result<Int, TestError> = .failure(.error)
        let mappedResult = try await result.mapFailure { error in
            try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
            return NewTestError.newError
        }
        
        switch mappedResult {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, NewTestError.newError)
        }
    }
    
    func testMapping() {
        let result: Result<Int, TestError> = .success(42)
        let unified = result.map(success: { $0 * 2 }, failure: { _ in 0 })
        
        XCTAssertEqual(unified, 84)
        
        let secondResult: Result<Int, TestError> = .failure(.error)
        let secondUnified = secondResult.map(success: { $0 * 2 }, failure: { _ in 0 })
        
        XCTAssertEqual(secondUnified, 0)
    }
    
    func testAsyncMapping() async throws {
        let result: Result<Int, TestError> = .success(42)
        let unified = try await result.map(
            success: {
                try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
                return $0 * 2
            }, failure: { _ in
                try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
                return 0
            }
        )
        
        XCTAssertEqual(unified, 84)
        
        let secondResult: Result<Int, TestError> = .failure(.error)
        let secondUnified = try await secondResult.map(
            success: {
                try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
                return $0 * 2
            }, failure: { _ in
                try await Task.sleep(nanoseconds: 1_000_000) // Simulate async operation
                return 0
            }
        )
        
        XCTAssertEqual(secondUnified, 0)
    }
}
