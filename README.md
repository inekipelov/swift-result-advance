# ResultAdvance

[![Swift Version](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Swift Tests](https://github.com/inekipelov/swift-result-advance/actions/workflows/swift.yml/badge.svg)](https://github.com/inekipelov/swift-result-advance/actions/workflows/swift.yml)

A collection of Swift extensions to improve the `Result` type with additional functionality, providing a more ergonomic API for handling results in Swift applications.

## Features

### Properties

- **`success`**: Gets the success value if available, otherwise returns `nil`
- **`failure`**: Gets the failure value if available, otherwise returns `nil`
- **`isSuccess`**: Boolean flag indicating if the result is a success
- **`isFailure`**: Boolean flag indicating if the result is a failure

### Callbacks

- **`onSuccess(_:)`**: Execute a closure when the result is a success
- **`onFailure(_:)`**: Execute a closure when the result is a failure
- **Async variants**: Support for async operations with Task priorities

### Mapping

- **`map(_:)`**: Async-compatible success value mapping
- **`mapFailure(_:)`**: Async-compatible failure value mapping
- **`map(success:failure:)`**: Map both success and failure to a common type
- **Async variants**: Full support for async/await operations

## Requirements

- Swift 5.5+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/inekipelov/swift-result-advance.git", from: "0.1.0")
]
```

And then add the dependency to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["ResultAdvance"]),
]
```

## Usage

Import the package in your Swift files:

```swift
import ResultAdvance
```

### Working with Properties

Access success or failure values directly through properties:

```swift
let result: Result<Int, Error> = .success(42)

// Access values directly with properties
if let value = result.success {
    print("Success value: \(value)")
}

if let error = result.failure {
    print("Error: \(error)")
}

// Check state with boolean properties
if result.isSuccess {
    print("Operation succeeded")
}

if result.isFailure {
    print("Operation failed")
}
```

### Using Callbacks

Handle success and failure cases with chainable callbacks:

```swift
fetchUserData()
    .onSuccess { user in
        // Handle successful user data retrieval
        updateUI(with: user)
    }
    .onFailure { error in
        // Handle error case
        showError(error)
    }
```

### Async Support

```swift
// Async callbacks
fetchUserData()
    .onSuccess { user in
        await saveUserToDatabase(user)
    }
    .onFailure { error in
        await logError(error)
    }

// Async mapping
let processedResult = await result.map { value in
    return await processValue(value)
}
```

### Mapping Operations

Transform result values with mapping operations:

```swift
// Map success values
let doubledResult = result.map { value in
    return value * 2
}

// Map failure values
let mappedErrorResult = result.mapFailure { error in
    return AppError.mapped(from: error)
}

// Map to a unified type
let finalValue = result.map(
    success: { value in return "Success: \(value)" },
    failure: { error in return "Error: \(error)" }
)
```

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more information.
