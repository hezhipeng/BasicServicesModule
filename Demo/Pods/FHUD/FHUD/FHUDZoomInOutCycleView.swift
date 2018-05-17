//
//  FHUDZoomInOutCycleView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/11.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDZoomInOutCycleView: UIView {

    private var index = 0
    private var isAnimation = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(zoomInOutCycleLayer)
        
        DispatchQueue.main.async {
            self.statrAnimation()
        }
    }
    
    deinit {
//        print(#file+" "+#function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        zoomInOutCycleLayer.path = self.path(index: index).cgPath
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        isAnimation = false
        zoomInOutCycleLayer.removeAllAnimations()
    }
    
    override var tintColor: UIColor? {
        didSet {
            if let tintColor = tintColor {
                self.zoomInOutCycleLayer.strokeColor = tintColor.cgColor
            }
        }
    }
    
    private func path(index: Int) -> UIBezierPath {
        
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.maxY / 2.0
        let start = -1/4*CGFloat(2.0 * Double.pi) + CGFloat(Double(index) * (Double.pi * 2)/4)
        let end = CGFloat(2.0 * Double.pi) + CGFloat(Double(index) * (Double.pi * 2)/4)
        
        return UIBezierPath.init(arcCenter: center,
                                 radius: radius,
                                 startAngle: start,
                                 endAngle: end,
                                 clockwise: true)
    }
    
    func statrAnimation() {
        zoomInOutCycleLayer.removeAllAnimations()
        
        // 消失
        let strokeStart = CABasicAnimation.init(keyPath: "strokeStart")
        strokeStart.fromValue = 0
        strokeStart.toValue = 1
        strokeStart.duration = 2
        strokeStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // 显示
        let strokeEnd = CABasicAnimation.init(keyPath: "strokeEnd")
        strokeEnd.fromValue = 0
        strokeEnd.toValue = 1
        strokeEnd.duration = 1
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let groud = CAAnimationGroup()
        groud.repeatCount = 0
        groud.animations = [strokeStart, strokeEnd]
        groud.duration = 2
        groud.delegate = self
        groud.isRemovedOnCompletion = true
        
        zoomInOutCycleLayer.add(groud, forKey: "groud")
    }

    lazy var zoomInOutCycleLayer: CAShapeLayer = {
        let loading = CAShapeLayer()
        loading.lineWidth = 3
        loading.strokeColor = self.tintColor?.cgColor
        loading.fillColor = UIColor.clear.cgColor
        loading.strokeStart = 1
        loading.lineCap = kCALineCapRound
        return loading
    }()
}

extension FHUDZoomInOutCycleView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        index += 1
        zoomInOutCycleLayer.path = self.path(index: index).cgPath
        if isAnimation {
            self.statrAnimation()
        }
    }
}
