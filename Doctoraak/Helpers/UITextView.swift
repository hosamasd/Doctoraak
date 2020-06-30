//
//  UITextView.swift
//  MapKitSwiftUI
//
//  Created by hosam on 6/21/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import Foundation
import UIKit

extension UITextView {
    convenience public init(text: String?, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
           
           let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                                 y: 0.0,
                                                 width: UIScreen.main.bounds.size.width,
                                                 height: 44.0))//1
           let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
           let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
           toolBar.setItems([flexible, barButton], animated: false)//4
           self.inputAccessoryView = toolBar//5
       }
}
