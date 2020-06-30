//
//  NotificationCell.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage

class NotificationCell: BaseCollectionCell {
    
    var phy:PharmacyNotificationModel? {
        didSet{
            guard let notu = phy else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \t \(order)"
        }
    }
    
    var doc:DOCTORNotificationModel? {
        didSet{
            guard let notu = doc else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \(order)"
        }
    }
    
    var rad:RadiologyNotificationModel? {
        didSet{
            guard let notu = rad else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \(order)"
        }
    }
    
    var lab:LABNotificationModel? {
        didSet{
            guard let notu = lab else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \(order)"
        }
    }
    
    lazy var notifyProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    
    lazy var notifyDetailsLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow(opacity: 10, radius: 50, offset: .zero, color: .red)

//        self.layer.cornerRadius = 5
//        self.contentView.layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    
    
    override  func setupViews() {
        notifyDetailsLabel.textAlignment=MOLHLanguage.isRTLLanguage() ? .right : .left
        layer.cornerRadius = 16
        clipsToBounds = true
        let d = stack(notifyProfileImage,UIView()).padTop(16)
        
        hstack(d,notifyDetailsLabel,spacing:16).withMargins(.init(top: 0, left: 16, bottom: 8, right: 8))
        
    }
}
