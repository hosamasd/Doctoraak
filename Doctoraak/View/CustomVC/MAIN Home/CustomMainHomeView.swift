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
            topMainHomeCell.index=index
            let dd:CGFloat = index == 0 || index == 1 ? 180 : 130
            topMainHomeCell.constrainHeight(constant: dd)
            let xx = index == 0 || index == 1 ? false : true
            DispatchQueue.main.async {
                //                self.topDoctorHomeCell.isHide(xx)
                self.tobButtonsStacks.isHide(xx)
                //                self.topMainHomeCell.isHide(!xx)
            }
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
    var medicalCenter:DoctorModel?{
        didSet{
            guard let lab = medicalCenter else { return  }
            
            guard let ll = lab.insuranceCompany?.first(where: {$0.id==1}) else {return}
            let urlString = ll.photo
            guard let url = URL(string: urlString) else { return  }
            drInsuranceImage.sd_setImage(with: url)
            drInsuranceImage.isHide(false)
        }
    }
    
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
            //                             customMainHomeLeftView.phy=phy
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
    //    lazy var topDoctorHomeCell:TopDoctorHomeCell = {
    //        let c=TopDoctorHomeCell()
    //        c.isHide(true)
    //        c.handleChoosedClinicID = {[unowned self] ind in
    //            self.handleChoosedClinicID?(ind)
    //        }
    //        return c
    //    }()
    lazy var topMainHomeCell:TopMainHomeCell = {
        let c = TopMainHomeCell()
        c.handleChoosedClinicID = {[unowned self] ind in
            self.handleChoosedClinicID?(ind)
        }
        return c
    }()
    
    lazy var allButton = createMainButtons(title: "All".localized, color: .black, tags: 4)
    lazy var newButton = createMainButtons(title: "New".localized, color: .black, tags: 1)
    lazy var consultaionButton = createMainButtons(title: "Consultation".localized, color: .black, tags: 2)
    lazy var continueButton = createMainButtons(title: "Follow up".localized, color: .black, tags: 3)
    
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
        vc.handleDoctorSelectedIndex = {[unowned self]  ind in
            self.handleDoctorSelectedIndex?(ind)
        }
        return vc
    }()
    var handleChoosedClinicID:((Int)->Void)?
    var handleDoctorSelectedIndex:((IndexPath)->Void)?
    
    var handledisplayRADNotification:((RadGetOrdersModel,IndexPath)->Void)?
    var handledisplayLABNotification:((LABGetOrdersModel,IndexPath)->Void)?
    var handledisplayPHYNotification:((PharmacyGetOrdersModel,IndexPath)->Void)?
    var handleRefreshCollection:(()->Void)?
    
    lazy var tobButtonsStacks:UIStackView = {
        let ss = getStack(views: allButton,newButton,consultaionButton,continueButton, spacing: 8, distribution: .fillProportionally, axis: .horizontal)
        ss.isHide(true)
        return ss
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if allButton.backgroundColor != nil && index == 0 || index == 1{
            addGradientInSenderAndRemoveOther(sender: allButton)
            allButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func setupViews() {
        let sss = getStack(views: drImage,docotrLabel,drInsuranceImage, spacing: 8, distribution: .fill, axis: .horizontal)
        
        [titleLabel,docotrLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        addSubViews(views: LogoImage,listImage,notifyImage,sss,titleLabel,tobButtonsStacks,topMainHomeCell,mainHomePatientsCollectionVC.view)
        
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        sss.anchor(top: topAnchor, leading: listImage.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 24, bottom: 0, right: 60))
        
        //        tobButtonsStacks.anchor(top: topAnchor, leading: listImage.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 24, bottom: 0, right: 60))
        
        
        
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        topMainHomeCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        //        topDoctorHomeCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        tobButtonsStacks.anchor(top: topMainHomeCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        
        
        mainHomePatientsCollectionVC.view.anchor(top: tobButtonsStacks.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}
