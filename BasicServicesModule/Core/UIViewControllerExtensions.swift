//
//  UIViewControllerExtensions.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/6/7.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

extension UIViewController {
    
    public func alert( _ message: String, _ buttonTitle: String = "确定") {
        
        let alertControl = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction.init(title: buttonTitle, style: .default, handler: nil)
        alertControl.addAction(confirmAction)
        self.present(alertControl, animated: true, completion: nil)
        
    }
    
    /// 返回指定的页面
    ///
    /// - Parameter viewController: 指定
    public func back(to viewController: UIViewController.Type ...) {
        
        var find = false
        var navigationControllerArray: [UINavigationController?] = []
        var navigationController = self.navigationController
        
        while !find {
            
            let result = findNavigationController(navigationController, viewController)
            
            if result.success {
                navigationController?.popToViewController(result.1!, animated: true)
                
                navigationControllerArray.forEach { (nav) in
                    if nav == navigationControllerArray.last {
                        nav?.dismiss(animated: true, completion: nil)
                    }
                    else {
                        nav?.dismiss(animated: false, completion: nil)
                    }
                }
                
            }
            else {
                if let presentedViewController = result.presentingViewController {
                    
                    navigationControllerArray.append(navigationController)
                    
                    if presentedViewController.isKind(of: UINavigationController.self) {
                        navigationController = presentedViewController as? UINavigationController
                    }
                    else if presentedViewController.isKind(of: UITabBarController.self) {
                        let tabBarController = presentedViewController as! UITabBarController
                        if let selectedViewController = tabBarController.selectedViewController,
                            selectedViewController.isKind(of: UINavigationController.self) {
                            navigationController = selectedViewController as? UINavigationController
                        }
                    }
                    else if presentedViewController.isKind(of: UIViewController.self),
                        let navigationVC = presentedViewController.navigationController,
                        navigationVC.isKind(of: UINavigationController.self) {
                        navigationController = navigationVC
                    }
                    else {
                        // app查询不到返回的UIViewController
                        find = true
                        break
                    }
                }
                else {
                    // app查询不到返回的UIViewController
                    find = true
                    break
                }
            }
            find = result.0
        }
        
    }
    
    private func findNavigationController(_ navigationController: UINavigationController?, _ targetViewControllers: [AnyClass]) -> (success: Bool, presentingViewController: UIViewController?) {
        guard let navigationController = navigationController else { return (false, nil) }
        
        let viewControllers = navigationController.viewControllers
        for targetViewController in targetViewControllers {
            for subvc in viewControllers {
                
                if subvc.isKind(of: targetViewController) {
                    return (true, subvc)
                }
            }
        }
        return (false, navigationController.presentingViewController)
    }
}
