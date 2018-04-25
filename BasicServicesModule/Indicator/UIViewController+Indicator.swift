//
//  UIViewController+Indicator.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/31.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation
import PKHUD

extension UIViewController {
    
    public func showLoading() {
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        HUD.show(.systemActivity, onView: self.view)
    }
    
    public func hideLoading() {
        HUD.hide()
    }
    
    public func promptMessage(_ message: String?) {
        
        if let msg = message,
            msg.count > 0 {
            
            HUD.dimsBackground = false
            HUD.allowsInteraction = true
            HUD.flash(.label(msg), delay: 2)
        }
    }
}
