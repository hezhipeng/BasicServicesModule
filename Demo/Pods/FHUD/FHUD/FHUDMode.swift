//
//  FHUDMode.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/7.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

public enum FHUDMode {
    case progress(mode: HUDProgressMode, title: String?)
    case prompt(title: String)
    case flash(image: UIImage, title: String?)
}

public enum HUDProgressMode {
    case `default`
    case zoomInOutCycle
    case gradientRotation
    case round
    case annular
}

public enum HUDBackgroundMode {
    case solidColor
    case blur
}


