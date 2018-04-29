//
//  HttpService.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/22.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Moya
import RxSwift

private var loginSuccessCodeVar = 0
private var reLoginCodeVar = 0
private var unknownErrorCode = -1

public protocol HttpService {
    
    func LoginSuccessCode() -> Int

    func reLoginCode() -> Int
    
    func decode<T>(response: Data,
                   of: T.Type) throws -> T where T: Codable
    
    func networkServer<Target: TargetType>(api: Target,
                       parser: @escaping (Response) -> Result<Any>,
                       parserProgress: @escaping (ProgressResponse) ->Result<Any>)
        -> Observable<Result<Any>>

}

public extension HttpService {
    
    func loginSuccessCode() -> Int {
        return 200
    }

    func reLoginCode() -> Int {
        return 301
    }

    func decode<T>(response: Data,
                   of: T.Type) throws -> T where T: Codable {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: response)
        
        return model
    }
    
    func networkServer<Target: TargetType>(api: Target,
                                           parser: @escaping (Response) -> Result<Any> = parserNormal,
                                           parserProgress: @escaping
                                                (ProgressResponse) ->
                                                Result<Any> =
                                                parserProgress)
        -> Observable<Result<Any>> {
                                        
        
            print("""
                =======================================================
                                    网络请求
                接口:\(api.baseURL.absoluteString+api.path)
                param:\(api.task.parameters()?.jsonString() ?? "" )
                bodyParam:\(api.task.bodyParameters()?.jsonString() ?? "")
                =======================================================
                """)

            loginSuccessCodeVar = self.LoginSuccessCode()
            reLoginCodeVar = self.reLoginCode()
            let provider = MoyaProvider<Target>()
                                        
            switch api.task {
            case .uploadMultipart, .uploadCompositeMultipart, .uploadFile:
                return provider.rx.requestWithProgress(api, callbackQueue: DispatchQueue.main)
                    .asObservable()
                    .catchError({ (error) -> Observable<ProgressResponse> in
                        
                        if let moyaError = error as? MoyaError,
                            let nsError = moyaError.error as NSError? {
                            
                            let error = apiError(code: nsError.code)
                            return Observable.just(ProgressResponse(progress: nil, response: Response(statusCode: error.code, data: Data())))
                        }
                        return Observable.just(ProgressResponse(progress: nil, response: Response(statusCode: unknownErrorCode, data: Data())))
                    })
                    .map({ (progress) -> Result<Any> in
                        
                        if progress.response?.data.count == 0,
                            progress.response?.request == nil,
                            progress.response?.response == nil {
                            let error = apiError(code: (progress.response?.statusCode)!)
                            print("""
                                -------------------------------------------------------
                                请求异常结果
                                接口:\(progress.response?.request?.url?.absoluteString ?? "")
                                返回:\(error.message)
                                -------------------------------------------------------
                                """)
                            return  .failure(error)
                        }
                        else {
                            return parserProgress(progress)
                        }
                    })
                    .share(replay: 1)
            default:
                return provider.rx.request(api)
                    .asObservable()
                    .catchError({ (error) -> Observable<Response> in

                        if let moyaError = error as? MoyaError,
                            let nsError = moyaError.error as NSError? {
                        
                            let error = apiError(code: nsError.code)
                            return Observable.just(Response(statusCode: error.code, data: Data()))
                        }
                        
                        return Observable.just(Response(statusCode: unknownErrorCode, data: Data()))
                    })
                    .map({ (response) -> Result<Any> in
                        
                        if response.data.count == 0,
                            response.request == nil,
                            response.response == nil {
                            
                            let error = apiError(code: response.statusCode)
                            print("""
                                请求异常结果
                                -------------------------------------------------------
                                接口:\(response.request?.url?.absoluteString ?? "")
                                返回:\(error.message)
                                -------------------------------------------------------
                                """)
                            return  .failure(error)
                        }
                        else {
                            return parser(response)
                        }
                    })
                    .share(replay: 1)
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
        return .URLErrorUnknown(errorCode: unknownErrorCode)
    }
}

public func parserNormal(response: Response) -> Result<Any> {
    
    do {
        let json = try response.mapJSON()
        print("""
            -------------------------------------------------------
            请求结果
            接口:\(response.request?.url?.absoluteString ?? "")
            返回值:\(json)
            -------------------------------------------------------
            """)
        
        if let jsonDatax = json as? Dictionary<String, Any>,
            let jsonData = jsonDatax["results"] as? Dictionary<String, Any> {
            guard let code = jsonData["returncode"] as? Int else {
                fatalError("resultCode不是Int")
            }
            
            let message = jsonData["message"] as? String;
            
            if code == loginSuccessCodeVar {
                let data = jsonDatax["data"]
                return .success(data ?? [:], message)
            }
            else if code == reLoginCodeVar {
                return .failure(.ReLogin(message: message))
            }
            else {
                return .failure(.Service(code: code, message: message))
            }
        }
        return .failure(.URLErrorUnknown(errorCode: unknownErrorCode))
    } catch {
        fatalError("response.mapJSON() exception")
    }
    
}

public func parserProgress(progressResponse: ProgressResponse) -> Result<Any> {
    
    if let _ = progressResponse.progressObject {
        if progressResponse.completed
        {
            do {
                let json = try progressResponse.response?.mapJSON()
                print("""
                    -------------------------------------------------------
                    请求结果
                    接口:\(progressResponse.response?.request?.url?.absoluteString ?? ""))
                    返回值:\(json ?? "")
                    -------------------------------------------------------
                    """)
                
                if let jsonDatax = json as? Dictionary<String, Any>,
                    let jsonData = jsonDatax["results"] as? Dictionary<String, Any>  {
                    guard let code = jsonData["returncode"] as? Int else {
                        fatalError("returncode不是Int")
                    }
                    
                    let message = jsonData["message"] as? String;
                    
                    if code == loginSuccessCodeVar {
                        let data = jsonDatax["data"]
                        return .success(data ?? "Data Is Empty", message)
                    }
                    else if code == reLoginCodeVar {
                        return .failure(ApiError.ReLogin(message: message))
                    }
                    else {
                        return .failure(ApiError.Service(code: code, message: message ?? ""))
                    }
                }
                return .failure(ApiError.URLErrorUnknown(errorCode: unknownErrorCode))
            } catch {
                fatalError("response.mapJSON() exception")
            }
            
            
            
        } else {
            print("""
                -------------------------------------------------------
                请求结果
                上传进度:\(progressResponse.progress)
                -------------------------------------------------------
                """)
            return .success(progressResponse.progress, nil)
        }
    } else {
        return .failure(ApiError.URLErrorUnknown(errorCode: unknownErrorCode))
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
    
    func parameters() -> [String: Any]? {
        switch self {
        case .requestParameters(let parameters, _): return parameters
        case .requestCompositeParameters(_ , _ , let urlParameters): return urlParameters
        case .uploadCompositeMultipart(_ , let urlParameters): return urlParameters
        case .downloadParameters(let parameters, _ , _): return parameters
        default:return nil
        }
    }
    
    func bodyParameters() -> [String: Any]? {
        switch self {
        case .requestCompositeParameters(let bodyParameters, _ , _): return bodyParameters
        default:return nil
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
    
}
