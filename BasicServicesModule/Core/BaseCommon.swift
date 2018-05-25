//
//  BaseCommon.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/5/25.
//

import Foundation

public func visibleViewController(_ rootViewController: UIViewController) -> UIViewController {
    if let viewController = rootViewController.presentedViewController {
        return visibleViewController(viewController)
    }
    else {
        if rootViewController.isKind(of: UINavigationController.self) {
            if let viewController =  (rootViewController as? UINavigationController)?.visibleViewController {
                return viewController
            }
            else {
                return rootViewController
            }
        }
        else {
            return rootViewController
        }
    }
}
