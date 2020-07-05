////
////  DoctorHeaderNotificationCell.swift
////  Doctoraak
////
////  Created by hosam on 3/25/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//
//class CustomMainDoctorNotificationView: CustomBaseView {
//    
//    lazy var LogoImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
//        i.contentMode = .scaleAspectFill
//        return i
//    }()
//    lazy var listImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "ic_subject_24px"))
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
//        i.isUserInteractionEnabled = true
//        return i
//    }()
//    lazy var notifyImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
//        i.isUserInteractionEnabled = true
//        return i
//    }()
//    lazy var sampleRosetaImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "G4-G5 Sample Rx"))
//        i.contentMode = .scaleAspectFill
//        return i
//    }()
//    lazy var titleLabel = UILabel(text: "Notification".localized, font: .systemFont(ofSize: 30), textColor: .white)
//    lazy var doctorNotificationsVC:DoctorNotificationsVC = {
//        let v = DoctorNotificationsVC()
//        
//        return v
//    }()
//    
//    override func setupViews() {
//        
//        addSubViews(views: LogoImage,listImage,notifyImage,titleLabel,doctorNotificationsVC.view)
//        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
//        
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
//        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
//                notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
//        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
//        doctorNotificationsVC.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
//   }}
