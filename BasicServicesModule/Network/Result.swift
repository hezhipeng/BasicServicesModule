//
//  HttpResult.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/22.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

public enum Result<Value> {
    
    case success(Value, String?)
    case failure(ApiError)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value, _ ):
            return value
        case .failure:
            return nil
        }
    }
    
    public var message: String? {
        switch self {
        case .success( _ , let message):
            return message
        case .failure(let error):
            return error.message
        }
    }
    
    public var error: ApiError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

extension Result {
    /// Evaluates the specified closure when the `Result` is a success, passing the unwrapped value as a parameter.
    ///
    /// Use the `map` method with a closure that does not throw. For example:
    ///
    ///     let possibleData: Result<Data> = .success(Data())
    ///     let possibleInt = possibleData.map { $0.count }
    ///     try print(possibleInt.unwrap())
    ///     // Prints "0"
    ///
    ///     let noData: Result<Data> = .failure(error)
    ///     let noInt = noData.map { $0.count }
    ///     try print(noInt.unwrap())
    ///     // Throws error
    ///
    /// - parameter transform: A closure that takes the success value of the `Result` instance.
    ///
    /// - returns: A `Result` containing the result of the given closure. If this instance is a failure, returns the
    ///            same failure.
    public func map<T>(_ transform: (Value) -> T) -> Result<T> {
        switch self {
        case .success(let value, let message):
            return .success(transform(value), message)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// Evaluates the specified closure when the `Result` is a success, passing the unwrapped value as a parameter.
    ///
    /// Use the `flatMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: Result<Data> = .success(Data(...))
    ///     let possibleObject = possibleData.flatMap {
    ///         try JSONSerialization.jsonObject(with: $0)
    ///     }
    ///
    /// - parameter transform: A closure that takes the success value of the instance.
    ///
    /// - returns: A `Result` containing the result of the given closure. If this instance is a failure, returns the
    ///            same failure.
    public func flatMap<T>(_ transform: (Value) throws -> T) -> Result<T> {
        switch self {
        case .success(let value, let message):
            do {
                return try .success(transform(value), message)
            } catch {
                return .failure(.DecodeError)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}


