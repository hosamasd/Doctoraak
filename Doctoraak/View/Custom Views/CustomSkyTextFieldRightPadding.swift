//
//  CustomSkyTextFieldRightPadding.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CustomSkyTextFieldRightPadding: SkyFloatingLabelTextField {
    
    
    
    let padding:CGFloat
    let height:CGFloat
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = CGRect(
            x: padding,
            y: titleHeight(),
            width: bounds.size.width - padding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        
        return rect
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = CGRect(
            x: padding,
            y: titleHeight(),
            width: bounds.size.width - padding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        
        return rect
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = CGRect(
            x: padding,
            y: titleHeight(),
            width: bounds.size.width - padding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        
        return rect
        
    }
    
    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        
        if editing {
            return CGRect(x: padding, y: 5, width: bounds.size.width, height: titleHeight())
        }
        
        return CGRect(x: padding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    
    
  
    
    init(padding:CGFloat,height:CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        self.layer.cornerRadius = height / 2
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 0, height: height)
//
//    }
}
