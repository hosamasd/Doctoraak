//
//  NotificationCell.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class NotificationCell: BaseCollectionCell {
    
    lazy var notifyProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 120)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var notifyNameLabel = UILabel(text: "Jana Helal", font: .systemFont(ofSize: 20), textColor: .black)
    
    lazy var notifyDetailsLabel = UILabel(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .left,numberOfLines: 0)
    
    override func setupViews() {
        notifyNameLabel.constrainHeight(constant: 30)
        let s = stack(notifyNameLabel,notifyDetailsLabel)
        
     hstack(notifyProfileImage,s,spacing:8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
    }
}
