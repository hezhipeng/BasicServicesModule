//
//  ApiError.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/31.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

public enum ApiError: Error {
    /// 没有网络
    case URLErrorNotConnectedToInternet(errorCode: Int)
    /// 连接超时
    case URLErrorTimedOut(errorCode: Int)
    /// 无法连接网络
    case URLErrorCannotConnectToHost(errorCode: Int)
    /// 连接丢失
    case URLErrorNetworkConnectionLost(errorCode: Int)
    /// 取消连接
    case URLErrorCancelled(errorCode: Int)
    /// 不知道的错误
    case URLErrorUnknown(errorCode: Int)
    
    /// 服务器返回不正确(不是成功的code)
    case ServiceIncorrect(code: Int, message: String?)
    /// 服务器返回重新登录
    case ReLogin(message: String?)
    /// 解码返回值出错
    case DecodeError
    
    public var code: Int {
        switch self {
        case .URLErrorNotConnectedToInternet(let errorCode):
            return errorCode
        case .URLErrorTimedOut(let errorCode):
            return errorCode
        case .URLErrorCannotConnectToHost(let errorCode):
            return errorCode
        case .URLErrorNetworkConnectionLost(let errorCode):
            return errorCode
        case .URLErrorCancelled(let errorCode):
            return errorCode
        case .URLErrorUnknown(let errorCode):
            return errorCode
        case .ServiceIncorrect(let code, _ ):
            return code
        case .ReLogin( _ ):
            return 0
        case .DecodeError:
            return 0
        }
    }
    
    public var message: String {
        switch self {
        case .URLErrorNotConnectedToInternet:
            return "网络不可用，请检查网络"
        case .URLErrorTimedOut:
            return "网络连接超时，请检查网络"
        case .URLErrorCannotConnectToHost:
            return "网络不稳定，请检查网络"
        case .URLErrorNetworkConnectionLost:
            return "网络异常，请检查网络"
        case .URLErrorCancelled:
            return "网络异常，请检查网络"
        case .URLErrorUnknown:
            return "网络异常，请检查网络"
        case .ServiceIncorrect( _ , let message):
            return message ?? ""
        case .ReLogin(let message):
            return message ?? "请重新登录"
        case .DecodeError:
            return "Decode Response Data Error"
        }
    }
}
