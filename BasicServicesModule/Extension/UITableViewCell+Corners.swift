//
//  UITableViewCell+Corners.swift
//  ECEJ
//
//  Created by frank.he on 2019/4/29.
//  Copyright © 2019 e城e家科技有限公司. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    
    /// 给UITableView的section，增加圆角
    ///
    /// - Parameters:
    ///   - cornerRadius: 角半径
    ///   - indexPath: IndexPath
    ///   - tableView: UITableView
    ///   - borderWidht: borderWidht 默认没有
    ///   - borderColor: borderColor 默认没有
    @objc func add(cornerRadius: CGFloat, indexPath: IndexPath, tableView: UITableView, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        //圆角半径
        let cornerRadius: CGFloat = cornerRadius
        
        //下面为设置圆角操作（通过遮罩实现）
        let sectionCount = tableView.numberOfRows(inSection: indexPath.section)
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.mask = nil
        
        var bPath = UIBezierPath()
        let ptTopLeft  = CGPoint(x: 0.0, y: 0.0)
        let ptTopRight = CGPoint(x: bounds.width, y: 0.0)
        let ptBotRight = CGPoint(x: bounds.width, y: bounds.height)
        let ptBotLeft  = CGPoint(x: 0.0, y: bounds.height)
        
        //当前分区有多行数据时
        if sectionCount > 1 {
            switch indexPath.row {
            //如果是第一行,左上、右上角为圆角
            case 0:
                //                var bounds = self.bounds
                //                bounds.origin.y += 1.0  //这样每一组首行顶部分割线不显示
                let bezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: [.topLeft,.topRight],
                                              cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                
                if borderWidth > 0 {
                    bPath.move(to: ptBotLeft)
                    bPath.addLine(to: CGPoint(x: ptTopLeft.x, y: ptTopLeft.y + cornerRadius))
                    
                    bPath.addArc(withCenter: CGPoint(x: ptTopLeft.x + cornerRadius, y: ptTopLeft.y + cornerRadius), radius: cornerRadius, startAngle: .pi, endAngle: .pi * 1.5, clockwise: true)
                    
                    bPath.addLine(to: CGPoint(x: ptTopRight.x - cornerRadius, y: ptTopRight.y))
                    
                    bPath.addArc(withCenter: CGPoint(x: ptTopRight.x - cornerRadius, y: ptTopRight.y + cornerRadius), radius: cornerRadius, startAngle: .pi * 1.5, endAngle: 0, clockwise: true)
                    
                    bPath.addLine(to: CGPoint(x: ptBotRight.x, y: ptBotRight.y))
                }
                
            //如果是最后一行,左下、右下角为圆角
            case sectionCount - 1:
                //                var bounds = self.bounds
                //                bounds.size.height -= 1.0  //这样每一组尾行底部分割线不显示
                let bezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: [.bottomLeft,.bottomRight],
                                              cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                
                if borderWidth > 0 {
                    bPath = bezierPath
                }
            default:
                let bounds = self.bounds
                //                bounds.size.height -= 1.0  //这样每一组尾行底部分割线不显示
                let bezierPath = UIBezierPath.init(rect: bounds)
                shapeLayer.path = bezierPath.cgPath
                
                if borderWidth > 0 {
                    bPath.move(to: ptBotLeft)
                    bPath.addLine(to: ptTopLeft)
                    bPath.addLine(to: ptTopRight)
                    bPath.addLine(to: ptBotRight)
                }
            }
        }
            //当前分区只有一行行数据时
        else {
            //四个角都为圆角（同样设置偏移隐藏首、尾分隔线）
            let bezierPath = UIBezierPath(roundedRect:
                self.bounds.insetBy(dx: 0.0, dy: 0.0),
                                          cornerRadius: cornerRadius)
            shapeLayer.path = bezierPath.cgPath
            
            if borderWidth > 0 {
                bPath = bezierPath
            }
        }
        
        self.layer.mask = shapeLayer
        
        if borderWidth > 0 {
            if borderLayer == nil {
                let layer = CAShapeLayer()
                borderLayer = layer
                borderLayer?.fillColor = UIColor.clear.cgColor
                borderLayer?.lineWidth = borderWidth
                borderLayer?.strokeColor = borderColor.cgColor
                self.layer.addSublayer(borderLayer!)
            }
            borderLayer?.path = bPath.cgPath
        }
        else {
            if let lay = borderLayer {
                if let _ = lay.superlayer {
                    lay.removeFromSuperlayer()
                }
                borderLayer = nil
            }
            
        }
    }
    
    var borderLayer: CAShapeLayer? {
        get {
            if let associated = objc_getAssociatedObject(self, &borderLayerKey)
                as? CAShapeLayer {
                return associated
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &borderLayerKey, newValue,
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
private var borderLayerKey: UInt8 = 23


