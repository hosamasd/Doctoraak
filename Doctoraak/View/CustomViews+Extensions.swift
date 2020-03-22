//
//  CustomViews.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  setGradientColor()
        
    }

}

class ButtonGradient : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        //layer.cornerRadius = CGFloat(frame.width / 20)
        
        let color0 = UIColor(red:170/255, green:125/255, blue: 250/255, alpha:1.0).cgColor

        let color1 = UIColor(red:120/255, green:55/255, blue: 240/255, alpha:5.0).cgColor
         let color2 = UIColor(red:110/255, green:64/255, blue:252/255, alpha:1.0).cgColor
        layer.locations = [0.5, 1.0]
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 0.5, y: 0.5)
        layer.colors = [color2,color0,color1]
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.insertSublayer(layer, at: 0)
    }
}
