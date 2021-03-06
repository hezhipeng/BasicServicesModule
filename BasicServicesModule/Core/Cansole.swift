//
//  Cansole.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/5/17.
//

import Foundation

/// printX输出
/// 在DEBUG和ADHOC环境下输出
///
///
/// - 借鉴：http://swifter.tips/log/
///
/// - Parameters:
///   - message: 文本输出
///   - file: 所在文件
///   - method: 所在方法
///   - line: 所在行数
public func printX(_ items: Any...,
                    file: String = #file,
                    method: String = #function,
                    line: Int = #line) {
    
    #if DEBUG
    print("""
        =================================================
        \((file as NSString).lastPathComponent)[\(line)]
        \(method)
        
        \(items)
        =================================================
        """)
    #endif
}
