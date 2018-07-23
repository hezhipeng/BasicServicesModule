//
//  SelfAware.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

public protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {
    
    static func harmlessFunction() {
    
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            if let viewController = types[index] as? SelfAware.Type {
                let viewControllerName = NSStringFromClass(viewController)
                    
                // 区分swift和object-c，包含"."表示swift，因为swift有名字空间
                if viewControllerName.contains(".") {
                    viewController.awake()
                }
            }
        }
        types.deallocate()
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

