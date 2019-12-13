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
}
