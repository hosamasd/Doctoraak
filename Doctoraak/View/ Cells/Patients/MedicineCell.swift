//
//  MedicineCell.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH

class MedicineCell: BaseCollectionCell {
    
    var med:String?{
        didSet{
            guard let med = med else { return  }
            nameLabel.text = med
        }
    }
    
    lazy var nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .left)
    
    lazy var leftImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1758"))
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFit
        return i
    }()
    lazy var closeImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_clear_24px"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    override func setupViews() {
        nameLabel.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        
        hstack(leftImage,nameLabel,closeImage,spacing:8,alignment:.center).withMargins(.init(top: 0, left: 8, bottom: 0, right: 8))
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
}


