//
//  DoctorLeftMenuCell.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH

class DoctorLeftMenuCell: BaseCollectionCell {
    
    
    
    lazy var Image6:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_phone_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var Label6 = UILabel(text: "Contact Us".localized, font: .systemFont(ofSize: 24), textColor: .black)
    
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? #colorLiteral(red: 0.9296001792, green: 0.9134455323, blue: 0.9993399978, alpha: 1) : .white
            layer.borderColor = isSelected ? UIColor.gray.cgColor : UIColor.clear.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor =  UIColor.clear.cgColor
    }
    
    override func setupViews() {
        if  MOLHLanguage.isRTLLanguage(){
            hstack(Image6,Label6,UIView(),spacing:16,alignment: .center).withMargins(.init(top: 8, left: 8, bottom: 8, right: 0))
        }else {
            hstack(Image6,Label6,spacing:16,alignment: .center).withMargins(.init(top: 8, left: 8, bottom: 8, right: 0))
        }
    }
}
