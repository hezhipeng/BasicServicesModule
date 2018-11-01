//
//  TabBarController.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/4/30.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

public class TabBarController: UITabBarController {
    
    struct TabBarInfoModel {
        let viewController: UIViewController
        let title: String
        let titleSize: Int
        let selectedImage: UIImage
        let selectedTitleColor: UIColor
        let normalImage: UIImage
        let normalTitleColor: UIColor
    }
    
    private var tabBarInfos: [TabBarInfoModel]? = [] {
        didSet {
            if let tabBarInfos = tabBarInfos {
                
                let childViewControllers = tabBarInfos.map{ $0.viewController }
                self.viewControllers = childViewControllers
                
                for model in tabBarInfos {
                    self.setTabBarItem(viewController: model.viewController,
                                       title: model.title,
                                       titleSize: model.titleSize,
                                       selectedImage: model.selectedImage,
                                       selectedTitleColor: model.selectedTitleColor,
                                       normalImage: model.normalImage,
                                       normalTitleColor: model.normalTitleColor)
                }
            }
            else {
                self.viewControllers = nil
            }
            
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func addChildViewController(childViewController: UIViewController,
                                       title: String,
                                       titleSize: Int = 10,
                                       selectedImage: UIImage,
                                       selectedTitleColor: UIColor,
                                       normalImage: UIImage,
                                       normalTitleColor: UIColor) {
        let model = TabBarInfoModel.init(viewController: childViewController,
                                         title: title,
                                         titleSize: titleSize,
                                         selectedImage: selectedImage,
                                         selectedTitleColor: selectedTitleColor,
                                         normalImage: normalImage,
                                         normalTitleColor: normalTitleColor)
        tabBarInfos?.append(model)
    }
    
    private func setTabBarItem(viewController: UIViewController,
                               title: String,
                               titleSize: Int,
                               selectedImage: UIImage,
                               selectedTitleColor: UIColor,
                               normalImage: UIImage,
                               normalTitleColor: UIColor) {
        
        let tabBarItem = UITabBarItem(title: title,
                                      image: normalImage.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        viewController.tabBarItem = tabBarItem
        
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: normalTitleColor,
                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(titleSize))], for: .normal)
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedTitleColor,
                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(titleSize))], for: .selected)
    }
}
