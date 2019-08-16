//
//  NSAttributedString+Height.swift
//  OnSiteServiceModule
//
//  Created by frank.he on 2019/5/28.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    public func stringHeight(width: Int, font: UIFont, lineSpacing: Int) -> CGFloat {

        let contentSize = self.boundingRect(with: CGSize.init(width: CGFloat(width), height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
//        print(font.lineHeight, font.pointSize)
        
        let c = Int(contentSize.size.height - font.lineHeight)
        if c <= lineSpacing && c > 0 {
            //  attr = attr?.withBaselineOffset(-1)
            self.removeAttribute(NSAttributedString.Key.paragraphStyle, range: NSRange.init(location: 0, length: self.string.count))
            return font.lineHeight
        }
        else {
            return contentSize.size.height + 1
        }
    }
    
}
