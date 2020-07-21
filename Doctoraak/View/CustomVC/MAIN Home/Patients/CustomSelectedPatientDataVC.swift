//
//  CustomSelectedPatientDataVC.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SDWebImage
import MOLH

class CustomSelectedPatientDataVC: CustomBaseView {
    
    
    
    var index:Int?  {
        didSet{
            guard let index=index else {return}
            selectedPatientDataPHYCollectionvc.index=index
        }
    }
    
    
    //    var phy:PharmacyOrderModel?{
    //           didSet{
    //               guard let phy = phy else { return  }
    //               let urlString = phy.photo
    //               guard let url = URL(string: urlString) else { return  }
    //               sampleRosetaImage.sd_setImage(with: url)
    //               //            DispatchQueue.main.async {
    //               self.patientCell.patient = phy.patient
    //               let acccepts = phy.accept == "0" ? false : true
    //               bottomStack.isHide(acccepts)
    //               selectedPatientDataPHYCollectionvc.notificationPHYArray = phy.details
    //               selectedPatientDataPHYCollectionvc.collectionView.reloadData()
    //           }
    //       }
    var phy:PharmacyGetOrdersModel?{
        didSet{
            guard let phy = phy else { return  }
            
            //            DispatchQueue.main.async {
            self.patientCell.patient = phy.patient
//            let itemFound = accepetArrayPHY.contains(phy.id)
//            bottomStack.isHide(itemFound)
            
            selectedPatientDataPHYCollectionvc.notificationPHYArray = phy.details
            
            selectedPatientDataPHYCollectionvc.collectionView.reloadData()
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            sampleRosetaImage.sd_setImage(with: url)
        }
    }
    
    var rad:RadGetOrdersModel?{
        didSet{
            guard let phy = rad else { return  }
            
            //            DispatchQueue.main.async {
            self.patientCell.patient = phy.patient
//            let itemFound = accepetArrayRAD.contains(phy.id)
//            bottomStack.isHide(itemFound)
            selectedPatientDataPHYCollectionvc.notificationRADArray = phy.details
            selectedPatientDataPHYCollectionvc.collectionView.reloadData()
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            sampleRosetaImage.sd_setImage(with: url)
        }
    }
    
    var radOrders:RadiologyOrderModel?{
        didSet{
            guard let phy = radOrders else { return  }
            
            //            DispatchQueue.main.async {
            self.patientCell.patient = phy.patient
//            let itemFound = accepetArrayRAD.contains(phy.id)
//            bottomStack.isHide(itemFound)
            selectedPatientDataPHYCollectionvc.notificationRADArray = phy.details
            selectedPatientDataPHYCollectionvc.collectionView.reloadData()
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            sampleRosetaImage.sd_setImage(with: url)
        }
    }
    
    var lab:LABGetOrdersModel?{
        didSet{
            guard let phy = lab else { return  }
            
            self.patientCell.patient = phy.patient
            selectedPatientDataPHYCollectionvc.notificationLABArray = phy.details
            
            selectedPatientDataPHYCollectionvc.collectionView.reloadData()
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            sampleRosetaImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "G4-G5 Sample Rx"), options: .lowPriority)
        }
    }
    
    var labOrder:LABOrderModel?{
        didSet{
            guard let phy = labOrder else { return  }
            self.patientCell.patientLab = phy.patient
            selectedPatientDataPHYCollectionvc.notificationLABArray = phy.details
            selectedPatientDataPHYCollectionvc.collectionView.reloadData()
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            sampleRosetaImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "G4-G5 Sample Rx"), options: .lowPriority)
        }
    }
    
    
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
        i.clipsToBounds = true
        i.constrainHeight(constant: 120)
        i.isUserInteractionEnabled=true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Patient data".localized, font: .systemFont(ofSize: 30), textColor: .white)
    
    lazy var prescriptionLabel = UILabel(text: "Prescription".localized, font: .systemFont(ofSize: 20), textColor: .black)
    lazy var titleSecondLabel = UILabel(text: "Medicines".localized, font: .systemFont(ofSize: 20), textColor: .black)
    lazy var selectedPatientDataPHYCollectionvc :SelectedPatientDataPHYCollectionVC =  {
        let vc = SelectedPatientDataPHYCollectionVC()
        return vc
    }()
    
    lazy var okButton=createButtonsBottom(title: "Accept".localized, bg: .green)
    lazy var cancelButton=createButtonsBottom(title: "Refuse".localized, bg: .red)
    lazy var bottomStack:UIStackView = {
        let sta = getStack(views: okButton,cancelButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        return sta
    }()
    
    lazy var patientCell:PatientCell = {
        let v = PatientCell()
        v.backgroundColor = .white
        return v
    }()
    
    //    var isAcceptOrRefused:Bool = false {
    //        didSet {
    //            bottomStack.isHide(isAcceptOrRefused)
    //        }
    //    }
    var accepetArrayLAB:[Int]?  {
        didSet{
            guard let a = accepetArrayLAB else { return }
            let itemFound = a.contains(labOrder?.id ?? -1)
//            DispatchQueue.main.async {
                self.bottomStack.isHide(itemFound)
//            }
        }
    }
    var accepetArrayRAD :[Int]?  {
        didSet{
            guard let a = accepetArrayRAD else { return }
            let itemFound = a.contains(radOrders?.id ?? -1)
            bottomStack.isHide(itemFound)
        }
    }
    var accepetArrayPHY :[Int]?  {
        didSet{
            guard let a = accepetArrayPHY else { return }
            let itemFound = a.contains(phy?.id ?? -1)
            bottomStack.isHide(itemFound)
        }
    }
   
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientInSenderAndRemoveOther(sender: okButton)
    }
    
    
    override func setupViews() {
        [titleLabel,prescriptionLabel,titleSecondLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        addSubViews(views: LogoImage,backImage,titleLabel,patientCell,prescriptionLabel,sampleRosetaImage,titleSecondLabel,selectedPatientDataPHYCollectionvc.view,bottomStack)
        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        patientCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        prescriptionLabel.anchor(top: patientCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 32, bottom: 0, right: 32))
        sampleRosetaImage.anchor(top: prescriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 40, right: 32))
        titleSecondLabel.anchor(top: sampleRosetaImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        selectedPatientDataPHYCollectionvc.view.anchor(top: titleSecondLabel.bottomAnchor, leading: leadingAnchor, bottom: okButton.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        //
        bottomStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
    
    func createButtonsBottom(title:String,bg:UIColor) -> UIButton {
        let b = UIButton(title: title, titleColor: .white, font: .systemFont(ofSize: 18), backgroundColor: bg, target: self, action: nil)
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 16
        b.clipsToBounds=true
        return b
    }
}

