//
//  UITableViewCell+Corners.swift
//  ECEJ
//
//  Created by frank.he on 2019/4/29.
//  Copyright © 2019 e城e家科技有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    
    /// 给UITableView的section，增加圆角
    ///
    /// - Parameters:
    ///   - cornerRadius: 角半径
    ///   - indexPath: IndexPath
    ///   - tableView: UITableView
    public func add(cornerRadius: CGFloat, indexPath: IndexPath, tableView: UITableView) {
        //圆角半径
        let cornerRadius: CGFloat = cornerRadius
        
        //下面为设置圆角操作（通过遮罩实现）
        let sectionCount = tableView.numberOfRows(inSection: indexPath.section)
        let shapeLayer = CAShapeLayer()
        self.layer.mask = nil
        
        //当前分区有多行数据时
        if sectionCount > 1 {
            switch indexPath.row {
            //如果是第一行,左上、右上角为圆角
            case 0:
                var bounds = self.bounds
                bounds.origin.y += 1.0  //这样每一组首行顶部分割线不显示
                let bezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: [.topLeft,.topRight],
                                              cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                self.layer.mask = shapeLayer
            //如果是最后一行,左下、右下角为圆角
            case sectionCount - 1:
                var bounds = self.bounds
                bounds.size.height -= 1.0  //这样每一组尾行底部分割线不显示
                let bezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: [.bottomLeft,.bottomRight],
                                              cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                self.layer.mask = shapeLayer
            default:
                break
            }
        }
            //当前分区只有一行行数据时
        else {
            //四个角都为圆角（同样设置偏移隐藏首、尾分隔线）
            let bezierPath = UIBezierPath(roundedRect:
                self.bounds.insetBy(dx: 0.0, dy: 0.0),
                                          cornerRadius: cornerRadius)
            shapeLayer.path = bezierPath.cgPath
            self.layer.mask = shapeLayer
        }
    }
}
