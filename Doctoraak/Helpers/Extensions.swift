//
//  Extensions.swift
//  Doctoraak
//
//  Created by hosam on 3/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

 extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func createMainTextFields(place:String,type:UIKeyboardType? = .emailAddress,secre:Bool? = false) -> UITextField {
        let t = CustomSkyTextFieldRightPadding(padding: 16, height: 50)
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.placeholder = place
        t.keyboardType = type ?? .emailAddress
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        t.leftViewMode = .always
        t.isSecureTextEntry = secre ?? false
        return t
    }
    
  
    
}

extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFill
    }
    
    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 40)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
        func underline() {
            guard let text = self.titleLabel?.text else { return }
            let attributedString = NSMutableAttributedString(string: text)
            //NSAttributedStringKey.foregroundColor : UIColor.blue
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    
    
}
    
    extension UILabel {
        func underline() {
            if let textString = self.text {
                let attributedString = NSMutableAttributedString(string: textString)
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
                attributedText = attributedString
            }
        }
    }


