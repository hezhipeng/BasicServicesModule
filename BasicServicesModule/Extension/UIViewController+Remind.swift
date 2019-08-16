//
//  UIViewController+Remind.swift
//  OPWorker
//
//  Created by frank.he on 2019/8/5.
//  Copyright © 2019 e城e家科技有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func removeRemind() {
        let sub = view.subviews.first { (sub) -> Bool in
            return sub.tag == 9001
        }
        if let sub = sub {
            sub.removeFromSuperview()
        }
    }
    
    public func addRemind(_ image: UIImage, _ text: String, _ offsetY: CGFloat = 0) {
        removeRemind()
        
        let container = UIView()
        container.tag = 9001
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = image
        container.addSubview(imgView)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.text = text
        container.addSubview(label)
        
        view.addSubview(container)
        let yCenter = container.centerYAnchor.constraint(
            equalTo: view.centerYAnchor, constant: offsetY)
        let xCenter = container.centerXAnchor.constraint(
            equalTo: view.centerXAnchor, constant: 0)
        let width = container.widthAnchor.constraint(
            equalToConstant: image.size.width)
        let height = container.heightAnchor.constraint(
            equalToConstant: image.size.height + 50)
        NSLayoutConstraint.activate([yCenter, xCenter, width, height])
        
        let itop = imgView.topAnchor.constraint(
            equalTo: container.topAnchor, constant: 0)
        let ixCenter = imgView.centerXAnchor.constraint(
            equalTo: container.centerXAnchor, constant: 0)
        let iwidth = imgView.widthAnchor.constraint(
            equalToConstant: image.size.width)
        let iheight = imgView.heightAnchor.constraint(
            equalToConstant: image.size.height)
        NSLayoutConstraint.activate([itop, ixCenter, iwidth, iheight])
        
        let ltop = label.topAnchor.constraint(
            equalTo: imgView.bottomAnchor, constant: 20)
        let lxCenter = label.centerXAnchor.constraint(
            equalTo: container.centerXAnchor, constant: 0)
        //        let lbottom = label.bottomAnchor.constraint(
        //            equalTo: container.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([ltop, lxCenter])
    }
}

