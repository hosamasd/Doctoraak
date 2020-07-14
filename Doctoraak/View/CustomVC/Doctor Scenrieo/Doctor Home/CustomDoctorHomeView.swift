//
//  CustomDoctorHomeView.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH

class CustomDoctorHomeView: CustomBaseView {
    
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
    }
    
    override func setupViews() {
        [docotrLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        let ss = getStack(views: allButton,newButton,consultaionButton,continueButton, spacing: 8, distribution: .fillProportionally, axis: .horizontal)
        
        addSubViews(views: LogoImage,listImage,notifyImage,ss,titleLabel,topDoctorHomeCell,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        
        ss.anchor(top: topAnchor, leading: listImage.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 24, bottom: 0, right: 60))
        //        docotrLabel.anchor(top: topAnchor, leading: drImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 65, left: 16, bottom: 0, right: 0))
        
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        topDoctorHomeCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        ss.anchor(top: topDoctorHomeCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        
        docotrCollectionView.view.anchor(top: ss.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}
