import Foundation

public extension Result {
    /// Gets the success value if this result is a success, otherwise returns `nil`.
    ///
    /// - Returns: The associated success value if this is a success result, or `nil` if it's a failure.
    /// - Note: This property provides a convenient way to safely unwrap the success value without using a switch statement.
    @inlinable 
    var success: Success? {
        guard case .success(let success) = self else { return nil }
        return success
    }
    
    /// Gets the failure value if this result is a failure, otherwise returns `nil`.
    ///
    /// - Returns: The associated error if this is a failure result, or `nil` if it's a success.
    /// - Note: This property provides a convenient way to safely unwrap the error value without using a switch statement.
    @inlinable 
    var failure: Failure? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
    
    /// A Boolean value indicating whether this result is a success.
    ///
    /// - Returns: `true` if this result is a success, `false` otherwise.
    @inlinable 
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
    
    /// A Boolean value indicating whether this result is a failure.
    ///
    /// - Returns: `true` if this result is a failure, `false` otherwise.
    @inlinable 
    var isFailure: Bool {
        guard case .failure = self else { return false }
        return true
    }
}