//
//  CustomDoctorHomeView.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomDoctorHomeView: CustomBaseView {
    
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
    lazy var notifyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true

        return i
    }()
    lazy var titleLabel = UILabel(text: "Home", font: .systemFont(ofSize: 30), textColor: .white)
    
    lazy var topDoctorHomeCell:TopDoctorHomeCell = {
        let c=TopDoctorHomeCell()
        c.handleChoosedClinicID = {[unowned self] ind in
            self.handleChoosedClinicID?(ind)
        }
        return c
    }()
    lazy var allButton = createMainButtons(title: "All", color: .black, tags: 4)
    lazy var newButton = createMainButtons(title: "New", color: .black, tags: 1)
    lazy var consultaionButton = createMainButtons(title: "Consultation", color: .black, tags: 2)
    lazy var continueButton = createMainButtons(title: "Continue", color: .black, tags: 3)
    lazy var docotrCollectionView:DoctorHomePatientsCollectionVC = {
        let vc = DoctorHomePatientsCollectionVC()
        vc.handleSelectedIndex = {[unowned self] inde in
            self.handleSelectedIndex?(inde)
        }
        return vc
    }()
    var handleSelectedIndex:((IndexPath)->Void)?
    var handleChoosedClinicID:((Int)->Void)?

    
    override func layoutSubviews() {
        super.layoutSubviews()
        if allButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: allButton)
             allButton.setTitleColor(.white, for: .normal)
        }
//        allButton.applyGradient(colors: [ColorConstants.firstColorBangsegy,ColorConstants.secondColorBangsegy], index: 0)
//        allButton.setTitleColor(.white, for: .normal)
    }
    
    override func setupViews() {
        let ss = getStack(views: allButton,newButton,consultaionButton,continueButton, spacing: 8, distribution: .fillProportionally, axis: .horizontal)
        
        addSubViews(views: LogoImage,listImage,notifyImage,titleLabel,topDoctorHomeCell,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        topDoctorHomeCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
          ss.anchor(top: topDoctorHomeCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))

        docotrCollectionView.view.anchor(top: ss.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))

    }
    
//    func createButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 8
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.clipsToBounds = true
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(color, for: .normal)
//        button.constrainHeight(constant: 50)
//        button.tag = tags ?? 0
//        button.layer.cornerRadius = 16
//        button.backgroundColor = #colorLiteral(red: 0.9214958549, green: 0.9216470122, blue: 0.9214636683, alpha: 1)
////        button.clipsToBounds =
////        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
//        return button
//    }
}
