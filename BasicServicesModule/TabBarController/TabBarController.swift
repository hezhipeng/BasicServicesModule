//
//  TabBarController.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/4/30.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class TabBarController: UITabBarController {

    private let viewControllsB: BehaviorRelay<[[String: Any]]> = BehaviorRelay(value: [])
    private var viewControlls: [[String: Any]] = []

    var bag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllsB
//            .throttle(0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](viewControllerInfos) in
                
                let childViewControllers = viewControllerInfos.map{ $0["childViewController"] } as? [UIViewController]
                
                if let childViewControllers = childViewControllers,
                    !childViewControllers.isEmpty {
                    
                    self?.viewControllers = childViewControllers
                    for (index, viewController) in childViewControllers.enumerated() {
                    
                        self?.setTabBarItem(viewController: viewController,
                                            title: viewControllerInfos[index]["title"] as! String,
                                            titleSize: viewControllerInfos[index]["titleSize"] as! Int,
                                            selectedImage: viewControllerInfos[index]["selectedImage"] as! UIImage,
                                            selectedTitleColor: viewControllerInfos[index]["selectedTitleColor"] as! UIColor,
                                            normalImage: viewControllerInfos[index]["normalImage"] as! UIImage,
                                            normalTitleColor: viewControllerInfos[index]["normalTitleColor"] as! UIColor)
                    }
                }
            }).disposed(by: bag)
    }
    
    public func addChildViewController(childViewController: UIViewController,
                                title: String,
                                titleSize: Int = 10,
                                selectedImage: UIImage,
                                selectedTitleColor: UIColor,
                                normalImage: UIImage,
                                normalTitleColor: UIColor) {
        
        let newChild = ["childViewController": childViewController,
                       "title": title,
                       "titleSize": titleSize,
                       "selectedImage": selectedImage,
                       "selectedTitleColor": selectedTitleColor,
                       "normalImage": normalImage,
                       "normalTitleColor": normalTitleColor] as [String : Any]
        
        viewControlls.append(newChild)
        viewControllsB.accept(viewControlls)
    }
    
    private func setTabBarItem(viewController: UIViewController,
                       title: String,
                       titleSize: Int,
                       selectedImage: UIImage,
                       selectedTitleColor: UIColor,
                       normalImage: UIImage,
                       normalTitleColor: UIColor) {
        
        let tabBarItem = UITabBarItem.init(title: title,
                                           image: normalImage.withRenderingMode(.alwaysOriginal),
                                           selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        viewController.tabBarItem = tabBarItem
        
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedStringKey.foregroundColor: normalTitleColor,
                                                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(titleSize))], for: .normal)
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedTitleColor,
                                                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(titleSize))], for: .selected)
       
    }
}
