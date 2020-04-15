//
//  UIViewController+Back.swift
//  LifeServiceModule
//
//  Created by frank.he on 2019/12/11.
//

import Foundation

private enum BackType {
    case push, present
}

private typealias FindResult = (success: Bool, targetViewController: UIViewController?, type: BackType?)


extension UIViewController {

    /// 返回指定的页面
    /// - Parameter viewControllers: 指定页面
    /// - Parameter callback: 回调
    public func back(to viewControllers: UIViewController.Type ..., callback: ((UIViewController) -> ())? = nil) {
        back(self, viewControllers, callback)
    }

    private func back(_ containerViewController: UIViewController, _ viewControllers: [AnyClass], _ callback: ((UIViewController) -> ())? = nil) {
            let result = findControllerFor(containerViewController, viewControllers)
        
            let targetViewController = result.targetViewController
            if result.success {
                if result.type == .push {
                    var navigationController: UINavigationController!
                    if let _navigationController = containerViewController.navigationController {
                        navigationController = _navigationController
                    }
                    if containerViewController.isKind(of: UINavigationController.self) {
                        navigationController = containerViewController as? UINavigationController
                    }
                    navigationController.popToViewController(targetViewController!, animated: false)
                    if let callback = callback {
                        callback(targetViewController!)
                    }
                }
                if result.type == .present {
                    containerViewController.dismiss(animated: false) {
                        if let callback = callback {
                            callback(targetViewController!)
                        }
                    }
                }
                
            }
            else {
                if let presentingViewController = targetViewController {
                    containerViewController.dismiss(animated: false) {
                        self.back(presentingViewController, viewControllers, callback)
                    }
                }
                else {
                    if let callback = callback {
                        callback(containerViewController)
                    }
                }
            }
    }
    
    private func findControllerFor(_ containerViewController: UIViewController, _ targetViewControllers: [AnyClass]) -> FindResult {
        
        func findControllerFor(_ navigationController: UINavigationController, _ targetViewControllers: [AnyClass]) -> FindResult {
            let viewControllers = navigationController.viewControllers
            for targetViewController in targetViewControllers {
                for subvc in viewControllers {
                    if subvc.isKind(of: targetViewController) {
                        return (true, subvc, .push)
                    }
                }
            }
            return findPresentingViewControllerFor(containerViewController, targetViewControllers)
        }
        
        if let navigationController = containerViewController.navigationController {
            return findControllerFor(navigationController, targetViewControllers)
        }
        if containerViewController.isKind(of: UINavigationController.self) {
            let navigationController = containerViewController as! UINavigationController
            return findControllerFor(navigationController, targetViewControllers)
        }
        else {
            return findPresentingViewControllerFor(containerViewController, targetViewControllers)
        }
    }
    
    private func findPresentingViewControllerFor(_ containerViewController: UIViewController, _ targetViewControllers: [AnyClass]) -> FindResult {
        if let presentingViewController = containerViewController.presentingViewController {
            for targetViewController in targetViewControllers {
                if containerViewController.isKind(of: targetViewController) {
                    return (true, presentingViewController, .present)
                }
            }
            return (false, presentingViewController, nil)
        }
        else {
            return (false, nil, nil)
        }
    }
    
}
