//
//  RoundedViews.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/16/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}
class RoundedShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
         self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.black.cgColor
        self.clipsToBounds = true
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3
    }
}
class RoundedImageView: UIImageView{
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}
