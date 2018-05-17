//
//  FBackgroundView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/7.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDBackgroundView: UIView {

    let color: UIColor = UIColor(white: 1, alpha: 0.1)
    var mode: HUDBackgroundMode = .solidColor {
        didSet {
            updateBackground()
        }
    }
    
    private var blurView: UIVisualEffectView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        updateBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView?.frame = self.bounds
    }
    
    private func updateBackground() {
        if mode == .blur {
            let blur = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView.init(effect: blur)
            
            self.blurView = blurView
            self.addSubview(self.blurView!)
        }
        else {
            self.backgroundColor = self.color;
            
            if let blurView = blurView,
                let _ = blurView.superview {
                blurView.removeFromSuperview()
            }
        }
    }
}
