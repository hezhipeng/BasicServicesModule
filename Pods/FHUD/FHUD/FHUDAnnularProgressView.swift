//
//  FHUDAnnularProgressView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/14.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDAnnularProgressView: UIView {
    
    public var progress = 0.0 {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let lineWidth = 2.0
        let center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.maxX/2 - CGFloat(lineWidth/2)
        let startAngle = -(Double.pi / 2); // 90
        let endAngle = (2 * Double.pi) + startAngle;
        
        let processBackgroundPath = UIBezierPath()
        processBackgroundPath.lineWidth = CGFloat(lineWidth)
        processBackgroundPath.lineCapStyle = .butt
        processBackgroundPath.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        progressTintColor?.withAlphaComponent(0.2).set()
        processBackgroundPath.stroke()
        
        let processPath = UIBezierPath()
        processPath.lineWidth = CGFloat(lineWidth)
        
        progressTintColor?.setFill()
        let endAngleProgress = progress * 2 * Double.pi + startAngle
        processPath.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngleProgress), clockwise: true)
        progressTintColor?.set()
        processPath.stroke()
    }
    
    public var progressTintColor: UIColor? {
        didSet {
            if let _ = progressTintColor {
                self.setNeedsDisplay()
            }
        }
    }
}
