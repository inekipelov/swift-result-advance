
import Foundation

public extension Result {
    /// Executes the provided closure when the `Result` is a success case.
    ///
    /// - Parameter closure: A closure that takes the success value as its parameter.
    /// - Returns: The original `Result` instance, allowing for method chaining.
    @inlinable 
    @discardableResult
    func onSuccess(_ closure: (Success) -> Void) -> Self {
        if case .success(let value) = self {
            closure(value)
        }
        return self
    }
    
    /// Executes the provided asynchronous operation when the `Result` is a success case.
    ///
    /// - Parameters:
    ///   - priority: The priority of the task. Pass `nil` to use the current priority.
    ///   - operation: An asynchronous closure that takes the success value as its parameter.
    /// - Returns: The original `Result` instance, allowing for method chaining.
    @inlinable 
    @discardableResult
    func onSuccess(
        priority: TaskPriority? = nil,
        operation: @escaping (Success) async throws -> Void
    ) -> Self {
        if case .success(let value) = self {
            Task(priority: priority) {
                try await operation(value)
            }
        }
        return self
    }
    
    /// Executes the provided closure when the `Result` is a failure case.
    ///
    /// - Parameter closure: A closure that takes the error value as its parameter.
    /// - Returns: The original `Result` instance, allowing for method chaining.
    @inlinable
    @discardableResult
    func onFailure(_ closure: (Failure) -> Void) -> Self {
        if case .failure(let error) = self {
            closure(error)
        }
        return self
    }
    
    /// Executes the provided asynchronous operation when the `Result` is a failure case.
    ///
    /// - Parameters:
    ///   - priority: The priority of the task. Pass `nil` to use the current priority.
    ///   - operation: An asynchronous closure that takes the error value as its parameter.
    /// - Returns: The original `Result` instance, allowing for method chaining.
    @inlinable
    @discardableResult
    func onFailure(
        priority: TaskPriority? = nil,
        operation: @escaping (Failure) async throws -> Void
    ) -> Self {
        if case .failure(let error) = self {
            Task(priority: priority) {
                try await operation(error)
            }
        }
        return self
    }
}
