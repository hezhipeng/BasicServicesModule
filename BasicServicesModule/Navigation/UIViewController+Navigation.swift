//
//  UIViewController+Navigation.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/31.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

extension UIViewController: SelfAware {
    
    static func awake() {
        UIViewController.classInit()
    }
    
    // MARK: - Method Swizzling

    public class func classInit() {
        swizzleMethod
    }
    
    static let swizzleMethod: Void = {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(swizzled_viewWillAppear(_:))
        swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    // MARK: - Swizzled ViewWillAppear

    @objc func swizzled_viewWillAppear(_ animated: Bool) {
        swizzled_viewWillAppear(animated)
        
        self.addNavigationBarLeftSideFunctionButton()
        
        if let navigationController = self.navigationController,
            navigationController.viewControllers.count == 1 {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        }
    }
    
    // MARK: - Public Method
    
    /// 添加导航栏左边UIBarButtonItem
    ///
    /// - Parameter leftBarButtonItem: leftBarButtonItem
    public func addLeftNavigationBarItem(_ leftBarButtonItem: UIBarButtonItem) {
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        
        if #available(iOS 11.0, *) {
            space.width = 8;
        } else {
            space.width = 0;
        }
        self.navigationItem.leftBarButtonItems = [space, leftBarButtonItem];
    }
    
    
    /// 添加导航栏右边UIBarButtonItem
    ///
    /// - Parameter rightButtonItem: rightButtonItem
    public func addRightNavigationBarItem(_ rightButtonItem: UIBarButtonItem) {
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        
        if #available(iOS 11.0, *) {
            space.width = 8;
        } else {
            space.width = 0;
        }
        self.navigationItem.rightBarButtonItems = [space, rightButtonItem];
    }
    
    
    /// image来初始化UIBarButtonItem
    ///
    /// - Parameters:
    ///   - image: icon
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    public func navigationBarItemWithImage(_ image: UIImage, target: Any, action: Selector) -> UIBarButtonItem {
        
        var frame = CGRect.zero;
        frame.size = CGSize(width: image.size.width, height: image.size.height)
        
        var btn: UIButton!;
        if #available(iOS 11.0, *) {
            
            let action = NSStringFromSelector(action)
            if action == "backButtonClicked" || action == "closeButtonClicked" {
                
                frame.size = CGSize(width: 30, height: 30)
                btn = BarItemButton(buttonType: .custom, direction: .left)
            } else {
                btn = BarItemButton(buttonType: .custom, direction: .right)
            }
            
        } else {
            btn = UIButton(type: .custom)
        }
        
        btn.frame = frame;
        btn.backgroundColor = .clear;
        
        btn.setImage(image, for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        let item = UIBarButtonItem(customView: btn)
        return item;
    }
    
    /// 添加关闭button
    public func addCloseButton() {
        let item = self.navigationBarItemWithImage(Resource.imageName("close")!, target: self, action: #selector(UIViewController.closeButtonClicked))
        self.addLeftNavigationBarItem(item)
    }
    
    /// 添加返回button
    public func addBackButton() {
        
        let item = self.navigationBarItemWithImage(Resource.imageName("back")!, target: self, action: #selector(UIViewController.backButtonClicked))
        self.addLeftNavigationBarItem(item)
    }
    
    /// 自动设置导航栏的返回或者关闭按钮
    public func addNavigationBarLeftSideFunctionButton() {
        if self.shouldAddCloceButton() {
            self.addCloseButton()
        }
        else if self.shouldAddBackButton(){
            self.addBackButton()
        } else {
            
        }
    }
    
    /// 是否显示关闭按钮
    ///
    /// - Returns: Bool
    @objc open func shouldAddCloceButton() -> Bool {
        if let _ = self.presentingViewController ,
            let _ = self.navigationController ,
            let count = self.navigationController?.viewControllers.count,
            count <= 1 {
                    return true;
        }
        return false
    }
    
    /// 是否显示返回按钮
    ///
    /// - Returns: Bool
    @objc open  func shouldAddBackButton() -> Bool {
        if let navigationController = self.navigationController,
            navigationController.viewControllers.count  > 1,
            navigationController.topViewController == self {
            return true
        } else {
            return false
        }
    }
    
    /// 返回或者关闭按钮事件，view controller可自己实现该方法
    @objc public func backButtonClicked() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc public func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

class BarItemButton: UIButton {
    
    enum Direction: Int {
        case left
        case right
    }
    
    var direction: Direction = .left
    
    convenience init(buttonType: UIButtonType, direction: Direction) {
        self.init(type: buttonType)
        self.direction = direction
    }
    
    required init(type buttonType: UIButtonType) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if direction == .left {
            self.imageView?.center = CGPoint.init(x: self.imageView!.image!.size.width/2, y: self.center.y)
        } else {
            self.imageView?.center = CGPoint.init(x: self.frame.size.width -  self.imageView!.image!.size.width/2, y: self.center.y)
        }
    }
}
