//
//  Extensions.swift
//  Doctoraak
//
//  Created by hosam on 3/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

 extension UIView {
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,index:Int? = 0)  {
        
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor], index: 0)
        
      
        
       
    }
    
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
    
    func createMainTextFields(padding:CGFloat? = 16,place:String,type:UIKeyboardType? = .emailAddress,secre:Bool? = false) -> UITextField {
        let t = CustomSkyTextFieldRightPadding(padding: padding ?? 16, height: 50)
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
    
    func createMainTextFieldsWithoutPods(place:String) -> UITextField {
        let t = UITextField()
        t.textAlignment = .center
        t.constrainHeight(constant: 50)
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.placeholder = place
        t.keyboardType = .default
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
//        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
//        t.leftViewMode = .always
//        t.isSecureTextEntry = secre ?? false
        return t
    }
    
//    func createHoursTextFields() -> UITextField {
//        let t = UITextField()
//        t.textAlignment = .center
//        t.layer.borderWidth = 1
//        t.layer.backgroundColor = UIColor.gray.cgColor
//        t.layer.cornerRadius = 16
//        t.clipsToBounds = true
//        t.textColor = .black
//        t.backgroundColor = .white
//        t.text = "00:00"
//        t.constrainHeight(constant: 50)
//        return t
//    }
  
    
}


extension NSMutableAttributedString {
    
    @discardableResult func appendWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString{
        let attrText = NSAttributedString.makeWith(color: color, weight: weight, ofSize:ofSize, text)
        self.append(attrText)
        return self
    }
    
}
extension NSAttributedString {
    
    public static func makeWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString {
        
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: ofSize, weight: weight), NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes:attrs)
    }
}
