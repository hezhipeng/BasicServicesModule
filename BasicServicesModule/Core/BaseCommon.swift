//
//  BaseCommon.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/5/25.
//

import Foundation

public func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
        return topViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
        return topViewController(base: tab.selectedViewController)
    }
    if let presented = base?.presentedViewController {
        return topViewController(base: presented)
    }
    return base
}
