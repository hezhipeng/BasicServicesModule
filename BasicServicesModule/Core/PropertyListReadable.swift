//
//  PropertyListReadable.swift
//  ECEJCityModule
//
//  Created by Frank.he on 2018/5/22.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

/**
 *
 *  Struct实现本地归档，实现Protocal
 *  借用：http://redqueencoder.com/property-lists-and-user-defaults-in-swift/
 */

public protocol PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation:NSDictionary?)
}
