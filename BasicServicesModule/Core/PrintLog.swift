//
//  PrintLog.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/5/17.
//

import Foundation

/// Log输出
/// 在DEBUG和ADHOC环境下输出
/// 借鉴：http://swifter.tips/log/
/// - Parameters:
///   - message:
///   - file:
///   - method:
///   - line:
public func printLog<T>(_ message: T,
                        file: String = #file,
                        method: String = #function,
                        line: Int = #line)
{
    #if DEBUG || ADHOC
    print("""
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        \((file as NSString).lastPathComponent)[\(line)], \(method)
        \(message)
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        """)
    #endif
}
