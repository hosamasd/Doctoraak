//
//  CustomPatientSecondDataView.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomPatientSecondDataView: CustomBaseView {
    
    
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
//        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 150)
        i.clipsToBounds = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Patient data", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var prescriptionLabel = UILabel(text: "Prescription", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var medicineLabel = UILabel(text: "Medicine", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    lazy var medicineCollectionVC:MedicineCollectionVC = {
        let vc = MedicineCollectionVC()
//        vc.view.constrainHeight(constant: 100)
        return vc
    }()
    
    lazy var okButton = createMainButtons(title: "Ok", color: .white)
    lazy var cancelButton = createMainButtons(title: "Cancel", color: .white)
    lazy var patientCell:PatientCell = {
        let v = PatientCell()
        v.backgroundColor = .white
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        okButton.applyGradient(colors: [ColorConstants.firstColorBangsegy,ColorConstants.secondColorBangsegy],index: 0)
        [okButton,cancelButton].forEach({$0.setTitleColor(.white, for: .normal)})
        cancelButton.backgroundColor = #colorLiteral(red: 0.7318444848, green: 0.7521331906, blue: 0.8052451015, alpha: 1)
    }
    
    
    override func setupViews() {
        prescriptionLabel.constrainWidth(constant: 80)
        let ss = getStack(views: okButton,cancelButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        
        addSubViews(views: LogoImage,backImage,titleLabel,patientCell,prescriptionLabel,sampleRosetaImage,medicineLabel,medicineCollectionVC.view,ss)
        
        NSLayoutConstraint.activate([
//            sampleRosetaImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        //        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        patientCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        prescriptionLabel.anchor(top: patientCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 16, left: 32, bottom: 40, right: 32))
        sampleRosetaImage.anchor(top: prescriptionLabel.bottomAnchor, leading: prescriptionLabel.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 0, bottom: 40, right: 32))
         medicineLabel.anchor(top: sampleRosetaImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 40, right: 32))
        medicineCollectionVC.view.anchor(top: medicineLabel.bottomAnchor, leading: leadingAnchor, bottom: ss.topAnchor, trailing: trailingAnchor,padding: .init(top: 8, left: 32, bottom: 40, right: 32))
        //        ss.anchor(top: topDoctorHomeCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        //
        ss.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}

