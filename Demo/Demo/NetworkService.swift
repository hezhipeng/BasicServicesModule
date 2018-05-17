//
//  NetworkService.swift
//  ECEJLoginModule
//
//  Created by Frank.he on 2018/4/23.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import BasicServicesModule
import SwifterSwift

struct NetworkService: HttpService {
    
    public static let shared = NetworkService()
    
    /// 登录接口
    ///
    /// - Parameters:
    ///   - mobileNo: 手机号
    ///   - password: 密码
    ///   - verifyCode: 验证码(登录验证时使用)
    /// - Returns:
    func login(mobileNo: String, password: String, verifyCode: String = "") -> Observable<Result<Any>>  {
  
        let params: [String: Any] = ["mobileNo": mobileNo,
                                 "password": password,
                                 "verifyCode": verifyCode
                                 ]

        return self.networkServer(api: LoginApi.login(params), parser: parserNormal)
    }
    
}



public func parserNormal(response: Response) -> (code: Int?, data: Any?, messsage: String?) {
    
    do {
        let json = try response.mapJSON()
        
        if let jsonDatax = json as? Dictionary<String, Any>,
            let jsonData = jsonDatax["results"] as? Dictionary<String, Any> {
            guard let code = jsonData["returncode"] as? Int else {
                fatalError("resultCode不是Int")
            }
            
            let data = jsonDatax["data"]
            let message = jsonData["message"] as? String;
            
            return (code, data, message)
        }
        return (nil, nil, nil)
    } catch {
        fatalError("response.mapJSON() exception")
    }
    
}

