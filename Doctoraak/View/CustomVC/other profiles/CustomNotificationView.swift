//
//  CustomNotificationView.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import MOLH
import SDWebImage

class CustomNotificationView: CustomBaseView {
    
    var index:Int?{
        didSet{
            guard let index = index else { return }
            notificationsCollectionVC.index=index
        }
    }
    var doctor:DoctorModel?{
        didSet{
            guard let lab = doctor else { return  }
            
            guard let ll = lab.insuranceCompany?.first(where: {$0.id==1}) else {return}
            let urlString = ll.photo
            guard let url = URL(string: urlString) else { return  }
            drInsuranceImage.sd_setImage(with: url)
            drInsuranceImage.isHide(false)
        }
    }
//    var medicalCenter:DoctorModel?{
//        didSet{
//            guard let lab = medicalCenter else { return  }
//            
//            guard let ll = lab.insuranceCompany?.first(where: {$0.id==1})  else {return}
//            let urlString = ll.photo
//            guard let url = URL(string: urlString) else { return  }
//            drInsuranceImage.sd_setImage(with: url)
//            drInsuranceImage.isHide(false)
//        }
//    }
    
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            
            guard let ll = lab.insuranceCompany.first(where: {$0.id==1}) else {return}
            let urlString = ll.photo
            guard let url = URL(string: urlString) else { return  }
            drInsuranceImage.sd_setImage(with: url)
            drInsuranceImage.isHide(false)
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            guard let ll = phy.insuranceCompany.first(where: {$0.id==1}) else {return}
            let urlString = ll.photo
            guard let url = URL(string: urlString) else { return  }
            drInsuranceImage.sd_setImage(with: url)
            drInsuranceImage.isHide(false)
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            guard let ll = lab.insuranceCompany.first(where: {$0.id==1}) else {return}
            let urlString = ll.photo
            guard let url = URL(string: urlString) else { return  }
            drInsuranceImage.sd_setImage(with: url)
            drInsuranceImage.isHide(false)
            //            customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray=lab
        }
    }
    
    lazy var drImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
        i.contentMode = .scaleToFill
        i.clipsToBounds = true
        i.constrainWidth(constant: 80)
        return i
    }()
    lazy var drInsuranceImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
        i.contentMode = .scaleToFill
        i.clipsToBounds = true
        i.constrainWidth(constant: 80)
        i.isHide(true)
        return i
    }()
    lazy var docotrLabel = UILabel(text: "Doctoraak ".localized, font: .systemFont(ofSize: 20), textColor: .white,textAlignment: .center)
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var sampleRosetaImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "G4-G5 Sample Rx"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var titleLabel = UILabel(text: "Notification".localized, font: .systemFont(ofSize: 30), textColor: .white)
    //    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var notificationsCollectionVC:NotificationsCollectionVC = {
        let v = NotificationsCollectionVC()
        v.handledisplayDOCNotification = {[unowned self] d, inPath,f in
            self.handledisplayDOCNotification?(d,inPath,f)
        }
        v.handledisplayPHYNotification = {[unowned self] d, inPath,f in
            self.handledisplayPHYNotification?(d,inPath,f)
        }
        v.handledisplayLABNotification = {[unowned self] d, inPath,f in
            self.handledisplayLABNotification?(d,inPath,f)
        }
        v.handledisplayRADNotification = {[unowned self] d, inPath,f in
            self.handledisplayRADNotification?(d,inPath,f)
        }
        v.handleRefreshCollection = {[unowned self] in
            self.handleRefreshCollection?()
        }
        return v
    }()
    
    
    
    var handleRefreshCollection:(()->Void)?
    
    var handledisplayDOCNotification:((DOCTORNotificationModel,IndexPath,Bool)->Void)?
    var handledisplayRADNotification:((RadiologyNotificationModel,IndexPath,Bool)->Void)?
    var handledisplayLABNotification:((LABNotificationModel,IndexPath,Bool)->Void)?
    var handledisplayPHYNotification:((PharmacyNotificationModel,IndexPath,Bool)->Void)?
    
    override func setupViews() {
        let sss = getStack(views: drImage,docotrLabel,drInsuranceImage, spacing: 8, distribution: .fill, axis: .horizontal)
        
        [titleLabel,docotrLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        addSubViews(views: LogoImage,backImage,sss,titleLabel,notificationsCollectionVC.view)
        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        //        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        sss.anchor(top: topAnchor, leading: backImage.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 24, bottom: 0, right: 60))
        //               docotrLabel.anchor(top: topAnchor, leading: drImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 65, left: 16, bottom: 0, right: 0))
        //        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        notificationsCollectionVC.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
    }}

