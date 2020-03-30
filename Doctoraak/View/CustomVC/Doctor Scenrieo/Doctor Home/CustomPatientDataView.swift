//
//  CustomPatientDataView.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomPatientDataView: CustomBaseView {
    
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
        return i
    }()
    lazy var titleLabel = UILabel(text: "Patient data", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var informationLabel = UILabel(text: "Information", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var insuranceLabel = UILabel(text: "Insurance", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var notesLabel = UILabel(text: "Notes", font: .systemFont(ofSize: 16), textColor: .lightGray)

    lazy var okButton = createMainButtons(title: "Ok", color: .white)
    lazy var cancelButton = createMainButtons(title: "Cancel", color: .white)
    lazy var doctorHomePatientsCell:DoctorHomePatientsCell = {
       let v = DoctorHomePatientsCell()
        v.backgroundColor = .white
        v.doctorDateLabel.isHide(true)
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        okButton.applyGradient(colors: [ColorConstants.firstColorBangsegy,ColorConstants.secondColorBangsegy],index: 0)
    [okButton,cancelButton].forEach({$0.setTitleColor(.white, for: .normal)})
        cancelButton.backgroundColor = #colorLiteral(red: 0.7318444848, green: 0.7521331906, blue: 0.8052451015, alpha: 1)
    }
    
    
    override func setupViews() {
        let ss = getStack(views: okButton,cancelButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)

         addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,sampleRosetaImage,ss)
//        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
//        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        doctorHomePatientsCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        sampleRosetaImage.anchor(top: doctorHomePatientsCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 40, right: 32))
//        ss.anchor(top: topDoctorHomeCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
//
        ss.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}
