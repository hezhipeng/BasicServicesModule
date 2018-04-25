//
//  Resource.swift
//  ECEJLoginModule
//
//  Created by Frank.he on 2018/4/9.
//

import Foundation
import UIKit

class Resource: NSObject {
    
    static func bundle() -> Bundle {
        let bundle = Bundle(for: self.classForCoder())
//        let bundleURL = bundle.url(forResource: "LoginModule", withExtension: "bundle")
        return bundle
    }
    
    static func imageName(_ name: String) -> UIImage? {
        let path = self.bundle().path(forResource: "BasicServices", ofType: "bundle")!
        let bundle = Bundle(path: path)
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image
    }
}
