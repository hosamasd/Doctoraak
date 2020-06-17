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
    
    var phy:PharmacyGetOrdersModel?{
        didSet{
            guard let phy = phy else { return  }
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            sampleRosetaImage.sd_setImage(with: url)
            //            DispatchQueue.main.async {
            self.patientCell.patient = phy.patient
            selectedPatientDataPHYCollectionvc.notificationPHYArray = phy.details
            selectedPatientDataPHYCollectionvc.collectionView.reloadData()
            //            }
        }
    }
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
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
        return i
    }()
    lazy var titleLabel = UILabel(text: "Patient data", font: .systemFont(ofSize: 30), textColor: .white)
    
    lazy var prescriptionLabel = UILabel(text: "Prescription", font: .systemFont(ofSize: 20), textColor: .black)
    lazy var titleSecondLabel = UILabel(text: "Medicines", font: .systemFont(ofSize: 20), textColor: .black)
    lazy var selectedPatientDataPHYCollectionvc :SelectedPatientDataPHYCollectionVC =  {
        let vc = SelectedPatientDataPHYCollectionVC()
        
        return vc
    }()
    
    lazy var okButton = createMainButtons(title: "Accept", color: .white)
    lazy var patientCell:PatientCell = {
        let v = PatientCell()
        v.backgroundColor = .white
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientInSenderAndRemoveOther(sender: okButton)
    }
    
    
    override func setupViews() {
        
        addSubViews(views: LogoImage,backImage,titleLabel,patientCell,prescriptionLabel,sampleRosetaImage,titleSecondLabel,selectedPatientDataPHYCollectionvc.view,okButton)
        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        patientCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        prescriptionLabel.anchor(top: patientCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 32, bottom: 0, right: 32))
        sampleRosetaImage.anchor(top: prescriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 40, right: 32))
        titleSecondLabel.anchor(top: sampleRosetaImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        selectedPatientDataPHYCollectionvc.view.anchor(top: titleSecondLabel.bottomAnchor, leading: leadingAnchor, bottom: okButton.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        //
        okButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}

