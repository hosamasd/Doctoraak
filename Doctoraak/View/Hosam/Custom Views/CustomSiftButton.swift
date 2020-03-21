//
//  CustomSiftButton.swift
//  Doctoraak
//
//  Created by hosam on 3/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomSiftButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        let leftColor = #colorLiteral(red: 0.4878966212, green: 0.2267611921, blue: 1, alpha: 1)
        let rightColor = #colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1)
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
//        layer.cornerRadius = rect.height / 2
//        clipsToBounds = true
        
        gradientLayer.frame = rect
    }
    
}
