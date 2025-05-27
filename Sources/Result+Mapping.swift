import Foundation

public extension Result {
    /// Maps the success value of the result to a new value using the provided asynchronous closure.
    ///
    /// - Parameter transform: An asynchronous closure that takes the success value and returns a new value.
    /// - Returns: A new result with the transformed success value or the original failure.
    @available(iOS 15, *)
    @inlinable 
    func map<NewSuccess>(_ transform: (Success) async throws -> NewSuccess) async rethrows -> Result<NewSuccess, Failure> {
        switch self {
        case .success(let value):
            return .success(try await transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// Maps the failure value of the result to a new value using the provided asynchronous closure.
    ///
    /// - Parameter transform: An asynchronous closure that takes the failure value and returns a new value.
    /// - Returns: A new result with the transformed failure value or the original success.
    @available(iOS 15, *)
    @inlinable 
    func mapFailure<NewFailure>(_ transform: (Failure) async throws -> NewFailure) async rethrows -> Result<Success, NewFailure> {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .failure(try await transform(error))
        }
    }

    /// Maps both success and failure values to a common type using provided async closures.
    ///
    /// - Parameters:
    ///   - successTransform: An async closure that takes the success value and returns a value of the common type.
    ///   - failureTransform: An async closure that takes the failure value and returns a value of the common type.
    /// - Returns: The transformed value of the common type.
    ///
    @inlinable 
    func map<T>(
        success successTransform: (Success) throws -> T,
        failure failureTransform: (Failure) throws -> T
    ) rethrows -> T {
        switch self {
        case .success(let value):
            return try successTransform(value)
        case .failure(let error):
            return try failureTransform(error)
        }
    }

    /// Maps both success and failure values to a common type using provided asynchronous closures.
    ///
    /// - Parameters:
    ///   - successTransform: An asynchronous closure that takes the success value and returns a value of the common type.
    ///   - failureTransform: An asynchronous closure that takes the failure value and returns a value of the common type.
    /// - Returns: The transformed value of the common type.
    @available(iOS 15, *)
    @inlinable 
    func map<T>(
        success successTransform: (Success) async throws -> T,
        failure failureTransform: (Failure) async throws -> T
    ) async rethrows -> T {
        switch self {
        case .success(let value):
            return try await successTransform(value)
        case .failure(let error):
            return try await failureTransform(error)
        }
    }
}
