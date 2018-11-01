//
//  FHUDPromptView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/9.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

class FHUDPromptView: FHUDBackgroundView {
    
    
    private var title: String!
    
    convenience init(_ title: String) {
        self.init(frame: CGRect.zero)
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
        
        self.titleLabel.text = title
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        if let superview = self.superview {
            
            let viewWidth = superview.frame.size.width
            let viewHeight = superview.frame.size.height
            
            let x = viewWidth / 2.0
            
            let contentSize = titleLabel.sizeThatFits(CGSize(width: viewWidth - 80, height: CGFloat(HUGE)))
            let contentBounds = CGRect.init(origin: CGPoint.zero, size: contentSize)
            
            var bounds = contentBounds
            bounds.size.width += 20
            bounds.size.height += 20
            self.bounds = bounds
            
            let origin = CGPoint.init(x: x, y: viewHeight - bounds.midY)
            self.center = origin
            
            var safeBottom: CGFloat = 0
            if #available(iOS 11.0, *) {
                safeBottom = safeAreaInsets.bottom
            } else {
                
            }
            
            let xOffset = offset?.x ?? 0
            let yOffset = offset?.y ?? 0
            self.center = CGPoint.init(x: origin.x + xOffset, y: origin.y - yOffset - safeBottom)
            
            
            self.titleLabel.bounds = contentBounds
            self.titleLabel.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        }
        super.layoutSubviews()
    }
    
    // MARK: - get and set
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
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
    
    public var offset: CGPoint? {
        didSet {
            if let _ = offset {
                self.setNeedsDisplay()
            }
        }
    }
}
