//
//  CustomMainHomeView.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage

class CustomMainHomeView: CustomBaseView {
    
    var index:Int? {
        didSet{
            guard let index = index else { return  }
            mainHomePatientsCollectionVC.index=index
        }
    }
    
    
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            //          guard  let urlString = lab.insuranceCompany.first?.photo
            
            //                             customMainHomeLeftView.lab=lab
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            //                             customMainHomeLeftView.phy=phy
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            //            customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray=lab
        }
    }
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var listImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_subject_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        
        return i
    }()
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
    lazy var docotrLabel = UILabel(text: "Doctoraak ".localized, font: .systemFont(ofSize: 20), textColor: .white,textAlignment: .left)
    lazy var notifyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        
        return i
    }()
    lazy var titleLabel = UILabel(text: "Home".localized, font: .systemFont(ofSize: 30), textColor: .white)
    
    lazy var topMainHomeCell = TopMainHomeCell()
    
    lazy var mainHomePatientsCollectionVC:MainHomePatientsCollectionVC = {
        let vc = MainHomePatientsCollectionVC()
        vc.handledisplayRADNotification = {[unowned self] indexPath,ind in
            self.handledisplayRADNotification?(indexPath,ind)
        }
        vc.handledisplayLABNotification = {[unowned self] indexPath,ind in
            self.handledisplayLABNotification?(indexPath,ind)
        }
        vc.handledisplayPHYNotification = {[unowned self] indexPath,ind in
            self.handledisplayPHYNotification?(indexPath,ind)
        }
        vc.handleRefreshCollection = {[unowned self]  in
            self.handleRefreshCollection?()
        }
        
        return vc
    }()
    
    var handledisplayRADNotification:((RadGetOrdersModel,IndexPath)->Void)?
    var handledisplayLABNotification:((LABGetOrdersModel,IndexPath)->Void)?
    var handledisplayPHYNotification:((PharmacyGetOrdersModel,IndexPath)->Void)?
    var handleRefreshCollection:(()->Void)?
    
    override func setupViews() {
        let sss = getStack(views: drImage,docotrLabel,drInsuranceImage, spacing: 8, distribution: .fill, axis: .horizontal)
        
        [titleLabel,docotrLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        addSubViews(views: LogoImage,listImage,notifyImage,sss,titleLabel,topMainHomeCell,mainHomePatientsCollectionVC.view)
        
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        sss.anchor(top: topAnchor, leading: listImage.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 24, bottom: 0, right: 60))
        
        //        drImage.anchor(top: topAnchor, leading: listImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 24, bottom: 0, right: 0))
        //        docotrLabel.anchor(top: topAnchor, leading: drImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 65, left: 16, bottom: 0, right: 0))
        
        
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        topMainHomeCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        
        mainHomePatientsCollectionVC.view.anchor(top: topMainHomeCell.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}
