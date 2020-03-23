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
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1)
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1)
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = rect
    }
}


class CustomSegmentedControl: UISegmentedControl {
    
    override func layoutSubviews(){
        
        super.layoutSubviews()
        
        //corner radius
        let cornerRadius = bounds.height/2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: 5, dy: 5)
            foregroundImageView.image = UIImage()
            foregroundImageView.highlightedImage = UIImage()
            foregroundImageView.backgroundColor = UIColor.darkGray
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true
            
            foregroundImageView.layer.cornerRadius = 14
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
        
        
    }
}
