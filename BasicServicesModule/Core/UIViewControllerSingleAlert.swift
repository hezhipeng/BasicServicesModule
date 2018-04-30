//
//  UIViewControllerSingleAlert.swift
//  Alamofire
//
//  Created by Frank.he on 2018/4/26.
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
