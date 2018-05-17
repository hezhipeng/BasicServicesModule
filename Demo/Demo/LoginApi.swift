//
//  LoginApi.swift
//  ECEJLoginModule
//
//  Created by Frank.he on 2018/4/23.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation
import Moya

public enum LoginApi {
    
    /// 1、登录
    case login(Dictionary<String, Any>)
}

extension LoginApi: TargetType {
    public var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        return URL(string: "http://xapi.ecej.com")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/v3/member/login"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        
        switch self {
        case .login(let params):
            
//            let param = ["image": "home_tab_bar_home"]
//            let multipartFormData = param.flatMap({ (arg) -> [MultipartFormData] in
//
//                let (key, name) = arg
//                let image = UIImage(named: name)
//
//                if let image = image,
//                    let data = UIImageJPEGRepresentation(image, 0.3) {
//                    return [MultipartFormData(provider: .data(data),
//                                              name: key, fileName: (path as AnyObject).lastPathComponent,
//                                              mimeType: "image/jpeg")]
//                }
//                return []
//            })
//
//                    return .uploadCompositeMultipart(multipartFormData, urlParameters: params)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
