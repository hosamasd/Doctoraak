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
            notifyDetailsLabel.text = "\(title) \n \(order)"
            guard let urlString = notu.order?.photo, let url = URL(string: urlString),let dd = notu.createdAt.toDates() else { return  }
            notifyProfileImage.sd_setImage(with: url)
            let dateString = notu.createdAt.timeAgoSinceDate( dd, currentDate: Date(), numericDates: true)
            notifyDateLabel.text = dateString
        }
    }
    
    var doc:DOCTORNotificationModel? {
        didSet{
            guard let notu = doc else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \(order)"
            guard let urlString = notu.order?.patient.photo, let url = URL(string: urlString),let dd = notu.createdAt.toDates() else { return  }
            notifyProfileImage.sd_setImage(with: url)
            let dateString = notu.createdAt.timeAgoSinceDate( dd, currentDate: Date(), numericDates: true)
            notifyDateLabel.text = dateString
        }
    }
    
    var rad:RadiologyNotificationModel? {
        didSet{
            guard let notu = rad else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \(order)"
            guard let urlString = notu.order?.photo, let url = URL(string: urlString),let dd = notu.createdAt.toDates() else { return  }
            notifyProfileImage.sd_setImage(with: url)
            let dateString = notu.createdAt.timeAgoSinceDate( dd, currentDate: Date(), numericDates: true)
            notifyDateLabel.text = dateString
        }
    }
    
    var lab:LABNotificationModel? {
        didSet{
            guard let notu = lab else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            notifyDetailsLabel.text = "\(title) \n \(order)"
            guard let urlString = notu.order?.photo, let url = URL(string: urlString),let dd = notu.createdAt.toDates() else { return  }
            notifyProfileImage.sd_setImage(with: url)
            let dateString = notu.createdAt.timeAgoSinceDate( dd, currentDate: Date(), numericDates: true)
            notifyDateLabel.text = dateString
        }
    }
    
    lazy var notifyProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var notifyDateLabel = UILabel(text: "12:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    lazy var notifyDetailsLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 0)
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.contentView.layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    
    
    override  func setupViews() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        notifyDateLabel.constrainHeight(constant: 20)
        let s = hstack(UIView(),notifyDateLabel)
        let ff = stack(notifyDetailsLabel,s,spacing:16)
        
        let d = stack(notifyProfileImage,UIView()).padTop(16)
        
        hstack(d,ff,spacing:16).withMargins(.init(top: 0, left: 16, bottom: 8, right: 8))
        
    }
}


//    lazy var notifyProfileImage:UIImageView = {
//        let i = UIImageView(backgroundColor: .gray)
//        i.constrainWidth(constant: 120)
//        i.layer.cornerRadius = 8
//        i.clipsToBounds = true
//        return i
//    }()
//    lazy var notifyNameLabel = UILabel(text: "Jana Helal", font: .systemFont(ofSize: 20), textColor: .black)
//
//    lazy var notifyDetailsLabel = UILabel(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .left,numberOfLines: 0)
//
//    override func setupViews() {
//        notifyNameLabel.constrainHeight(constant: 30)
//        let s = stack(notifyNameLabel,notifyDetailsLabel)
//
//     hstack(notifyProfileImage,s,spacing:8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
//
//    }
//}
