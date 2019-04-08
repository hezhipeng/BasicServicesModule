//
//  UIView+Indicator.swift
//  Alamofire
//
//  Created by frank.he on 2019/4/8.
//

import Foundation

import Foundation
import FHUD

extension UIView {
    
    @objc public func showLoading() {
        DispatchQueue.main.async {
            FHUD.hide(onView: self, animated: false)
            let _ = FHUD.show(.progress(mode: .default, title: nil), onView: self, animated: true)
        }
    }
    
    @objc public func hideLoading() {
        FHUD.hide(onView: self, animated: true)
    }
    
    @objc public func promptMessage(_ message: String?) {
        
        FHUD.hide(onView: self, animated: false)
        
        if let msg = message,
            msg.count > 0 {
            let hud = FHUD.show(.prompt(title: msg), onView: self, animated: true)
            DispatchQueue.global(qos: .userInitiated).async {
                sleep(3)
                DispatchQueue.main.async {
                    hud.hide()
                }
            }
        }
    }
}
