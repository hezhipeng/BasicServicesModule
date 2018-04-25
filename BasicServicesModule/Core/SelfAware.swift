//
//  SelfAware.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

//protocol SelfAware: class {
//    static func awake()
//}

class NothingToSeeHere {
    
    static func harmlessFunction() {
        
    
    }
}

extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}
