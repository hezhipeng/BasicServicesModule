//
//  FHUDIndicatorView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/11.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDIndicatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        activityIndicatorView.stopAnimating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    deinit {
//        print(#file+" "+#function)
    }
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.hidesWhenStopped = true
        return activity
    }()
}
