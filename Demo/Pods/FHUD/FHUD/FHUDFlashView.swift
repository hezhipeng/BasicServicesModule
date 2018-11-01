//
//  FHUDFlashView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/9.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

class FHUDFlashView: FHUDBackgroundView {
    
    private var image: UIImage!
    private var title: String?

    convenience init(_ frame: CGRect, _ image: UIImage, _ title: String? = nil) {
        self.init(frame: frame)
        self.image = image
        self.title = title
        commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.mode = .blur
        self.layer.cornerRadius = 5.0;
        
        self.imageView.image = image
        self.titleLabel.text = title
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        if let superview = self.superview {
            
            let viewWidth = superview.frame.size.width
            let viewHeight = superview.frame.size.height
            
            let x = viewWidth / 2.0
            let y = viewHeight / 2.0
            
            self.center = CGPoint.init(x: x, y: y)
            
            let center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
            if let _ = title {
                self.imageView.bounds = CGRect(x: 0, y: 0, width: imageSize?.width ?? 0, height: imageSize?.height ?? 0)
                self.imageView.center = CGPoint(x: center.x, y: 45)
                
                self.titleLabel.bounds = CGRect(x: 0, y: 0, width: self.bounds.maxX, height: 20)
                self.titleLabel.center = CGPoint(x: center.x, y: self.bounds.maxY - 20)
            }
            else {
                self.imageView.bounds = CGRect(x: 0, y: 0, width: imageSize?.width ?? 0, height: imageSize?.height ?? 0)
                self.imageView.center = center
            }
        }
        super.layoutSubviews()
    }
    
    // MARK: - get and set
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        return label
    }()
    
    public var titleColor: UIColor? {
        didSet {
            if let titleColor = titleColor {
                self.titleLabel.textColor = titleColor
            }
        }
    }
    
    public var titleFont: UIFont? {
        didSet {
            if let titleFont = titleFont {
                self.titleLabel.font = titleFont
            }
        }
    }
    
    public var contextViewBackgroundColor: UIColor? {
        didSet {
            if let contextViewBackgroundColor = contextViewBackgroundColor {
                self.backgroundColor = contextViewBackgroundColor
            }
        }
    }
    
    public var imageSize: CGSize? {
        didSet {
            if let _ = imageSize {
                self.setNeedsDisplay()
            }
        }
    }
}
