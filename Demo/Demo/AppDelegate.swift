//
//  AppDelegate.swift
//  Demo
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
@_exported import BasicServicesModule

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.globalCustomBar(backgroundColor: .blue, titleTextAttributes: [NSAttributedStringKey.foregroundColor: UIColor.red,
                                                                                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        let tabbar = TabBarController()
        
        let viewController1 = ViewController1()
        viewController1.view.backgroundColor = UIColor.white
        let viewController2 = ViewController2()
        viewController2.view.backgroundColor = UIColor.lightGray
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = UIColor.red

        tabbar.addChildViewController(childViewController: viewController1,
                                      title: "首页",
                                      selectedImage: UIImage(named: "home_tab_bar_home_selected")!,
                                      selectedTitleColor: UIColor.red,
                                      normalImage: UIImage(named: "home_tab_bar_home")!,
                                      normalTitleColor: UIColor.black)
        
        tabbar.addChildViewController(childViewController: viewController2,
                                      title: "订单",
                                      selectedImage: UIImage(named: "home_tab_bar_order_selected")!,
                                      selectedTitleColor: UIColor.red,
                                      normalImage: UIImage(named: "home_tab_bar_order")!,
                                      normalTitleColor: UIColor.black)
        
        tabbar.addChildViewController(childViewController: viewController3,
                                      title: "我的",
                                      selectedImage: UIImage(named: "home_tab_bar_mine_selected")!,
                                      selectedTitleColor: UIColor.red,
                                      normalImage: UIImage(named: "home_tab_bar_mine")!,
                                      normalTitleColor: UIColor.black)
        
        self.window?.rootViewController = tabbar
        return true
    }
    
    func updateTabbar() {
        let tabbar = TabBarController()
        
        let viewController1 = ViewController1()
        viewController1.view.backgroundColor = UIColor.white
        let viewController2 = ViewController2()
        viewController2.view.backgroundColor = UIColor.lightGray
        
        tabbar.addChildViewController(childViewController: viewController1,
                                      title: "首页",
                                      selectedImage: UIImage(named: "home_tab_bar_home_selected")!,
                                      selectedTitleColor: UIColor.red,
                                      normalImage: UIImage(named: "home_tab_bar_home")!,
                                      normalTitleColor: UIColor.black)
        
        tabbar.addChildViewController(childViewController: viewController2,
                                      title: "订单",
                                      selectedImage: UIImage(named: "home_tab_bar_order_selected")!,
                                      selectedTitleColor: UIColor.red,
                                      normalImage: UIImage(named: "home_tab_bar_order")!,
                                      normalTitleColor: UIColor.black)
        
        self.window?.rootViewController = tabbar
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

