//
//  UINavigationBarAppearance.swift
//  BasicServicesModule
//
//  Created by Frank.he on 2018/4/30.
//

import Foundation
import SwifterSwift

extension UINavigationBar {
    
    class public func globalCustomBar(backgroundColor: UIColor = .white, titleTextAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.foregroundColor: UIColor(hexString: "222222")!,
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]) {
        
        UINavigationBar.appearance().tintColor = backgroundColor
        UINavigationBar.appearance().setBackgroundImage(UIImage(color: backgroundColor, size: CGSize(width: 1, height: 1)), for: .default)
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
    }
    
    public func customBar(backgroundColor: UIColor = .white, titleTextAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.foregroundColor: UIColor(hexString: "222222")!,
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]) {
        
        self.tintColor = backgroundColor
        self.setBackgroundImage(UIImage(color: backgroundColor, size: CGSize(width: 1, height: 1)), for: .default)
        self.titleTextAttributes = titleTextAttributes
    }
}
