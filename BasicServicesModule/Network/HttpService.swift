//
//  HttpService.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/22.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Moya
import RxSwift

private var unknownErrorCode = -1

public typealias JsonInfo = [String: Any]

public protocol HttpService {
    
    func decode<T>(response: Data,
                   of: T.Type) throws -> T where T: Codable
    
    func networkServer<Target: TargetType>(api: Target,
                                           parser: @escaping (JsonInfo) -> Result<Any>)
        -> Observable<Result<Any>>
}

public extension HttpService {
    
    func decode<T>(response: Data,
                   of: T.Type) throws -> T where T: Codable {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: response)
        
        return model
    }
    
    func networkServer<Target: TargetType>(api: Target,
                                           parser: @escaping (JsonInfo) -> Result<Any>)
        -> Observable<Result<Any>> {
            
            #if DEBUG || ADHOC
            print("""
                =======================================================
                网络请求
                接口: \(api.baseURL.absoluteString+api.path)
                get接口: \(api.baseURL.absoluteString+api.path)\(api.task.parameters()?.getURLParams() ?? "")
                param: \(api.task.parameters()?.jsonString() ?? "" )
                bodyParam: \(api.task.bodyParameters()?.jsonString() ?? "")
                =======================================================
                """)
            #endif
            
            let provider = MoyaProvider<Target>()
            
            switch api.task {
            case .uploadMultipart, .uploadCompositeMultipart, .uploadFile:
                return provider.rx.requestWithProgress(api, callbackQueue: DispatchQueue.main)
                    .asObservable()
                    .catchError({ (error) -> Observable<ProgressResponse> in
                        
                        if let moyaError = error as? MoyaError,
                            let nsError = moyaError.error as NSError? {
                            
                            let error = apiError(code: nsError.code)
                            return Observable.just(ProgressResponse(progress: nil, response: Response(statusCode: error.code ?? unknownErrorCode, data: Data())))
                        }
                        return Observable.just(ProgressResponse(progress: nil, response: Response(statusCode: unknownErrorCode, data: Data())))
                    })
                    .map({ (progress) -> Result<Any> in
                        
                        if self.isError(progress.response) {
                            let error = apiError(code: (progress.response?.statusCode)!)
                            return  .failure(error)
                        }
                        else {
                            if let _ = progress.progressObject {
                                if progress.completed {
                                    if let response = progress.response {
                                        return self.parserData(response, parser)
                                    }
                                    else {
                                        return .failure(.URLErrorUnknown)
                                    }
                                }
                                else {
                                    #if DEBUG || ADHOC
                                    print("""
                                        -------------------------------------------------------
                                        请求结果
                                        上传进度:\(progress.progress)
                                        -------------------------------------------------------
                                        """)
                                    #endif
                                    return .success(progress.progress, nil)
                                }
                            }
                            else {
                                return .failure(.URLErrorUnknown)
                            }
                        }
                    })
                    .share(replay: 1)
            default:
                return provider.rx.request(api)
                    .asObservable()
                    .retry(5)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                    .observeOn(MainScheduler.instance)
                    .catchError({ (error) -> Observable<Response> in
                        
                        if let moyaError = error as? MoyaError,
                            let nsError = moyaError.error as NSError? {
                            
                            let error = apiError(code: nsError.code)
                            return Observable.just(Response(statusCode: error.code ?? unknownErrorCode, data: Data()))
                        }
                        
                        return Observable.just(Response(statusCode: unknownErrorCode, data: Data()))
                    })
                    .map({ (response) -> Result<Any> in
                        
                        if self.isError(response) {
                            let error = apiError(code: response.statusCode)
                            return  .failure(error)
                        }
                        else {
                            return self.parserData(response, parser)
                        }
                    })
                    .share(replay: 1)
            }
    }
    
    private func isError(_ response: Response?) -> Bool {
        
        guard let response = response else {
            return false
        }
        if response.data.count == 0,
            response.request == nil,
            response.response == nil {
            let error = apiError(code: (response.statusCode))
            
            #if DEBUG || ADHOC
            print("""
                -------------------------------------------------------
                请求异常结果
                接口: \(response.request?.url?.absoluteString ?? "")
                返回: \(error.message)
                -------------------------------------------------------
                """)
            #endif
            return true
        }
        return false
    }
    
    private func parserData(_ response: Response,
                            _ parser: @escaping (JsonInfo) -> Result<Any>) ->Result<Any> {
        do {
            let json = try response.mapJSON()
            #if DEBUG || ADHOC
            print("""
                -------------------------------------------------------
                请求结果
                接口: \(response.request?.url?.absoluteString ?? "")
                返回值: \(json)
                ------------------------------------------------------
                """)
            #endif
            
            guard let jsonData = json as? JsonInfo else {
                return .failure(.URLErrorUnknown)
            }
            return parser(jsonData)
            
        } catch {
            #if DEBUG || ADHOC
//            fatalError("response.mapJSON() exception")
            #endif
            return .failure(.DecodeError)
        }
    }
}


public func apiError(code: Int) -> ApiError {
    switch code {
    case NSURLErrorNotConnectedToInternet:
        return .URLErrorNotConnectedToInternet(errorCode: NSURLErrorNotConnectedToInternet)
    case NSURLErrorTimedOut:
        return .URLErrorTimedOut(errorCode: NSURLErrorTimedOut)
    case NSURLErrorCannotConnectToHost:
        return .URLErrorCannotConnectToHost(errorCode: NSURLErrorCannotConnectToHost)
    case NSURLErrorNetworkConnectionLost:
        return .URLErrorNetworkConnectionLost(errorCode: NSURLErrorNetworkConnectionLost)
    case NSURLErrorCancelled:
        return .URLErrorCancelled(errorCode: NSURLErrorCancelled)
    default:
        return .URLErrorUnknown
    }
}

extension MoyaError {
    
    var error: Swift.Error? {
        switch self {
        case .imageMapping(_): return nil
        case .jsonMapping(_): return nil
        case .stringMapping(_): return nil
        case .objectMapping(let error, _): return error
        case .statusCode(_): return nil
        case .underlying(let error, _): return error
        case .encodableMapping(let error): return error
        case .requestMapping: return nil
        case .parameterEncoding(let error): return error
        }
    }
}

extension Task {
    
    func parameters() -> JsonInfo? {
        switch self {
        case .requestParameters(let parameters, _): return parameters
        case .requestCompositeParameters(_ , _ , let urlParameters): return urlParameters
        case .uploadCompositeMultipart(_ , let urlParameters): return urlParameters
        case .downloadParameters(let parameters, _ , _): return parameters
        default: return nil
        }
    }
    
    func bodyParameters() -> JsonInfo? {
        switch self {
        case .requestCompositeParameters(let bodyParameters, _ , _): return bodyParameters
        default: return nil
        }
    }
    
}

extension Dictionary {
    func jsonString() -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [JSONSerialization.WritingOptions.prettyPrinted])
        guard jsonData != nil else {return nil}
        let jsonString = String(data: jsonData!, encoding: .utf8)
        guard jsonString != nil else {return nil}
        return jsonString
    }
    
    func getURLParams() -> String {
        if self.isEmpty {
            return ""
        }
        else {
            let params = self.map { "\($0)=\($1)" }
            return "?\(params.joined(separator: "&"))"
        }
    }
}
