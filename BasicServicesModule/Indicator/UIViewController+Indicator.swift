//
//  UIViewController+Indicator.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/3/31.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation
import FHUD

extension UIViewController {
    
    @objc public func showLoading() {
        
        FHUD.hide(onView: self.view, animated: false)
        
        let _ = FHUD.show(.progress(mode: .default, title: nil), onView: self.view, animated: true)
    }
    
    @objc public func hideLoading() {
        FHUD.hide(onView: self.view, animated: true)
    }
    
    @objc public func promptMessage(_ message: String?) {
        
        FHUD.hide(onView: self.view, animated: false)
        
        if let msg = message,
            msg.count > 0 {
            let hud = FHUD.show(.prompt(title: msg), onView: self.view, animated: true)
            DispatchQueue.global(qos: .userInitiated).async {
                sleep(3)
                DispatchQueue.main.async {
                    hud.hide()
                }
            }
        }
    }
}
