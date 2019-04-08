//
//  FHUDGradientRotationView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/14.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDGradientRotationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(topGradientLayer)
        self.layer.addSublayer(bottomGradientLayer)

        self.layer.mask = maskLayer
        DispatchQueue.main.async {
            self.rotationAnimation()
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
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.maxX, height: self.bounds.midY)
        bottomGradientLayer.frame = CGRect(x: 0, y: self.bounds.midY, width: self.bounds.maxX, height: self.bounds.midY)

        maskLayer.path = path().cgPath
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        self.layer.removeAllAnimations()
    }
    
    override var tintColor: UIColor? {
        didSet {
            if let tintColor = tintColor {
                let topColors = [tintColor.cgColor, tintColor.withAlphaComponent(0.5).cgColor]
                let bottomColors = [tintColor.withAlphaComponent(0.5).cgColor,tintColor.withAlphaComponent(0.0).cgColor]

                topGradientLayer.colors = topColors
                bottomGradientLayer.colors = bottomColors
            }
        }
    }
    
    private func path() -> UIBezierPath {
        
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.maxY / 2.0 - 3
        let start = -1/4*CGFloat(2.0 * Double.pi)
        let end = CGFloat(2.0 * Double.pi)
        
        return UIBezierPath.init(arcCenter: center,
                                 radius: radius,
                                 startAngle: start,
                                 endAngle: end,
                                 clockwise: true)
    }
    
    func rotationAnimation() {
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2.0 * Double.pi
        rotationAnimation.duration = 1
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        rotationAnimation.repeatCount = HUGE
        self.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    lazy var topGradientLayer: CAGradientLayer = {
        
        let colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.5).cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.shadowPath = path().cgPath
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.colors = colors
        return gradientLayer
    }()
    
    lazy var bottomGradientLayer: CAGradientLayer = {
        
        let colors = [UIColor.white.withAlphaComponent(0.5).cgColor, UIColor.white.withAlphaComponent(0.0).cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.shadowPath = path().cgPath
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = colors
        return gradientLayer
    }()
    
    
    lazy var maskLayer: CAShapeLayer = {
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 3;
        layer.strokeStart = 0;
        layer.strokeEnd = 1;
        layer.lineCap = CAShapeLayerLineCap.round;
        layer.lineDashPhase = 0.8;
        return layer
    }()
    
}
